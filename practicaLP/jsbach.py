from antlr4 import *
from jsbachLexer import jsbachLexer
from jsbachParser import jsbachParser
from TreeVisitor import TreeVisitor
import sys
import os
import platform

input_stream = FileStream(sys.argv[1], encoding="utf-8")

lexer = jsbachLexer(input_stream)
token_stream = CommonTokenStream(lexer)
parser = jsbachParser(token_stream)
tree = parser.root()

if (len(sys.argv) == 2):
    arguments = []
    visitor = TreeVisitor('Main', arguments)
    visitor.visit(tree)
elif (len(sys.argv) == 3):
    arguments = []
    visitor = TreeVisitor(sys.argv[2], arguments)
    visitor.visit(tree)
else:
    arguments = []
    for i in range(3, len(sys.argv)):
        arguments.append(sys.argv[i])
    visitor = TreeVisitor(sys.argv[2], arguments)
    visitor.visit(tree)

partitura = visitor.getPartitura()

if partitura:
    p = ' '.join(map(str, partitura))

    fichero = sys.argv[1][0:-4]

    f = open(fichero + '.lily', mode='w')

    f.write("""\\version "2.22.1"
               \\score { 
                    \\absolute {
                    \\tempo 4 = 120
            """)

    f.write(p)

    f.write("""}
                  \\layout { }
                  \\midi { }
                } 
            """)

    f.close()

    os.system("lilypond " + fichero + '.lily')

    os.system("timidity -Ow -o " + fichero + ".wav " + fichero + ".midi")

    os.system("ffmpeg -i " + fichero +
              ".wav -codec:a libmp3lame -qscale:a 2 " + fichero + ".mp3")

    system = platform.system()
    if system == "Darwin":
        os.system("afplay " + fichero + ".mp3")
    elif system == "Linux":
        os.system("nvlc " + fichero + ".mp3")
    else:
        raise Exception("It seems like you are not in either Linux or Mac OS")


        

