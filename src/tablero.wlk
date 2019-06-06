import wollok.game.*
import gaston.*
import mapa.*
import paredes.*
import puzzle.*

class CosaEnTablero {

	/*cosas en tablero va a ser la superclase de la van a heredar todos los objetos del
	 *  tablero
	 */
	 
	var property position

	method image()

	method dejaPasar()

}

object tiraMensajes {

	method errorTipo1() {
		self.error("Error Tipo 1")
	}

	method errorTipo2() {
		self.error("Error Tipo 1")
	}

	method errorTipo3() {
		self.error("Error Tipo 3")
	}

}

object controladorDeTablero {

	var property limiteSuperior = (game.height() - 1)
	var property limiteDerecho = (game.width() - 1)
	var property limiteCeroX = 0
	var property limiteCeroY = 0

	/*aca se manda la proxima ubicacion */
	method sePuedeMoverA(posicion) = not self.seVaDelTablero(posicion) and (self.cosasDejanPasar(posicion) or self.lugarEstaVacio(posicion))

	method seVaDelTablero(posicion) = self.seVaDeAbajo(posicion) or self.seVaDeArriba(posicion) or self.seVaDeIzq(posicion) or self.seVaDeDer(posicion)

//----------------------------------------------------------------------------------------------------
	/*estas son las comprobaciones de si se sale de cada uno de los bordes */
	method seVaDeAbajo(posicion) = posicion.y() < self.limiteCeroY()

	method seVaDeArriba(posicion) = posicion.y() > self.limiteSuperior()

	method seVaDeIzq(posicion) = posicion.x() < self.limiteCeroX()

	method seVaDeDer(posicion) = posicion.x() > self.limiteDerecho()

//----------------------------------------------------------------------------------------------------
	method cosasDejanPasar(posicion) = self.cosasEn(posicion).all({ c => c.dejaPasar() })

	method cosasEn(posicion) = game.getObjectsIn(posicion)

	method lugarEstaVacio(posicion) = self.cosasEn(posicion).isEmpty()

/*estas son las posiciones del objeto modificadas para que cambie de lado
 * 
 * 
 * method posicionTodoAbajo(posicion) = game.at(posicion.x(), self.limiteCeroY())

 * method posicionTodoArriba(posicion) = game.at(posicion.x(), self.limiteSuperior())

 * method posicionTodoIzq(posicion) = game.at(self.limiteCeroX(), posicion.y())

 * method posicionTodoDer(posicion) = game.at(self.limiteDerecho(), posicion.y())
 */
}

