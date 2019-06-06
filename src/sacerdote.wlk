import wollok.game.*
import mapa.*
import paredes.*
import tablero.*
import gaston.*
import enemigos.*

object sacerdote inherits CosaEnTablero {

	override method dejaPasar() = true

	override method image() = "sacerdote.png"

	method teChocasteConGaston() {
	}

	method teChocasteConFantasma() {
	}

}

