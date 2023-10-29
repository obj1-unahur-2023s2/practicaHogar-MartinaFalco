class Cliente{
	const clientesComunicados = []
	const aplicacionesUtilizadas = []
	var property importeMensual = 0
	var property pais
	
	method hacerLlamada(llamada, persona){
		clientesComunicados.add(persona)
		importeMensual += llamada.precio()
	}
	
	method seComunicoCon(persona) = clientesComunicados.contains(persona)
	method esAmigoDe(persona) = self.seComunicoCon(persona) and persona.seComunicoCon(self)
	method seComunicaSoloConAmigos() = clientesComunicados.all{c => c.esAmigoDe(self)}
	method mudarse(nuevoPais){
		pais = nuevoPais
	}
	method aplicacionQueMasGasto() = aplicacionesUtilizadas.max{a => a.datosUtilizados()}
	method utilizarAplicacion(aplicacion) = aplicacionesUtilizadas.add(aplicacion)

}

class ClienteFull inherits Cliente(importeMensual = 5000){
	
}

class Tarjeta{
	var property valor = 0
}

class ClientePrepago inherits Cliente{
	method comprarTarjeta(tarjeta){
		importeMensual = tarjeta.valor()
	}
}

class ClienteControl inherits Cliente{
	method cantiadDecomunicaciones() = clientesComunicados.size()
	override method hacerLlamada(llamada, persona){
		clientesComunicados.add(persona)
		if (self.cantiadDecomunicaciones() > 100){
			importeMensual += llamada.precio()}
		else{
			importeMensual = 0
		}
   }
}

class Registro{
	var property datosUtilizados = 0
	var property duracion = 0
	var property precio = 0
}

class Mensaje inherits Registro{	
}

class Aplicacion inherits Registro{
	
}

class Llamada inherits Registro{
	
	var property paisRemitente
	var property paisDestinatario
	method calcularPrecio(){
		if(paisDestinatario == argentina){
			precio = duracion * datosDeFacturacion.minutoLlamadaNacional()
	}
	else{
		precio = duracion * datosDeFacturacion.minutoLlamadaInternacional(paisDestinatario)
	}

}
}
const argentina = new Pais(incremento = 0)
const peru = new Pais(incremento = 10)


object datosDeFacturacion{
	var property precioPorMBgastado = 10
	var property minutoLlamadaNacional = 25
	method  minutoLlamadaInternacional(pais) = minutoLlamadaNacional * pais.incremento()
	
}

class Pais{
	var property incremento
	
}



object empresa{
	const clientes = #{} 
	method clientesQueSeComunicaronCon(cliente) = clientes.filter{c => c.seComunicoCon(cliente)}
	method ingresarCliente(cliente) = clientes.add(cliente)
	method liquidacionTotal() = clientes.sum{c => c.importeMensual()}
	
}







