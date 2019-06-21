import wollok.game.*
import gaston.*
import nivel2.*
import paredes.*
import tablero.*
import Nivel.*

class ParedRoja inherits Pared {

	override method image() = "muro2.png"

}

class Ficha inherits CosaEnTablero {

	const property imagenFicha
	const property posicionCorrecta

	override method image() = imagenFicha

	override method dejaPasar() = true

}

object fichasDelPuzzle {

	const ficha1 = new Ficha(imagenFicha = "ficha1.png", posicionCorrecta = self.posicion1(), position = self.posicion2())
	const ficha2 = new Ficha(imagenFicha = "ficha2.png", posicionCorrecta = self.posicion2(), position = self.posicion7())
	const ficha3 = new Ficha(imagenFicha = "ficha3.png", posicionCorrecta = self.posicion3(), position = self.posicion6())
	const ficha4 = new Ficha(imagenFicha = "ficha4.png", posicionCorrecta = self.posicion4(), position = self.posicion9())
	const ficha5 = new Ficha(imagenFicha = "ficha5.png", posicionCorrecta = self.posicion5(), position = self.posicion3())
	const ficha6 = new Ficha(imagenFicha = "ficha6.png", posicionCorrecta = self.posicion6(), position = self.posicion8())
	const ficha7 = new Ficha(imagenFicha = "ficha7.png", posicionCorrecta = self.posicion7(), position = self.posicion5())
	const ficha8 = new Ficha(imagenFicha = "ficha8.png", posicionCorrecta = self.posicion8(), position = self.posicion1())
	const hueco = new Ficha(imagenFicha = "hueco.png", posicionCorrecta = self.posicion9(), position = self.posicion4())
	const listaFichas = [ ficha1, ficha2, ficha3, ficha4, ficha5, ficha6, ficha7, ficha8, hueco ]

	method fichasInicio() {
//		ficha1.position(self.posicion2())
//		ficha2.position(self.posicion7())
//		ficha3.position(self.posicion6())
//		ficha4.position(self.posicion9())
//		ficha5.position(self.posicion3())
//		ficha6.position(self.posicion8())
//		ficha7.position(self.posicion5())
//		ficha8.position(self.posicion1())
//		hueco.position(self.posicion4())
		ficha1.position(self.posicion1())
		ficha2.position(self.posicion2())
		ficha3.position(self.posicion3())
		ficha4.position(self.posicion4())
		ficha5.position(self.posicion5())
		ficha6.position(self.posicion6())
		ficha7.position(self.posicion7())
		ficha8.position(self.posicion9())
		hueco.position(self.posicion8())
	}

	method hueco() = hueco

	method fichas() = listaFichas

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

	method gano() = self.fichas().all({ f => f.posicionCorrecta() == f.position() })

}

object puzzle inherits Nivel {

	method position() = fichasDelPuzzle.hueco().position()

	override method cargar() {
		player = gaston1
		super()
		self.reiniciar()
	}

	override method agregarCosas() {
		player.position(game.at(9, 5))
		self.hacerbordes()
		self.aparecerFichas()
		super()
	}

	override method gameConfig() {
		keyboard.left().onPressDo({ controladorDeTablero.moverDer(self)})
		keyboard.right().onPressDo({ controladorDeTablero.moverIzq(self)})
		keyboard.up().onPressDo({ controladorDeTablero.moverAba(self)})
		keyboard.down().onPressDo({ controladorDeTablero.moverArr(self)})
	}

	method hacerbordes() {
		self.bordeSup()
		self.bordeInf()
		self.bordeIzq()
		self.bordeDer()
	}

	method bordeSup() {
		self.bordeH(fichasDelPuzzle.posicion1().left(1).up(1))
	}

	method bordeInf() {
		self.bordeH(fichasDelPuzzle.posicion7().left(1).down(1))
	}

	method bordeIzq() {
		self.bordeV(fichasDelPuzzle.posicion7().left(1))
	}

	method bordeDer() {
		self.bordeV(fichasDelPuzzle.posicion9().right(1))
	}

	method bordeH(posicion) {
		new Range(0,4).forEach({ n => game.addVisual(new ParedRoja(position = posicion.right(n)))})
	}

	method bordeV(posicion) {
		new Range(0,2).forEach({ n => game.addVisual(new ParedRoja(position = posicion.up(n)))})
	}

	method aparecerFichas() {
		fichasDelPuzzle.fichas().forEach({ f => game.addVisual(f)})
	}

	method moverse(posicion) {
		if (fichasDelPuzzle.gano()) self.gano() else if (controladorDeTablero.cosasDejanPasar(posicion)) {
			self.moverFicha(posicion, fichasDelPuzzle.hueco().position())
			fichasDelPuzzle.hueco().position(posicion)
		}
	}

	method moverFicha(inicio, fin) {
		controladorDeTablero.cosasEn(inicio).get(0).position(fin)
	}

	override method gano() {
		keyboard.any().onPressDo({ nivel2.cargar()})
	}

	method reiniciar() {
		fichasDelPuzzle.fichasInicio()
	}

}

