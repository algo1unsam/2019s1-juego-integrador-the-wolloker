import wollok.game.*
import nivel2.*
import paredes.*
import tablero.*
import gaston.*
import objetos.*
import enemigos.*

class Mago inherits CosaInteractiva {

	override method image() = "mago.png"

	override method teChocasteCon(cosa) {
		cosa.morir()
	}

}

class Arquero inherits Mago {

	override method image() = "arquero.png"

}

class Proyectil inherits CosaInteractiva {

	var imagen

	override method image() = imagen

	override method teChocasteCon(cosa) {
		cosa.teGolpeo()
	}

	method tieneLlave() = false

	method moverse(posicion) {
		self.position(posicion)
	}

}

class Lava inherits Proyectil {

	const property tiempo = 1000

}

class BolaDeNieve inherits Proyectil {

	const property tiempo = 100

}

class Obsidiana inherits Proyectil {

	const property tiempo = 1000
	var pasajero = nada

	override method teChocasteCon(cosa) {
		if (cosa.puedeSerLlevado()) {
			self.llevarA(cosa)
			cosa.siguiendoA(self)
		}
	}

	method llevarA(cosa) {
		pasajero = cosa
	}

	method dejarDeLlevar() {
		pasajero = nada
	}

	override method moverse(posicion) {
		super(posicion)
		if (pasajero.puedeSerLlevado()) pasajero.seguir(posicion)
	}

}

object nada {

	method seguir() {
	}

	method dejarDeLlevar() {
	}

	method puedeSerLlevado() = false

}

