import tablero.*
import puzzle.*
import objetos.*
import gaston.*
object puerta inherits CosaInteractiva {

	override method image() = "puerta4.png"

	method ganaste() {
		controladorDeTablero.sacarTodo()
		
		puzzle.cargar()
	}

}

