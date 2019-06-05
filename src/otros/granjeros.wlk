import wollok.game.*
import plantas.*
import arbustos.*

object hector {

	var property position = game.at(5, 5)
	const plantasCosechadas = []
	var dineroJuntado = 0

	method dejarPasar() = true

	method dinero() = dineroJuntado // pasar a property?

	method vaciarPlantasCosechadas() {
		plantasCosechadas.clear()
	}

	method image() = "player.png"

//------------------------------------------------------------------
	/* tengo que reveer estos 3 metodos porque me crean las instancias antes de verificar si lo puede plantar
	 * pero si en todos los metodos evaluo el if, estoy repitiendo codigo.....
	 */
	method plantarMaiz() {
		self.plantar(new Maiz())
	}

	method plantarTrigo() {
		self.plantar(new Trigo())
	}

	method plantarTomaco() {
		self.plantar(new Tomaco())
	}

	method plantarArbusto() {
		self.plantar(new Arbusto())
	}

//---------------------------------------------------------------
	method plantar(planta) {
		if (self.lugarEstaVacio()) {
			planta.tePlantaron(self.position())
		}
	}

	method lugarEstaVacio() = self.cosasEnMismaPosicion().isEmpty()

	method cosasEnMismaPosicion() = game.colliders(self) // me da todos menos hector, estimo que es una lista

	method regar() { // ojo que teRegaron() se lo envia a todos los colliders
		if (self.lugarEstaVacio()) tablero.errorRegar() else {
			self.cosasEnMismaPosicion().forEach({ e => e.teRegaron()})
		}
	}

	method intentarCosechar() {
		self.cosasEnMismaPosicion().forEach({ e =>
			if (e.sePuedeCosechar()) { // ojo que sePuedeCosechar() se lo envia a todos los colliders
				plantasCosechadas.add(e)
				e.teCosecharon() // este mensaje solo le llega las cosas que si se pueden cosechar, que deberian ser las plantas
			}
		})
	}

	method cosechar() {
		if (self.lugarEstaVacio()) tablero.errorCosechar() else {
			self.intentarCosechar()
		}
	}

	method valorVentaPlantas() = plantasCosechadas.sum({ p => p.valorVenta() })

	method cantidadDePlantasParaVender() = plantasCosechadas.size()

	method cosechoPlantas() = self.cantidadDePlantasParaVender() > 0

	method moverse(nuevaPosicion) {
		if (self.puedoPasar(nuevaPosicion)) self.position(nuevaPosicion) else self.error("No puedo Pasar!!")
	}

	method cuantoTenes() {
		game.say(self, "Junte " + self.dinero() + " monedas, y tengo " + self.cantidadDePlantasParaVender() + " plantas para vender")
	}

	method vender() {
		if (self.cosechoPlantas()) {
			self.intentarVender()
		} else tablero.errorVender()
	}

	method intentarVender() {
		if (self.lugarEstaVacio()) tablero.errorMercado() else {
			self.cosasEnMismaPosicion().forEach({ e => e.comprar(plantasCosechadas, self.valorVentaPlantas(), self)})
		// comprar(p1,p2,p3) se lo envia a todos los colliders
		}
	}

	method cobrar(dinero) {
		dineroJuntado += dinero
		self.vaciarPlantasCosechadas()
		game.say(self, "Transaccion OK!!") // lo agregue para saber cuando hizo bien la operacion
	}

	method puedoPasar(posicion) = game.getObjectsIn(posicion).all({ e => e.dejaPasar() })

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

