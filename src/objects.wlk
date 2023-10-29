class Casa{
	var property confortBase = 10
	const ocupantes =#{}
	method confortExtra(persona){}
	method aniadirOcupante(ocupante){
		ocupantes.add(ocupante)
	}
	method quitarOcupante(ocupante){
		ocupantes.remove(ocupante)
	}

	
	method cantidadDeOcupantes() = ocupantes.size()
}

class HabitacionGeneral inherits Casa{
	
}

class Dormitorio inherits Casa{ 
	override method aniadirOcupante(ocupante){
		if (ocupante.duermeEnDormitorio(self)){ocupantes.add(ocupante)}
	}
	override method confortExtra(ocupante){confortBase += 10 / self.cantidadDeOcupantes()}
}

class Banio inherits Casa{
	method hayNinio() = ocupantes.find{p => p.edad() <= 4}
	override method aniadirOcupante(ocupante){
		if(self.hayNinio()){
			ocupantes.add(ocupante)
		}
	}

	override method confortExtra(persona){
		if (persona.edad()<=4){
			confortBase += 2
		}
		else{
			confortBase += 4
		}
	}
}

class Cocina inherits Casa{
	var property metrosCuadrados = 10
	method hayPersonaQueSabeCocinar() = ocupantes.find{o => o.tieneHabilidadDeCocina()}
	
	override method aniadirOcupante(ocupante){
		if (not self.hayPersonaQueSabeCocinar() and ocupante.tieneHabilidadDeCocina()) {
			ocupantes.add(ocupante)
		}
		if(not ocupante.tieneHabilidadDeCocina()){
			ocupantes.add(ocupante)
		}
	}
	
		override method confortExtra(persona){
		if (persona.tieneHabilidadDeCocina()){
			confortBase += metrosCuadrados
		}
		
	}
}

class Familia{
	const integrantes = #{}
	method aniadirIntegrante(persona){integrantes.add(persona)}
	method confortTotal() = integrantes.sum{o=> o.confort()}
	method confortPromedio() = self.confortTotal() / self.cantidadDeIntegrantes()
	method cantidadDeIntegrantes() = integrantes.size()
	method noEstaVacia() = self.cantidadDeIntegrantes()>=1
	method integranteMasViejo() = integrantes.max{o => o.edad()}
}

class Persona inherits Familia{
	var property edad = 0
	var property tieneHabilidadDeCocina = false
	var property habitacionActual
	var property confort = 0

	method duermeEnDormitorio(dormitorio) 
	method ocuparHabitacion(habitacion){
		habitacionActual.quitarOcupante(self)
		habitacion.aniadirOcupante(self)
		habitacionActual = habitacion
		confort = habitacion.confortExtra()
	}
	method aprenderCocina() = tieneHabilidadDeCocina 
}