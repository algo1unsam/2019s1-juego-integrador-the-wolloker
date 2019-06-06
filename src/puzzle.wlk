import wollok.game.*
import gaston.*
import mapa.*
import paredes.*
import tablero.*

class ParedRoja inherits Pared {

	override method image() = "muro2.png"

}

class Ficha inherits CosaEnTablero {

	const property imagenFicha
	const property posicionCorrecta

	override method image() = imagenFicha

	override method dejaPasar() = false

}

class CosasDelPuzzle {

	const ficha1 = new Ficha(imagenFicha = "ficha1.png", posicionCorrecta = self.posicion1(), position = self.posicion2())
	const ficha2 = new Ficha(imagenFicha = "ficha2.png", posicionCorrecta = self.posicion2(), position = self.posicion7())
	const ficha3 = new Ficha(imagenFicha = "ficha3.png", posicionCorrecta = self.posicion3(), position = self.posicion6())
	const ficha4 = new Ficha(imagenFicha = "ficha4.png", posicionCorrecta = self.posicion4(), position = self.posicion9())
	const ficha5 = new Ficha(imagenFicha = "ficha5.png", posicionCorrecta = self.posicion5(), position = self.posicion3())
	const ficha6 = new Ficha(imagenFicha = "ficha6.png", posicionCorrecta = self.posicion6(), position = self.posicion8())
	const ficha7 = new Ficha(imagenFicha = "ficha7.png", posicionCorrecta = self.posicion7(), position = self.posicion5())
	const ficha8 = new Ficha(imagenFicha = "ficha8.png", posicionCorrecta = self.posicion8(), position = self.posicion1())
	const hueco = new Ficha(imagenFicha = "hueco.png", posicionCorrecta = self.posicion9(), position = self.posicion4())

	method centro() = game.center()

	method posicion1() = self.centro().left(1).up(1)

	method posicion2() = self.centro().up(1)

	method posicion3() = self.centro().right(1).up(1)

	method posicion4() = self.centro().left(1)

	method posicion5() = self.centro()

	method posicion6() = self.centro().right(1)

	method posicion7() = self.centro().left(1).down(1)

	method posicion8() = self.centro().down(1)

	method posicion9() = self.centro().right(1).down(1)

}

object puzzle inherits CosasDelPuzzle {

	method cargar() {
		self.hacerbordes()
	}

	method hacerbordes() {
		self.bordeSup()
		self.bordeInf()
		self.bordeIzq()
		self.bordeDer()
	}

	method bordeSup() {
		self.bordeH(self.posicion1().left(1).up(1))
	}

	method bordeInf() {
		self.bordeH(self.posicion7().left(1).down(1))
	}

	method bordeIzq() {
		self.bordeV(self.posicion7().left(1))
	}

	method bordeDer() {
		self.bordeV(self.posicion9().right(1))
	}

	method bordeH(posicion) {
		new Range(0,4).forEach({ n => game.addVisual(new ParedRoja(position = posicion.right(n)))})
	}

	method bordeV(posicion) {
		new Range(0,2).forEach({ n => game.addVisual(new ParedRoja(position = posicion.up(n)))})
	}

}

object armaFichas inherits CosasDelPuzzle {

	method aparecer() {
		new Range(1,8).forEach({ n => game.addVisual()})
	}

}

