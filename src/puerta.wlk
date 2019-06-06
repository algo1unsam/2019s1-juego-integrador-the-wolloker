import tablero.*
import puzzle.*

object puerta {
	
	method image() = "puerta4.png"
	method ganaste(){
		controladorDeTablero.sacarTodo()
		puzzle.cargar()
		
	}
	
}
object llave {
	
	method image() = "llave.png"
}