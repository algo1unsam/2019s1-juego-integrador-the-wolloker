import wollok.game.*
import gaston.*
import mapa.*
import puzzle.*
import tablero.*

class Pared inherits CosaEnTablero {

	override method image() = "muro.png"

	override method dejaPasar() = false

}

