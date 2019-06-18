import tablero.*
import puzzle.*
import objetos.*
import gaston.*
import wollok.game.*
import nivel1.*
import nivel2.*

object puerta inherits CosaInteractiva {

	override method image() = "puerta4.png"

	method gameOver() {
		game.stop()
	}

	method pasoNivel1(cosa) {
		if (cosa.tieneLlave()) nivel1.gano()
	}

	method pasoNivel2(cosa) {
		if (cosa.estaVivo()) nivel2.gano()
	}

}

