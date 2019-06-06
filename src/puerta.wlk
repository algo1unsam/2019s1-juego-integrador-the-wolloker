import tablero.*
import puzzle.*

object puerta inherits CosaEnTablero {

	override method dejaPasar() = true

	override method image() = "puerta4.png"

	method ganaste() {
		controladorDeTablero.sacarTodo()
		puzzle.cargar()
	}

}

object llave inherits CosaEnTablero {

	override method dejaPasar() = true

	override method image() = "llave.png"

}

