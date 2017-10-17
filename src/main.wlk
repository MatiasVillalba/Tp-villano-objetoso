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
		unMinion.sumarBananas(unaCantidadDeBananas)
	}

	method planificarMaldad(unaMaldad) {
		unaMaldad.modificarCiudad(self.minionsQuePuedenHacerMaldad(unaMaldad),self.ciudad())
		
	}
	
	method minionMasUtil() {
		return self.ejercito().max({minion => minion.maldades().size()})
	}
	
	method minionsMasInutiles() {
		return self.ejercito().filter({minion => minion.maldades().isEmpty()})
	}
	
	method minionsQuePuedenHacerMaldad(unaMaldad) {
		return self.ejercito().filter({m => unaMaldad.cumpleRequisito(m)})
	}
	
}

class Minion {
	var color
	var nombre
	var armas = []
	var cantBananas
	var maldades = []
	
	constructor(unNombre,unColor,bananas,unaArma) {
		nombre = unNombre
		armas.add(unaArma)
		cantBananas = bananas
		color = unColor
	}
	
	method nombre() {
		return nombre
	}
	
	method bananas() {
		return cantBananas
	}
	
	method restarBananas(unaCantidadDeBananas) {
		cantBananas = self.bananas() - unaCantidadDeBananas
	}
	
	method sumarBananas(unaCantidadDeBananas) {
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
		self.color().transformarMinion(self)
	}
	
	method esPeligroso() {
		return self.color().esPeligrosoMinion(self)
	}
	
	method potenciaArmaMasPotente() {
		return self.armas().max({a => a.potencia()})
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
	
	method esPeligrosoMinion(unMinion) {
		return unMinion.armas().size() > 2
	}

	method transformarMinion(unMinion) {
		unMinion.color(violeta)
		unMinion.armas().clear()
		unMinion.restarBananas(1)
	}
	
	method nivelConcentracionPorColor(unMinion) {
		return unMinion.potenciaArmaMasPotente().potencia() + unMinion.bananas()
	}	

}

object violeta {
	
	method esPeligrosoMinion(unMinion) {
		return true
	}
	
	method transformarMinion(unMinion) {
		unMinion.color(amarillo)
		unMinion.restarBananas(1)
		
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
	
	method cumpleRequisito(unMinion) {
		return unMinion.tieneEstaArma("rayo congelante") && (unMinion.nivelConcentracion() > self.concentracionRequerida())
	}
	
	method concentracionRequerida() {
		return concentracion
	}
	
	method modificarCiudad(minions,unaCiudad) {
		if(minions.isEmpty()) {
			error.throwWithMessage("No hay minions que pueden hacer la maldad")
		}
		unaCiudad.temperatura(-30)
		minions.forEach({m => m.sumarBananas(10)})
		minions.forEach({m => m.agregarMaldad(self)})
	}
}

class Piramide {
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
	
	method cumpleRequisito(unMinion) {
		return unMinion.nivelConcentracion() > self.concentracionRequerida() && unMinion.esPeligroso()
	}

	method modificarCiudad(minions,unaCiudad) {
		if(unaCiudad.poseeEsteObjetoLaCiudad(self).negate()){
			throw new SinElementosException("No se puede realizar este robo")
		}
		if(minions.isEmpty()) {
			error.throwWithMessage("No hay minions que pueden hacer la maldad")
		}
		minions.forEach({m => m.sumarBananas(10)})
		minions.forEach({m => m.agregarMaldad(self)})
		unaCiudad.eliminarObjeto(self)
	}
	
}

object sueroMutante {

	method cumpleRequisito(unMinion) {
		return unMinion.esPeligroso() && unMinion.esBienAlimentado() && unMinion.nivelConcentracion() > 23
	}	
	
	method modificarCiudad(minions,unaCiudad) {
		if(unaCiudad.poseeEsteObjetoLaCiudad(self).negate()){
			throw new SinElementosException("No se puede realizar este robo")
		}
		if(minions.isEmpty()) {
			error.throwWithMessage("No hay minions que pueden hacer la maldad")
		}
		unaCiudad.eliminarObjeto(self)
		minions.forEach({m => m.absorberSueroMutante()})
		minions.forEach({m => m.agregarMaldad(self)})
	}
	
}

object luna {

	method cumpleRequisito(unMinion) {
		return unMinion.esPeligroso() && unMinion.tieneEstaArma("rayo encogedor")
	}	
	
	method modificarCiudad(minions,unaCiudad){
		if(minions.isEmpty()) {
			error.throwWithMessage("No hay minions que pueden hacer la maldad")
		}
		unaCiudad.eliminarObjeto(self)
		minions.forEach({m => m.agregarArma(new Arma("rayo congelante",10))})
		minions.forEach({m => m.agregarMaldad(self)})
	}
	
}

class Ciudad {
	var temperatura
	var objetosQuePosee = []
	
	constructor(unaTemperatura,objeto) {
		temperatura = unaTemperatura
		objetosQuePosee.add(objeto)
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
		objetosQuePosee.remove(obj)
	}
	
	method poseeEsteObjetoLaCiudad(objeto){
		return self.objetosQuePosee().contains(objeto)
	}
}