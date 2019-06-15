import wollok.game.*
import nivel2.*
import paredes.*
import tablero.*
import gaston.*
import objetos.*
import enemigos.*

object sacerdote inherits CosaInteractiva {

	override method image() = "sacerdote.png"

	override method teChocasteCon(cosa) {
		cosa.revivir()
	}

}

