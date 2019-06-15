import wollok.game.*
import gaston.*
import nivel2.*
import puzzle.*
import tablero.*

class Pared inherits CosaEnTablero {

	override method image() = "muro.png"

	override method dejaPasar() = false

}

