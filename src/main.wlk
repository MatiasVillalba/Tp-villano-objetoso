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
		unMinion.alimentarse(unaCantidadDeBananas)
	}
	
	method planificarMaldadCongelar(unaMaldad) {
		unaMaldad.aplicarCambios(self.ejercito().filter({e => e.tieneRayoCongelante() && (e.nivelConcentracion() > unaMaldad.concentracionRequerida())}),self.ciudad())
		
	}
	
	method planificarMaldadRobar(unaMaldad,unObjeto) {
		unaMaldad.aplicarCambios(self.ejercito().filter({e => e.esPeligroso()}))
	}
	
}

class Minion {
	var color
	var nombre
	var armas = []
	var cantBananas
	
	constructor(unNombre,bananas,unasArmas,unColor) {
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
	
	method alimentarse(unaCantidadDeBananas) {
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
	
	method color() {
		return color
	}
	
}

class MinionAmarillo inherits Minion {
	
	constructor(unNombre,bananas,unasArmas) = super(unNombre,bananas,unasArmas,"amarillo")
	
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
			self.color("violeta")
			return new MinionVioleta(self.nombre(),(self.bananas() - 1),self.armas().clear())
	}	
	
	method tieneRayoCongelante() {
		return self.armas().map({a => a.nombreArma()}).contains("rayo congelante")
	}
}

class MinionVioleta inherits Minion {
	
	constructor(unNombre,bananas,unasArmas) = super(unNombre,bananas,unasArmas,"violeta")
	
	method esPeligroso() {
		return true
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
	
	method concentracionRequerida() {
		return concentracion
	}
	
	method aplicarCambios(minionsAceptados,unaCiudad) {
		if(minionsAceptados.isEmpty()) {
			error.throwWithMessage("No hay minions que pueden hacer la maldad")
		}
		unaCiudad.temperatura(-30)
		minionsAceptados.forEach({m => m.alimentarse(10)})
	}
}

class Robar {
	
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
	
	method aplicarEfecto(minions) {
		minions.forEach({m => m.alimentarse(10)})
	}
	
}

object sueroMutante {
	
}

object luna {
	
}

class Ciudad {
	var temperatura
	
	constructor(unaTemperatura) {
		temperatura = unaTemperatura
	}
	
	method temperatura(unaTemperatura) {
		temperatura = self.temperatura() + unaTemperatura
	}
	
	method temperatura() {
		return temperatura
	}
}