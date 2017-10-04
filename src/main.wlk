class Villano {
	var ejercito = []
	
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