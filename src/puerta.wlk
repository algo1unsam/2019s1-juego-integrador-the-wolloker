import tablero.*
import puzzle.*
import objetos.*
import gaston.*
import wollok.game.*
import nivel1.*
import nivel2.*

object puerta inherits CosaInteractiva {

	override method image() = "puerta4.png"

	method pasoNivel1(cosa) {
		if (cosa.tieneLlave()) {
			nivel1.gano()
			cosa.pasasteNivel1()
		}
	}

	method pasoNivel2(cosa) {
		if (cosa.estaVivo() and cosa.tieneLlave()) nivel2.gano()
	}

}

