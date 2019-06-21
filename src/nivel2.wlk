import paredes.*
import tablero.*
import wollok.game.*
import gaston.*
import enemigos.*
import puerta.*
import objetos.*
import sacerdote.*
import objetosNivelDos.*

object nivel2 {

	const ancho = game.width() - 1
	const largo = game.height() - 1
	
	const bolaArriba1 = new BolaDeNieve(imagen = "boladefuego.png", position = game.at(6, 2))
	const bolaArriba2 = new BolaDeNieve(imagen = "boladefuego.png", position = game.at(19, 2))
	const bolaAbajo1 = new BolaDeNieve(imagen = "boladefuegoabajo.png", position = game.at(3, 10))
	const bolaAbajo2 = new BolaDeNieve(imagen = "boladefuegoabajo.png", position = game.at(16, 10))
	
	const property lineaLava1 = []
	const property lineaLava3 = []
	const property lineaLava2 = []
	const property lineaLava4 = []
	
	const property bolasAbajo = [bolaAbajo1,bolaAbajo2]
	const property bolasArriba = [bolaArriba1, bolaArriba2]
	
	const property magoU1 = new Mago(position = game.at(3, 12))
	const property magoD1 = new Mago(position = game.at(6, 1))
	const property magoU2 = new Mago(position = game.at(16, 12))
	const property magoD2 = new Mago(position = game.at(19, 1))

	method crearLava(x, y) = new Lava(imagen = "lava.png", position = game.at(x, y))

	method agregar(lista, obj) {
		lista.add(obj)
		game.addVisual(obj)
	}

	method llenarLista(lista, x, desde, hasta, ob1, ob2, ob3) {
		self.crearObsidianas(lista,x,ob1,ob2,ob3)
		
		new Range(desde, hasta).forEach({ n => if(n!=ob1 and n!=ob2 and n!=ob3) self.agregar(lista, self.crearLava(x, n))})
	}
	
	method crearObsidianas(lista,x,ob1,ob2,ob3){
		const obs = [ob1,ob2,ob3]
		obs.forEach{ ob => self.agregar(lista,new Obsidiana(imagen = "muro.png", position = game.at(x,ob)))}
	}

	method cargar() {
		controladorDeTablero.sacarTodo()
		self.agregarCosas()
		game.whenCollideDo(gaston, { objeto => gaston.teChocasteCon(objeto)})
		game.whenCollideDo(sacerdote, { cosa => sacerdote.teChocasteCon(cosa)})
		game.whenCollideDo(puerta, { e => puerta.pasoNivel2(e)})
		keyboard.right().onPressDo({ controladorDeTablero.moverDer(gaston)})
		keyboard.left().onPressDo({ controladorDeTablero.moverIzq(gaston)})
		keyboard.down().onPressDo({ controladorDeTablero.moverAba(gaston)})
		keyboard.up().onPressDo({ controladorDeTablero.moverArr(gaston)})
		self.llenarLista(lineaLava1, 10, 1, 13, 1, 5, 9)
		self.llenarLista(lineaLava3, 12, 1, 13, 3, 7, 11)
		self.llenarLista(lineaLava2, 11, 1, 13, 3, 7, 11)
		self.llenarLista(lineaLava4, 13, 1, 13, 3, 7, 11)
		movedor.moverNivel2()
	}

	method cargarBordeV(x) {
		new Range(0,largo).forEach({ n => game.addVisualIn(new Pared(), game.at(x, n))})
	}

	method cargarBordeH(y) {
		new Range(1,ancho-1).forEach({ n => game.addVisualIn(new Pared(), game.at(n, y))})
	}

	method agregarCosas() {
		gaston.position(game.at(1, 6))
		game.addVisual(gaston)
		gaston.reiniciarGolpes()
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
		game.addVisualIn(llave,game.at(14,1))
		game.addVisualIn(puerta, game.at(22, 6))
		self.cargarBordeV(0)
		self.cargarBordeV(ancho)
		self.cargarBordeH(0)
		self.cargarBordeH(largo)
	}

	method gano() {
		keyboard.any().onPressDo({ self.gameOver()})
	}

	method gameOver() {
		controladorDeTablero.sacarTodo()
		keyboard.any().onPressDo({ game.stop()})
	}

}

