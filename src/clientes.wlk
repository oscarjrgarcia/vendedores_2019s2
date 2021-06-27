import vendedores.*
class Cliente {
	
	method puedeSerAtendidoPor(unVendedor)
}

class Inseguro inherits Cliente {
	override method puedeSerAtendidoPor(unVendedor) = unVendedor.esVersatil() and unVendedor.esFirme()
}

class Detallista inherits Cliente {
	override method puedeSerAtendidoPor(unVendedor) = unVendedor.certificaciones().filter({c => c.esDeProducto()}).size() >= 3
}

class Humanista inherits Cliente {
	override method puedeSerAtendidoPor(unVendedor) = unVendedor.esPersonaFisica()
}