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
		return ejercito.add(new Minion(unNombre,"amarillo",5,new Arma("rayo congelante",10)))
		
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
	
	method planificarMaldad(unaMaldad) {
		unaMaldad.aplicarCambios(self.ejercito().filter({e => e.tieneRayoCongelante() && (e.nivelConcentracion() > unaMaldad.concentracionRequerida())}),self.ciudad())
		
	}
	
}

class Minion {
	var armas
	var cantBananas
	var nombre
	var color
	
	constructor(unNombre,unColor,bananas,unasArmas) {
		nombre = unNombre
		cantBananas = bananas
		color = unColor
		armas = unasArmas
	}
	
	method nombre() {
		return nombre
	}
	
	method esPeligroso() {
		return armas.size() > 2 || self.color() == "violeta"
	}
	
	method alimentarse(unaCantidadDeBananas) {
		cantBananas = self.bananas() + unaCantidadDeBananas
	}
	
	method restarBanana(unaCantidad) {
		cantBananas = self.bananas() - unaCantidad
	}
	
	method bananas() {
		return cantBananas
	}
	
	method color(unColor) {
		color = unColor
	}
	
	method color() {
		return color
	}
	
	method agregarArma(unArma) {
		self.armas().add(unArma)
	}
	
	method armas() {
		return armas
	}
	
	method potenciaArmaMasPotente() {
		return self.armas().map({a => a.potencia()}).max()
	}
	
	method nivelConcentracion() {
		if(self.color() == "amarillo") {
			return self.potenciaArmaMasPotente() + self.bananas()
		}
		else {
			return self.bananas()
		}
	}
	
	method absorberSueroMutante() {
		if(self.color() == "amarillo") {
			self.color("violeta")
			self.armas().clear()
			self.restarBanana(1)
		}
		if(self.color() == "violeta") {
			self.color("amarillo")
			self.restarBanana(1)
		}
		
	}
	
	method tieneRayoCongelante() {
		return self.armas().map({a => a.nombreArma()}).contains("rayo congelante")
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