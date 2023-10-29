object empresa{
	const empleados = []
	
	method listaDeInvitados() = empleados.filter{empleado => empleado.esInvitado()}
	
}

class Personal{
	const lenguajes = []
	
	method nroDeMesa() = self.cantidadDeLenguajesModernos()
	
	method regalo() = self.cantidadDeLenguajesModernos() * 1000
	
	method esInvitado()
	
	method aprenderLenguaje(lenguaje) = lenguajes.add(lenguaje)
	
	method sabeProgramarEnWollok() = lenguajes.any{lenguaje => lenguaje.esWollok()}
	
	
	method sabeProgramarEnLenguajeAntiguo() = lenguajes.any{lenguaje => lenguaje.esAntiguo()}
	
	
	method cantidadDeLenguajesModernos() = lenguajes.count{lenguaje => not lenguaje.esAntiguo()}
}

class Lenguaje{
	var property esAntiguo = true
	var property nombre
	
	method esWollok() = nombre == "Wollok"
	method dejarDeSerAntiguo(){
		esAntiguo = false
	}
}

class Desarrollador inherits Personal{
	override method esInvitado() = self.sabeProgramarEnWollok() or self.sabeProgramarEnLenguajeAntiguo()
	method califica() = self.sabeProgramarEnLenguajeAntiguo()
}

class Infraestructura inherits Personal{
	var property aniosExperiencia
	override method esInvitado() = self.cantidadDeLenguajesModernos() >= 5
	method califica() = aniosExperiencia > 10
}

class Jefe inherits Personal{
	const personasACargo = []
	method tieneACargoAlguienQueCalifica() = personasACargo.any{persona => persona.califica()}
	method tieneACargoAJuan() = personasACargo.contains(juanPerez)
	method cantidadDeEmpleadosACargo() = personasACargo.size()
	method aniadirEmpleadoACargo(empleado) = personasACargo.add(empleado)
	override method esInvitado() = self.sabeProgramarEnLenguajeAntiguo() and self.tieneACargoAlguienQueCalifica() and not self.tieneACargoAJuan()
	override method nroDeMesa() = 99
	override method regalo() = self.cantidadDeEmpleadosACargo() * 1000
}

object juanPerez{
	method califica() = false
	method esInvitado() = false
}
class NoInvitadoException inherits Exception{
	
}

object fiesta{
	const asistencias = []
	method costoTotal() = 200000 + (asistencias.size() * 5000)
	method importe() = asistencias.sum{alguien => alguien.regalo()}
	method balance() = self.importe() - self.costoTotal()
	method llegaInvitado(alguien){	
		if(not empresa.listaDeInvitados().contains(alguien)) 
			throw new NoInvitadoException(message="no te invitaron")
		
		asistencias.add(
			new Asistencia(
				invitado = alguien,
				nroDeOrden = self.nroDeOrden(),
				nroDeMesa = alguien.nroMesa()
			)
		)
		
	}
	method nroDeOrden() = asistencias.size() + 1
	method fueExcelente() = asistencias.size() == empresa.listaDeInvitados().size()
	method sorteo(){
		const n = 1.randomUpTo(100).truncate(0)
		return asistencias.find{alguien => alguien.nroDeOrden() == n}
	}
	
}


class Asistencia{
	var property invitado
	var property nroDeOrden
	var property nroDeMesa
	
}









