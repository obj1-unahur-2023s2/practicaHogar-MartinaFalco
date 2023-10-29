class Casa{
	const habitaciones =#{}
	method aniadirHabitacion(habitacion) = habitaciones.add(habitacion)
}

class HabitacionGeneral{
	const confortBase = 10
	const ocupantes =#{}
	method confortExtra(persona)
	method aniadirOcupante(ocupante){
		ocupantes.add(ocupante)
	}
	method quitarOcupante(ocupante){
		ocupantes.remove(ocupante)
	}
		
	method cantidadDeOcupantes() = ocupantes.size()
}

class Dormitorio inherits HabitacionGeneral{
	var property familia 
	override method aniadirOcupante(ocupante){
		if (ocupante.dormitorio() == self or(not ocupante.dormitorio() == self and self.estanTodos()) ){ocupantes.add(ocupante)}
	}	
	method estanTodos() = familia.personasQueDuermenEnDormitorio(self) == self.ocupantesQueDuermenEnDormitorio()
	method ocupantesQueDuermenEnDormitorio() = ocupantes.intersection{o=> o.personasQueDuermenEnDormitorio(self)}
	
	
	override method confortExtra(ocupante) = 
	if (ocupante.duermeEnDormitorio(self)){confortBase + 10 / self.cantidadDeOcupantes()}
	else{
		confortBase
	}
}

class Banio inherits HabitacionGeneral{
	method hayNinio() = ocupantes.any{p => p.edad() <= 4}
	override method aniadirOcupante(ocupante){
		if(self.hayNinio() or self.cantidadDeOcupantes() == 0){
			ocupantes.add(ocupante)
		}
	}

	override method confortExtra(persona) =
		if (persona.edad()<=4){
			confortBase + 2
		}
		else{
			confortBase + 4
		}
	
}

class Cocina inherits HabitacionGeneral{
	var property metrosCuadrados = 500
	var property porcentaje = 10	
	method hayPersonaQueSabeCocinar() = ocupantes.any{o => o.tieneHabilidadDeCocina()}
	
	override method aniadirOcupante(ocupante){
		if ((not self.hayPersonaQueSabeCocinar() and ocupante.tieneHabilidadDeCocina()) or (not ocupante.tieneHabilidadDeCocina())) {
			ocupantes.add(ocupante)
		}

	}
		override method confortExtra(persona)=
		if (persona.tieneHabilidadDeCocina()){
			confortBase + metrosCuadrados * porcentaje / 100
		}
		else{
			confortBase
		}	
}

class Familia{
	const integrantes = #{}
	var property casa
	method aniadirIntegrante(persona){integrantes.add(persona)}
	method confortTotal() = integrantes.sum{o=> o.confort()}
	method confortPromedio() = self.confortTotal() / self.cantidadDeIntegrantes()
	method cantidadDeIntegrantes() = integrantes.size()
	method estaVacia() = self.cantidadDeIntegrantes() == 0
	method integranteMasViejo() = integrantes.max{o => o.edad()}
	method personasQueDuermenEnDormitorio(dormitorio) = integrantes.filter{p=>p.dormitorio() == dormitorio}
}

class Persona{
	var property edad = 0
	var property tieneHabilidadDeCocina = false
	var property habitacionActual
	var property confort = 0
	var property dormitorio
	method ocuparHabitacion(habitacion){
		habitacionActual.quitarOcupante(self)
		habitacion.aniadirOcupante(self)
		habitacionActual = habitacion
		confort = habitacion.confortExtra()
	}
	method aprenderCocina() {tieneHabilidadDeCocina = true }
}