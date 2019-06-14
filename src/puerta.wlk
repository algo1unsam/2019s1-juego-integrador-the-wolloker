import tablero.*
import puzzle.*
import objetos.*
import gaston.*
import wollok.game.*
import nivel1.*

object puerta inherits CosaInteractiva {

	override method image() = "puerta4.png"

	method gameOver() {
		game.stop()
	}

	method pasoNivel1() {
		if (gaston.tieneLlave()) nivel1.gano()
	}

}

