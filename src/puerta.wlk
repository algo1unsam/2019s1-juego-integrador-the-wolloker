import tablero.*
import puzzle.*
import objetos.*
import gaston.*
import wollok.game.*

object puerta inherits CosaInteractiva {

	override method image() = "puerta4.png"

	method ganaste() {
		controladorDeTablero.sacarTodo()
		puzzle.cargar()
	}

	method gameOver() {
		game.stop()
	}

}

