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
		return ejercito.add(new Minion(unNombre,amarillo,5,new Arma("rayo congelante",10)))
		
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

	method planificarMaldad(unaMaldad) {
		unaMaldad.aplicarCambios(self.ejercito(),self.ciudad())
		
	}
	
	method minionMasUtil() {
		return self.ejercito().max({minion => minion.maldades().size()})
	}
	
	method minionsMasInutiles() {
		return self.ejercito().filter({minion => minion.maldades().isEmpty()})
	}
	
}

class Minion {
	var color
	var nombre
	var armas = []
	var cantBananas
	var maldades = []
	
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
	
	method maldades() {
		return maldades
	}
	
	method agregarMaldad(unaMaldad) {
		maldades.add(unaMaldad)
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
	
	method color() {
		return color
	}
	
	method absorberSueroMutante() {
		self.color().aplicarCambio(self)
	}
	
	method esPeligroso() {
		return self.color().esPeligrosoMinion(self)
	}
	
	method potenciaArmaMasPotente() {
		return self.armas().map({a => a.potencia()}).max()
	}
	
	method nivelConcentracion() {
		return self.color().nivelConcentracionPorColor(self)
	}
	
	method tieneEstaArma(nombreDeArma){
		return self.armas().map({a=>a.nombreArma()}).contains(nombreDeArma)
	}
	
	method esBienAlimentado(){
		return self.bananas() > 99
	}
	
	
}

object amarillo {
	var nombreColor = "amarillo"
	
	method esPeligrosoMinion(unMinion) {
		return unMinion.armas().size() > 2
	}
	
	method nombreColor() {
		return nombreColor
	}
	
	method aplicarCambio(unMinion) {
		unMinion.color(violeta)
		unMinion.armas().clear()
		unMinion.bananas(-1)
	}
	
	method nivelConcentracionPorColor(unMinion) {
		return unMinion.potenciaArmaMasPotente() + unMinion.bananas()
	}	

}

object violeta {
	var nombreColor = "violeta"
	
	method esPeligrosoMinion(unMinion) {
		return true
	}
	
	method nombreColor() {
		return nombreColor
	}
	
	method aplicarCambio(unMinion) {
		unMinion.color(amarillo)
		unMinion.bananas(-1)
		
	}
	
	method nivelConcentracionPorColor(unMinion) {
		return unMinion.bananas()
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
		return minions.filter({m => m.tieneEstaArma("rayo congelante") && (m.nivelConcentracion() > self.concentracionRequerida())})
	}
	
	method concentracionRequerida() {
		return concentracion
	}
	
	method aplicarCambios(ejercitoVillano,unaCiudad) {
		if(self.minionsSeleccionados(ejercitoVillano).isEmpty()) {
			error.throwWithMessage("No hay minions que pueden hacer la maldad")
		}
		unaCiudad.temperatura(-30)
		self.minionsSeleccionados(ejercitoVillano).forEach({m => m.bananas(10)})
		self.minionsSeleccionados(ejercitoVillano).forEach({m => m.agregarMaldad(self)})
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
		self.minionsSeleccionados(minions).forEach({m => m.bananas(10)})
		self.minionsSeleccionados(minions).forEach({m => m.agregarMaldad(self)})
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
		self.minionsSeleccionados(minions).forEach({m => m.agregarMaldad(self)})
		
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
		self.minionsSeleccionados(minions).forEach({m => m.agregarMaldad(self)})
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