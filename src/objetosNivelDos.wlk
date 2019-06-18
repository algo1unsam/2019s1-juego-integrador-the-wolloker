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
		if (cosa == gaston and gaston.estaVivo()) gaston.morir()
	}

}

class Arquero inherits Mago {

	override method image() = "arquero.png"

}

class Proyectil inherits CosaInteractiva {

	var imagen

	override method image() = imagen

	override method teChocasteCon(cosa) {
		cosa.morir()
	}

method tieneLlave() = false

}



