import wollok.game.*
import granjeros.*

class CosasDelTablero {

	method image() // conviene ponerlo en la superclase? en cada clase que la hereda hago un override...

	/*lo estoy usando para que no pueda cosechar ninguna cosa que que vaya a poner en el tablero,
	 * salvo que yo quiera que si lo haga ej. plantas*/
	method sePuedeCosechar() = false

	method teRegaron() {
		tablero.errorRegar()
	}

	method comprar(lista, dinero, persona) {
	}

	method dejaPasar() = true

}

class Mercado inherits CosasDelTablero {

	var monedas
	const cosasParaVender = []

	override method image() = if (monedas>=80)"market.png"else "market_closed.png"

	method cantidadDeMonedas() = monedas

	method meAlcanza(dinero) = dinero <= monedas

	override method comprar(lista, dinero, persona) {
		if (self.meAlcanza(dinero)) {
			self.agregarACosas(lista)
			self.pagar(dinero, persona)
		} else tablero.errorComprar(self)
	}

	method agregarACosas(lista) {
		cosasParaVender.addAll(lista)
	}

	method pagar(dinero, persona) {
		monedas -= dinero
		persona.cobrar(dinero)
	}

}

class Plantas inherits CosasDelTablero {

	method tePlantaron(posicion) {
		game.addVisualIn(self, posicion)
	}

	method teCosecharon() {
		game.removeVisual(self)
	}

}

class Maiz inherits Plantas {

	var estado = estadoBebe

	override method image() = estado.image()

	method esAdulta() = estado.esAdulta()

	method valorVenta() = 150 // lo usan todas las "plantas" conviene ponerlo en la clase Plantas?

	override method sePuedeCosechar() = self.esAdulta()

	override method teRegaron() {
		if (not self.esAdulta()) self.crecer()
	}

	method crecer() {
		estado = estadoAdulta
	}

}

class Trigo inherits Plantas {

	var property estado = estadoCero

//	method nuevoEstado(unEstado) {
//		estado = unEstado
//	}
	method valorVenta() = (self.nivel() - 1) * 100 // puedo ponerlo en los objetos estados, conviene?

	override method image() = estado.image()

	method nivel() = estado.nivel()

	override method sePuedeCosechar() = self.nivel() > 1

	override method teRegaron() {
		self.cambiarDeEstado()
	}

	method cambiarDeEstado() {
//		self.nuevoEstado(estado.siguiente())
		self.estado(estado.siguiente())
	}

}

class Tomaco inherits Plantas {

	var property position

	override method image() = "tomaco.png"

	override method sePuedeCosechar() = true

	method valorVenta() = 80

	override method teRegaron() {
		self.moverHaciaArriba()
	}

	method moverHaciaArriba() {
		tablero.moverHaciaArriba(self)
	}

	method moverse(nuevaPosicion) {
		self.position(nuevaPosicion)
	}

	override method tePlantaron(posicion) {
		self.position(posicion)
		game.addVisual(self)
	}

}

object estadoBebe {

	const property esAdulta = false

	method image() = "corn_baby.png"

}

object estadoAdulta {

	const property esAdulta = true

	method image() = "corn_adult.png"

}

object estadoCero {

	const property nivel = 0

	method image() = "wheat_0.png"

	method siguiente() = estadoUno

}

object estadoUno {

	const property nivel = 1

	method image() = "wheat_1.png"

	method siguiente() = estadoDos

}

object estadoDos {

	const property nivel = 2

	method image() = "wheat_2.png"

	method siguiente() = estadoTres

}

object estadoTres {

	const property nivel = 3

	method image() = "wheat_3.png"

	method siguiente() = estadoCero

}

