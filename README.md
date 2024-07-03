# Integralski sinus in ploščina Bézierove krivulje

Ta domača naloga je sestavljena iz dveh delov:

1. V prvem delu smo implementirali program za računanje vrednosti dane funkcije. Izbral sem integralski sinus: $S_i(x) = \( \int_{0}^{x} \frac{sin(t)}{t} \,dt \)$ . Za reševanje sem uporabil integracijske metode. Rešil pa sem na dva načina, najprej s trapezno metodo, nato s Simpsonovo metodo. Nato sem za obe metode pogledal na koliko podintervalov je treba razdeliti interval, da dobim rezultat z relativno natančnostjo 1e-10, za različne vhodne vrednosti x. Rezultate lahko vidimo na slikah:

2. V drugem delu pa je naloga izračunati eno samo številko. Izbral sem nalogo za izračunavanje ploščine zanke, ki jo omejuje Bézierova krivulja dana s kontrolnim poligonom: (0,0),(1,1),(2,3),(1,4),(0,4),(-1,3),(0,1),(1,0). Najprej sem implementiral funkcijo, ki izračuna točko Bézierove krivulje (parametriranje) glede na kontrolni poligon in parameter t. t je parameter krivulje, ki je med 0 in 1. Potem sem izračunal ploščino zanke, ki jo omejuje krivulja, tako da sem med vsakim dvema zaporednima točkama na krivulji (ki jih dobim z uporabo prejšnje funkcije) izračunal ploščino trapeza. Na koncu sem še ploščine vseh trapezov seštel. Torej za izračun ploščine sem uporabil trapezno metodo. Rezultat je dan na 10 decimalk.
