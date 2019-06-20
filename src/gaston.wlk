import wollok.game.*
import paredes.*
import puzzle.*
import tablero.*
import enemigos.*
import objetos.*

object gaston inherits CosaInteractiva {
	var property hits = -999
	const property equipo = []
	const property derrotados = []
	var estaVivo = true
	var property image = "player1.png"

	override method position() {
		if (position == null) {
			self.position(game.at(1, 1))
		}
		return position
	}

	method estaVivo() = estaVivo

	override method image() = "player1.png"

	method tieneArmadura() = equipo.contains(armadura)

	method tieneEspada() = equipo.contains(espada)

	method tieneCasco() = equipo.contains(casco)
	
	method tieneEscudo() = equipo.contains(escudo)

	method espadaYArmadura() = self.tieneArmadura() and self.tieneEspada()

	method fullEquipo() = self.espadaYArmadura() and self.tieneCasco()
	
	method tieneeEscudo() =  self.tieneEscudo()
	

	method puedeLevantar() = estaVivo
	
	method desequipado(){
		image = "player1.png"
	}
	
	method soloEscudo(){
		image = "player10.png"
	}
	
	method conEscudo(){
		image = "player9.png"
	}
	
	method conCasco() {
		image = "player5.png"
	}

	method conArmadura() {
		image = "player2.png"
	}

	method conEspada() {
		image = "player4.png"
	}

	method conEspadaYArmadura() {
		image = "player3.png"
	}

	method tieneLlave() = equipo.contains(llave)

	method morir() {
		estaVivo = false
		image = "casper.png"
		self.dejarEquipo()
	}

	method dejarEquipo() {
		equipo.forEach{ objeto => objeto.aparecer()}
		self.equipo().clear()
	}

	method derrotasteA(enemy) {
		derrotados.add(enemy)
	}

	method revivir() {
		if (not self.estaVivo()) {
			estaVivo = true
			image = "player1.png"
			self.position(self.position().up(1))
		}
	}

	override method teChocasteCon(cosa) {
		if (estaVivo) cosa.teChocasteCon(self)
	}

	method moverseA(posicion) {
		if (controladorDeTablero.cosasDejanPasar(posicion) or not self.estaVivo()) self.position(posicion)
	}

	method pasasteNivel1() {
		image = "player5.png"
		//equipo.clear()
		derrotados.clear()
	}
	
	method teGolpeo(){
		
		self.position(self.position().left(1))
			hits++
			
		if (self.golpes()==0){
			game.addVisualIn(escudo, game.at(1.randomUpTo(14), 1.randomUpTo(18)))
			equipo.clear()
			self.conCasco()
			
		}
	
		else{
			
			self.morir()
		}
		

		
	}
	
	method reiniciarGolpes(){
		hits = -1
	}
	
	method golpes(){
		return hits
	}
	
	
	
	

}

