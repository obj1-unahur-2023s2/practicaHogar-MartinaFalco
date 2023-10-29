class Casa{
	const habitaciones =#{}
	method aniadirHabitacion(habitacion) = habitaciones.add(habitacion)
}

class HabitacionGeneral{
	var property confortBase = 10
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
	override method aniadirOcupante(ocupante){
		if (ocupante.duermeEnDormitorio(self)){ocupantes.add(ocupante)}
		if (not ocupante.duermeEnDormitorio(self) and self.estaLleno()){ocupantes.add(ocupante)}
	}	
	method estaLleno() = ocupantes.all{o=> o.duermeEnDormitorio(self)}
	override method confortExtra(ocupante) = 
	if (ocupante.duermeEnDormitorio(self)){confortBase + 10 / self.cantidadDeOcupantes()}
	else{
		confortBase
	}
}

class Banio inherits HabitacionGeneral{
	method hayNinio() = ocupantes.find{p => p.edad() <= 4}
	override method aniadirOcupante(ocupante){
		if(self.hayNinio()){
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
	var property metrosCuadrados
	method porcentaje() = metrosCuadrados * 0.50
	method hayPersonaQueSabeCocinar() = ocupantes.find{o => o.tieneHabilidadDeCocina()}
	
	override method aniadirOcupante(ocupante){
		if (not self.hayPersonaQueSabeCocinar() and ocupante.tieneHabilidadDeCocina()) {
			ocupantes.add(ocupante)
		}
		if(not ocupante.tieneHabilidadDeCocina()){
			ocupantes.add(ocupante)
		}
	}
	
		override method confortExtra(persona)=
		if (persona.tieneHabilidadDeCocina()){
			confortBase + self.porcentaje()
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
}

class Persona{
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
	method aprenderCocina() {tieneHabilidadDeCocina = true }
}