import paredes.*
import tablero.*
import wollok.game.*
import gaston.*
import enemigos.*
import puerta.*
import objetos.*
import sacerdote.*
import objetosNivelDos.*
import Nivel.*

object nivel2 inherits Nivel {

	const bolaArriba1 = new BolaDeNieve(imagen = "boladefuego.png", position = game.at(6, 2))
	const bolaArriba2 = new BolaDeNieve(imagen = "boladefuego.png", position = game.at(19, 2))
	const bolaAbajo1 = new BolaDeNieve(imagen = "boladefuegoabajo.png", position = game.at(3, 10))
	const bolaAbajo2 = new BolaDeNieve(imagen = "boladefuegoabajo.png", position = game.at(16, 10))
	const property lineaLava1 = []
	const property lineaLava3 = []
	const property lineaLava2 = []
	const property lineaLava4 = []
	const property bolasAbajo = [ bolaAbajo1, bolaAbajo2 ]
	const property bolasArriba = [ bolaArriba1, bolaArriba2 ]
	const property magoU1 = new Mago(position = game.at(3, 12))
	const property magoD1 = new Mago(position = game.at(6, 1))
	const property magoU2 = new Mago(position = game.at(16, 12))
	const property magoD2 = new Mago(position = game.at(19, 1))

	override method cargar() {
		player = gaston2
		super()
	}

	override method agregarCosas() {
		player.position(game.at(1, 6))
		game.addVisualIn(sacerdote, game.at(1, 1))
		game.addVisual(bolaAbajo1)
		game.addVisual(magoU1)
		game.addVisual(bolaArriba1)
		game.addVisual(magoD1)
		game.addVisual(escudo)
		game.addVisual(bolaAbajo2)
		game.addVisual(magoU2)
		game.addVisual(bolaArriba2)
		game.addVisual(magoD2)
		game.addVisualIn(llave, game.at(14, 1))
		game.addVisualIn(puerta, game.at(22, 6))
		self.llenarLista(lineaLava1, 10, 1, 13, 1, 5, 9)
		self.llenarLista(lineaLava3, 12, 1, 13, 3, 7, 11)
		self.llenarLista(lineaLava2, 11, 1, 13, 3, 7, 11)
		self.llenarLista(lineaLava4, 13, 1, 13, 3, 7, 11)
		super()
	}

	override method gameConfig() {
		super()
		game.whenCollideDo(puerta, { e => puerta.pasoNivel2(e)})
		movedor.moverNivel2()
	}

	method crearLava(x, y) = new Lava(imagen = "lava.png", position = game.at(x, y))

	method agregar(lista, obj) {
		lista.add(obj)
		game.addVisual(obj)
	}

	method llenarLista(lista, x, desde, hasta, ob1, ob2, ob3) {
		self.crearObsidianas(lista, x, ob1, ob2, ob3)
		new Range(desde, hasta).forEach({ n =>
			if (n != ob1 and n != ob2 and n != ob3) self.agregar(lista, self.crearLava(x, n))
		})
	}

	method crearObsidianas(lista, x, ob1, ob2, ob3) {
		const obs = [ ob1, ob2, ob3 ]
		obs.forEach{ ob => self.agregar(lista, new Obsidiana(imagen = "muro.png", position = game.at(x, ob)))}
	}

	override method gano() {
		keyboard.any().onPressDo({ self.gameOver()})
	}

	method gameOver() {
		controladorDeTablero.sacarTodo()
		keyboard.any().onPressDo({ game.stop()})
	}

}

