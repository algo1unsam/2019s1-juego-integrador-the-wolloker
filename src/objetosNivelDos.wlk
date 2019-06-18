import wollok.game.*
import nivel2.*
import paredes.*
import tablero.*
import gaston.*
import objetos.*
import enemigos.*

class Mago {

	method image() = "mago.png"
	
}

class Arquero {

	method image() = "arquero.png"

}

class Proyectil inherits CosaInteractiva {

	var imagen

	override method image() = imagen

	override method teChocasteCon(cosa) {
		cosa.morir()
	}

}

