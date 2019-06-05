import wollok.game.*
import mapa.*
import paredes.*
import puzzle.*
import tablero.*

object gaston inherits CosaEnTablero {

	override method dejaPasar() = true

	override method image() = "jugador.png"

}

