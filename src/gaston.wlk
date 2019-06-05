import wollok.game.*
import mapa.*
import paredes.*
import puzzle.*
import tablero.*

object gaston inherits CosaEnTablero {

	override method dejaPasar() = true

	override method image() = "jugador.png"

}

//-----------------------------------------------------
/*esto para sacer metodos */
object player1 {

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

