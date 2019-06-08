import tablero.*
import puzzle.*
import objetos.*

object puerta inherits CosaInteractiva {

	override method image() = "puerta4.png"

	method ganaste() {
		controladorDeTablero.sacarTodo()
		puzzle.cargar()
	}

}

