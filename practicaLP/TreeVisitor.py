if __name__ is not None and "." in __name__:
    from .jsbachParser import jsbachParser
    from .jsbachVisitor import jsbachVisitor
else:
    from jsbachParser import jsbachParser
    from jsbachVisitor import jsbachVisitor


class TreeVisitor(jsbachVisitor):
    def __init__(self, function, arguments):
        self.dic = {}
        self.functions = {}
        self.notes = {"A0": 0, "B0": 1, "C1": 2, "D1": 3, "E1": 4, "F1": 5, "G1": 6,
                      "A1": 7, "B1": 8, "C2": 9, "D2": 10, "E2": 11, "F2": 12, "G2": 13,
                      "A2": 14, "B2": 15, "C3": 16, "D3": 17, "E3": 18, "F3": 19, "G3": 20,
                      "A3": 21, "B3": 22, "C4": 23, "D4": 24, "E4": 25, "F4": 26, "G4": 27,
                      "A4": 28, "B4": 29, "C5": 30, "D5": 31, "E5": 32, "F5": 33, "G5": 34,
                      "A5": 35, "B5": 36, "C6": 37, "D6": 38, "E6": 39, "F6": 40, "G6": 41,
                      "A6": 42, "B6": 43, "C7": 44, "D7": 45, "E7": 46, "F7": 47, "G7": 48,
                      "A7": 49, "B7": 50, "C8": 51,
                      "A": 28, "B": 29, "C": 23, "D": 24, "E": 25, "F": 26, "G": 27
                      }
        self.reconvertir = {'0': "a,,,",    '1': "b,,,",
                            '2': "c,,",    '3': "d,,",    '4': "e,,",    '5': "f,,",    '6': "g,,",    '7': "a,,",    '8': "b,,",
                            '9': "c,",     '10': "d,",    '11': "e,",    '12': "f,",    '13': "g,",    '14': "a,",    '15': "b,",
                            '16': "c",     '17': "d",     '18': "e",     '19': "f",     '20': "g",     '21': "a",     '22': "b",
                            '23': "c'",    '24': "d'",    '25': "e'",    '26': "f'",    '27': "g'",    '28': "a'",    '29': "b'",
                            '30': "c''",   '31': "d''",   '32': "e''",   '33': "f''",   '34': "g''",   '35': "a''",   '36': "b''",
                            '37': "c'''",  '38': "d'''",  '39': "e'''",  '40': "f'''",  '41': "g'''",  '42': "a'''",  '43': "b'''",
                            '44': "c''''", '45': "d''''", '46': "e''''", '47': "f''''", '48': "g''''", '49': "a''''", '50': "b''''",
                            '51': "c'''''",
                            }
        self.firstFunction = function
        self.arguments = arguments

        self.partitura = []

    def visitRoot(self, ctx):

        l = list(ctx.getChildren())

        for i in range(0, len(l)-1):
            l2 = list(l[i].getChildren())
            name = l2[0].getText()
            if name in self.functions.keys():
                raise Exception("Function already defined")
            else:
                self.functions[name] = l[i]

        if self.firstFunction == 'Main':
            self.visit(self.functions.get('Main'))
        else:
            funcion = self.functions.get(self.firstFunction)
            l2 = list(funcion.getChildren())
            par = []  # parametros de la funcion
            for x in range(1, len(l2)):
                x2 = l2[x].getText()
                if (x2 != '|:'):
                    par.append(x2)
                else:
                    break
            lenP = len(par)
            lenF = len(self.arguments)

            if lenP != lenF:
                raise Exception(
                    "Number of parameters proporcioned is incorrect")
            else:
                # diccionario inicial
                init_dic = self.dic.copy()

                # iniciar los parametros de la funcion
                self.dic.clear()
                for i in range(0, len(par)):
                    self.dic[par[i]] = self.arguments[i]

                # ejecutar la funcion
                self.visit(funcion)

                # eliminar los parametros locales de la funcion
                self.dic.clear()

                # restaurar los parametros iniciales
                self.dic = init_dic.copy()

    def visitExpr(self, ctx):
        l = list(ctx.getChildren())

        if len(l) == 1:  # valors numèrics, variables i mida llista
            token = jsbachParser.symbolicNames[l[0].getSymbol().type]
            if (token == "NUM"):
                value = int(l[0].getText())
                return value
            elif (token == "VAR"):
                var = l[0].getText()
                value = self.dic.get(var)
                if (value is None):
                    return 0
                else:
                    return value
            elif (token == "LENTGHLIST"):
                par = l[0].getText()[1:]
                value = self.dic.get(par)
                if (value is None):
                    raise Exception("The variable " + par + " does not exist")
                else:
                    return len(value)
            elif (token == "NOTA"):
                var = l[0].getText()
                nota = self.notes.get(var)
                if nota is not None:
                    return nota
                else:
                    raise Exception("The note " + var + " does not exist")

        elif len(l) == 3:  # len(l) == 3 (operacions)
            if (l[0].getText() == '('):
                return self.visit(l[1])
            else:
                token = jsbachParser.symbolicNames[l[1].getSymbol().type]
                value = int(self.visit(l[0]))
                value2 = int(self.visit(l[2]))
                cond = 0

                if (token == "MES"):
                    return value + value2

                elif (token == "RES"):
                    return value - value2

                elif (token == "MUL"):
                    return value * value2

                elif (token == "DIV"):
                    if (value2 == 0):
                        raise Exception("Cannot divide a number to 0")
                    else:
                        return value / value2

                elif (token == "MOD"):
                    return value % value2

                elif (token == "IGUALTAT"):
                    if value is not None:
                        if (value == value2):
                            cond = 1
                    return cond

                elif (token == "MENOR"):
                    if value is not None:
                        if (value < value2):
                            cond = 1
                    return cond

                elif (token == "MAJOR"):
                    if value is not None:
                        if (value > value2):
                            cond = 1
                    return cond

                elif (token == "MENOR_IGUAL"):
                    if value is not None:
                        if (value <= value2):
                            cond = 1
                    return cond

                elif (token == "MAJOR_IGUAL"):
                    if value is not None:
                        if (value >= value2):
                            cond = 1
                    return cond

                elif (token == "DESIGUALTAT"):
                    if value is not None:
                        if (value != value2):
                            cond = 1
                    return cond
        else:  # accés a un element de la llista
            var = l[0].getText()
            value = self.dic.get(var)  # elements de la llista
            if value is None:
                raise Exception("The variable " + var + " does not exist")
            expr = int(self.visit(l[2]))
            if (expr < 1 or expr > len(value)):
                raise Exception("Index out of range")
            else:
                valor = value[expr-1]
                return valor

    def visitCrearLlista(self, ctx):
        l = list(ctx.getChildren())
        var = l[0].getText()
        lista = []
        for i in range(3, len(l)-1):
            lista.append(self.visit(l[i]))
        self.dic[var] = lista

    def visitAfegirLlista(self, ctx):
        l = list(ctx.getChildren())
        var = l[0].getText()
        value = self.visit(l[2])
        s = self.dic.get(var)
        if s is not None and value is not None:
            self.dic.get(var).append(value)
        else:
            raise Exception("List not found")

    def visitEliminarLlista(self, ctx):
        l = list(ctx.getChildren())
        value = l[1].getText()
        par = self.visit(l[3])
        s = self.dic.get(value)
        if s is not None:
            if (par < 1 or par > len(s)):
                raise Exception("EliminarLlista: Index out of range")
            else:
                self.dic.get(value).pop(par-1)
        else:
            raise Exception("List not found")

    def visitWrite(self, ctx):
        l = list(ctx.getChildren())
        print(len(l))
        if (l[1].getText() == '['):
            print("{", end="")
            for i in range(2, len(l)-1):

                if i == 2:
                    print(l[i].getText(), end="")
                else:
                    if l[i].getText() == ']':
                        print("}", end="")

                    elif l[i].getText() == '[':
                        print(" {", end="")
                    elif l[i-1].getText() == '[':
                        print(l[i].getText(), end="")
                    else:
                        print(" " + l[i].getText(), end="")
            print("}")
        else:
            for i in range(1, len(l)):
                if l[i].getText()[0] == '"':
                    print(l[i].getText()[1:-1], end=" ")
                else:
                    value = self.visit(l[i])
                    if isinstance(value, list):
                        print("{", end="")
                        for i in range(0, len(value)):
                            if i != len(value)-1:
                                print(value[i], end=" ")
                            else:
                                print(value[i], end="")
                        print("}", end="")
                    else:
                        print(value, end=" ")
            print()

    def visitAssignacion(self, ctx):
        l = list(ctx.getChildren())
        var = self.visit(l[2])
        if isinstance(var, list):
            self.dic[l[0].getText()] = var.copy()
        else:
            self.dic[l[0].getText()] = var

    def visitLectura(self, ctx):
        l = list(ctx.getChildren())
        var = l[1].getText()
        try:
            valor = int(input())
            self.dic[var] = valor
        except:
            raise Exception("Input value must be integer")

    def visitReproduccion(self, ctx):
        l = list(ctx.getChildren())
        if (l[1].getText() == '{'):
            for i in range(2, len(l)-1):
                value = self.visit(l[i])
                value2 = self.reconvertir.get(str(value))
                self.partitura.append(value2)
        else:
            nota = self.visit(l[1])
            if isinstance(nota, list):
                for i in nota:
                    simbol = self.reconvertir.get(str(i))
                    self.partitura.append(simbol)
            else:
                simbol = self.reconvertir.get(str(nota))
                self.partitura.append(simbol)

    def visitCondicional(self, ctx):
        l = list(ctx.getChildren())
        cond = self.visit(l[1])
        if cond == 1:
            for i in range(3, len(l) - 2):
                self.visit(l[i])
        else:
            self.visit(l[len(l)-1])

    def visitSino(self, ctx):
        l = list(ctx.getChildren())
        for i in range(2, len(l)):
            self.visit(l[i])

    def visitWhile(self, ctx):
        l = list(ctx.getChildren())
        while(self.visit(l[1]) == 1):
            for i in range(3, len(l) - 1):
                self.visit(l[i])

    def visitFunction(self, ctx):
        l = list(ctx.getChildren())
        for i in l:
            self.visit(i)

    def visitInvocacion(self, ctx):

        l = list(ctx.getChildren())
        funcion = self.functions.get(l[0].getText())
        l2 = list(funcion.getChildren())

        par = []  # parametros de la funcion
        for x in range(1, len(l2)):
            x2 = l2[x].getText()
            if (x2 != '|:'):
                par.append(x2)
            else:
                break
        lenP = len(par)
        if len(l) == 0:
            lenF = 0
        else:
            lenF = len(l) - 1
        if lenP != lenF:
            raise Exception("Number of parameters proporcioned is incorrect")
        else:
            val = []  # valores de los parametros de la funcion
            for x3 in range(1, len(l)):
                val.append(self.visit(l[x3]))

            # diccionario inicial
            init_dic = self.dic.copy()

            # iniciar los parametros de la funcion
            self.dic.clear()
            for i in range(0, len(par)):
                self.dic[par[i]] = val[i]

            # ejecutar la funcion
            self.visit(funcion)

            # eliminar los parametros locales de la funcion
            self.dic.clear()

            # restaurar los parametros iniciales
            self.dic = init_dic.copy()

    def getPartitura(self):
        return self.partitura
