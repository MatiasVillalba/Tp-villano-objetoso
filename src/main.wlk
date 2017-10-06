class SinElementosException inherits Exception {}

class Villano {
	var ejercito = []
	var ciudad
		
	method ciudad() {
		return ciudad
	}
	
	method ciudad(unaCiudad) {
		ciudad = unaCiudad
	}
	
	method nuevoMinion(unNombre) {
		return ejercito.add(new MinionAmarillo(unNombre,5,new Arma("rayo congelante",10)))
		
	}
	
	method otorgarArma(unMinion,unArma) {
		unMinion.agregarArma(unArma)
	}
	
	method ejercito() {
		return ejercito
	}
	
	method agregarMinion(unMinion) {
		self.ejercito().add(unMinion)
	}
	
	method alimentarA(unMinion,unaCantidadDeBananas) {
		unMinion.bananas(unaCantidadDeBananas)
	}
	
	/*method planificarMaldadCongelar(unaMaldad) {
		unaMaldad.aplicarCambios(self.ejercito().filter({e => e.tieneRayoCongelante() && (e.nivelConcentracion() > unaMaldad.concentracionRequerida())}),self.ciudad())
		
	}*/
	
	/*method planificarMaldadRobar(unaMaldad,unObjeto) {
		unaMaldad.aplicarCambios(self.ejercito().filter({e => e.esPeligroso()}))
	}*/
	
	method planificarMaldad(unaMaldad) {
		unaMaldad.aplicarCambios(self.ejercito(),self.ciudad())
		
	}
	
}

class Minion {
	var color
	var nombre
	var armas = []
	var cantBananas
	var tipoMinion
	
	constructor(unNombre,unColor,bananas,unasArmas) {
		nombre = unNombre
		armas = unasArmas
		cantBananas = bananas
		color = unColor
	}
	
	method nombre() {
		return nombre
	}
	
	method bananas() {
		return cantBananas
	}
	
	method bananas(unaCantidadDeBananas) {
		cantBananas = self.bananas() + unaCantidadDeBananas
	}
	
	method agregarArma(unArma) {
		self.armas().add(unArma)
	}
	
	method armas() {
		return armas
	}
	
	method color(unColor) {
		color = unColor
	}
	
	method minionActual(unMinion) {
		tipoMinion = unMinion
	}
	
	method minionActual() {
		 return tipoMinion
	}
	
	method color() {
		return color
	}
	
}

class MinionAmarillo inherits Minion {
	
	constructor(unNombre,bananas,unasArmas) = super(unNombre,"amarillo",bananas,unasArmas)
	
	method esPeligroso() {
		return armas.size() > 2
	}
	
	method potenciaArmaMasPotente() {
		return self.armas().map({a => a.potencia()}).max()
	}
	
	method nivelConcentracion() {
		return self.potenciaArmaMasPotente() + self.bananas()
	}
	
	method absorberSueroMutante() {
		self.armas().clear()
		self.minionActual(new MinionVioleta(self.nombre(),(self.bananas() - 1),self.armas()))
	}	
	
	method tieneRayoCongelante() {
		return self.armas().map({a => a.nombreArma()}).contains("rayo congelante")
	}
}

class MinionVioleta inherits Minion {
	
	constructor(unNombre,bananas,unasArmas) = super(unNombre,"violeta",bananas,unasArmas)
	
	method esPeligroso() {
		return true
	}
	
	method absorberSueroMutante() {
		self.minionActual(new MinionAmarillo(self.nombre(),(self.bananas() - 1),self.armas()))
	}

}


class Arma {
	var nombre
	var potencia
	
	constructor(unNombre,unaPotencia) {
		nombre = unNombre
		potencia = unaPotencia
	}
	
	method potencia() {
		return potencia
	}
	
	method nombreArma() {
		return nombre
	}
}

class Congelar {
	var concentracion
	
	constructor(unaConcentracion) {
		concentracion = unaConcentracion
	}
	
	method concentracionRequerida(unaConcentracion) {
		concentracion = unaConcentracion
	}
	
	method minionsSeleccionados(minions){
		return minions.filter({e => e.tieneRayoCongelante() && (e.nivelConcentracion() > self.concentracionRequerida())})
	}
	
	method concentracionRequerida() {
		return concentracion
	}
	
	method aplicarCambios(minionsAceptados,unaCiudad) {
		if(minionsAceptados.isEmpty()) {
			error.throwWithMessage("No hay minions que pueden hacer la maldad")
		}
		unaCiudad.temperatura(-30)
		minionsAceptados.forEach({m => m.bananas(10)})
	}
}

class Robar {
	
	var minionsPeligrosos=[]
	
	method minionsPeligrosos() = minionsPeligrosos
	
	method minionPeligrosos(minions){
		return minions.filter({m=>m.esPeligroso()})
		
	}	
	
}

class Piramide inherits Robar{
	var altura
	
	constructor(unaAltura) {
		altura = unaAltura
	}
	
	method altura() {
		return altura
	}
	
	method concentracionRequerida() {
		return self.altura() / 2
	}
	
	method minionsSeleccionados(minions){
		return self.minionPeligrosos(minions).filter({m=>m.nivelConcentracion() > self.concentracionRequerida()})	
	}
	
	method aplicarCambios(minions,unaCiudad) {
		if(self.minionsSeleccionados(minions).isEmpty()) {
			error.throwWithMessage("No hay minions que pueden hacer la maldad")
		}
		self.minionsSeleccionados(minions).forEach({m => m.alimentarse(10)})
		unaCiudad.eliminarObjeto("Piramide")
	}
	
}

object sueroMutante inherits Robar{
	
	method minionsSeleccionados(minions){
		return self.minionPeligrosos(minions).filter({m=>m.esBienAlimentado() && (m.nivelConcentracion() > 23)})	
	}	
	
	method aplicarCambios(minions,unaCiudad){
		if(self.minionsSeleccionados(minions).isEmpty()) {
			error.throwWithMessage("No hay minions que pueden hacer la maldad")
		}
		unaCiudad.eliminarObjeto("Suero")
		self.minionsSeleccionados(minions).forEach({m => m.absorberSueroMutante()})
		
	}
	
}

object luna inherits Robar {
	
	method minionsSeleccionados(minions){
		return self.minionPeligrosos(minions).filter({m=>m.tieneEstaArma("rayo encogedor")})	
	}	
	
	method aplicarCambios(minions,unaCiudad){
		if(self.minionsSeleccionados(minions).isEmpty()) {
			error.throwWithMessage("No hay minions que pueden hacer la maldad")
		}
		unaCiudad.eliminarObjeto("Luna")
		self.minionsSeleccionados(minions).forEach({m => m.agregarArma(new Arma("rayo congelante",10))})
		
	}
	
}

class Ciudad {
	var temperatura
	var objetosQuePosee = []
	
	
	constructor(unaTemperatura,objeto) {
		temperatura = unaTemperatura
		objetosQuePosee = objeto
	}
	
	method temperatura(unaTemperatura) {
		temperatura = self.temperatura() + unaTemperatura
	}
	
	method temperatura() {
		return temperatura
	}
	
	method agregarObjeto(obj){
		objetosQuePosee.add(obj)
	}
	
	method objetosQuePosee() = objetosQuePosee
	
	method eliminarObjeto(obj){
		if(objetosQuePosee.isEmpty()){
			throw new SinElementosException("Esta ciudad no tiene elementos para robar")
		}
		objetosQuePosee.remove(obj)
	}
}