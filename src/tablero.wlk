import wollok.game.*
import gaston.*
import mapa.*
import paredes.*

class CosaEnTablero {

	/*cosas en tablero va a ser la superclase de la van a heredar todos los objetos del
	 *  tablero
	 */
	var property position

	method image()

	method dejaPasar()

	method posicion(x, y) = game.at(x, y)

}

object tablero {

	const limiteSuperior = (game.height() - 1)
	const limiteDerecho = (game.width() - 1)
	const limiteCero = 0

	method errorRegar() {
		self.error("No tengo nada para regar")
	}

	method errorCosechar() {
		self.error("No tengo nada para cosechar")
	}

	method errorVender() {
		self.error("No tengo Plantas para vender")
	}

	method errorComprar(mercado) {
		mercado.error("No Tengo Monedas Suficientes")
	}

	method errorMercado() {
		self.error("Tengo que ir a un mercado primero")
	}

	method moverHaciaArriba(objeto) {
		self.moverElemento(objeto, self.arribaDeTodo(objeto.position()), self.posicionTodoAbajo(objeto.position()), objeto.position().up(1))
	}

	method moverHaciaAbajo(objeto) {
		self.moverElemento(objeto, self.abajoDeTodo(objeto.position()), self.posicionTodoArriba(objeto.position()), objeto.position().down(1))
	}

	method moverHaciaIzq(objeto) {
		self.moverElemento(objeto, self.izqDeTodo(objeto.position()), self.posicionTodoDer(objeto.position()), objeto.position().left(1))
	}

	method moverHaciaDer(objeto) {
		self.moverElemento(objeto, self.derDeTodo(objeto.position()), self.posicionTodoIzq(objeto.position()), objeto.position().right(1))
	}

	method moverElemento(objeto, condicion, alBorde, normal) {
		if (condicion) objeto.moverse(alBorde) else objeto.moverse(normal)
	}

	/*estas son las posiciones del objeto modificadas para que cambie de lado*/
	method posicionTodoAbajo(posicion) = game.at(posicion.x(), limiteCero)

	method posicionTodoArriba(posicion) = game.at(posicion.x(), limiteSuperior)

	method posicionTodoIzq(posicion) = game.at(limiteCero, posicion.y())

	method posicionTodoDer(posicion) = game.at(limiteDerecho, posicion.y())

	/*estas son las comprobaciones de si esta en cada uno de los bordes */
	method abajoDeTodo(posicion) = posicion.y() == limiteCero

	method arribaDeTodo(posicion) = posicion.y() == limiteSuperior

	method izqDeTodo(posicion) = posicion.x() == limiteCero

	method derDeTodo(posicion) = posicion.x() == limiteDerecho

	/*para agregar arbustos */
	method dejarLibreSoloAbajo(posicion) {
		game.addVisualIn(new Arbusto(), posicion.left(1))
		game.addVisualIn(new Arbusto(), posicion.right(1))
		new Range(1,3).forEach({ valor => game.addVisualIn(new Arbusto(), posicion.up(1).left(2).right(valor))})
	}

}

