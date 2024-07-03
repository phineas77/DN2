module DN2
using Plots

export integralski_sinus_trapezno, integralski_sinus_simpson, bezierova_krivulja
"""
    f(x)

Pomožna funkcija, ki predstavlja funkcijo, ki jo integriramo. V tem primeru sin(x)/x.
"""

function f(x)
    if x == 0
        return 1
    else
        return sin(x) / x
    end
end

"""
    integralski_sinus_trapezno(x, n)

Funkcija integralski_sinus_trapezno izračuna določen integral sinusne funkcije
od 0 do x z uporabo trapezne metode,z velikim številom delitev za visoko natančnost, 
in vrne rezultat zaokrožen na 10 decimalnih mest.
"""

function integralski_sinus_trapezno(x, n = 500000)
    # Definiramo korak
    h = x / n
    
    # Izračunamo vrednosti funkcije v točkah
    values = [f(i * h) for i in 0:n]
    
    # Uporabimo trapezno metodo za izračun integrala
    integral = 0.5 * h * (values[1] + 2 * sum(values[2:end-1]) + values[end])
    
    # Zaokrožimo na 10 decimalnih mest
    integral_rounded = round(integral, digits=10)
    
    return integral_rounded
end

println(integralski_sinus_trapezno(0.5))

"""
    integralski_sinus_simpson(x, n)

Funkcija integralski_sinus_simpson izračuna določen integral sinusne funkcije
 od 0 do x z uporabo Simpsonove metode, z velikim številom delitev za visoko natančnost, 
 in vrne rezultat zaokrožen na 10 decimalnih mest.
"""

function integralski_sinus_simpson(x, n = 10000)
    # Preverimo, ali je n sod ali lih
    if n % 2 != 0
        error("Število točk mora biti sodo.")
    end
    
    # Definiramo korak
    h = x / n
    
    # Izračunamo vrednosti funkcije v točkah
    values = [f(i * h) for i in 0:n]
    
    # Uporabimo Simpsonovo metodo za izračun integrala
    integral = (h / 3) * (values[1] + 4 * sum(values[2:2:end-1]) + 2 * sum(values[3:2:end-2]) + values[end])
    
    # Zaokrožimo na 10 decimalnih mest
    integral_rounded = round(integral, digits=10)
    
    return integral_rounded
end

println(integralski_sinus_simpson(0.5))


"""
    izris_trapezna()

Funkcija, ki za podane vhodne vrednosti x preveri, na koliko podintervalov (med danimi možnostmi)
je treba razdeliti dani interval, da dosežemo rezultat z relativno natančnostjo 1e-10. 
Uporablja trapezno metodo. Na koncu izriše graf, ki prikazuje odvisnost števila 
podintervalov od vhodnih vrednosti za trapezno metodo.
"""

function izris_trapezna()
    x_osa = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    rezultati = [0, 0.9460830704, 1.6054129768, 1.848652528, 1.7582031389, 1.5499312449, 1.4246875513, 1.4545966142, 1.5741868217, 1.6650400758, 1.6583475942]
    br = 0
    y_trapez = zeros(length(x_osa))
    for x in [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        br = br + 1
        for n in [10, 100, 1000, 10000, 100000, 200000, 300000, 400000, 500000]
            #println(br)
            if isapprox(integralski_sinus_trapezno(x, n), rezultati[br], atol=1e-10)
                y_trapez[br] = n
                break
            end
        end
    end
    #println(y)
    #return y
    plot(x_osa, y_trapez, xlabel="vhodna vrednost", ylabel="število podintervalov (n)", title="Trapezna metoda: odvisnost števila podintervalov od vhodne vrednosti", titlefont = font(9))

end
izris_trapezna()


"""
    izris_simpsonova()

Funkcija, ki za dane vhodne vrednosti `x` preveri na koliko podintervalov (od danih možnosti) potrebujemo razdeliti dani 
interval, da dobimo rezultat z relativno natačnostjo `1e-10`. 
Uporablja Simpsonovo metodo. 
Na koncu izriše graf odvisnosti števila podintervalov za vhodne vrednosti za Simpsonovo metodo.
"""

function izris_simpsonova()
    x_osa = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    rezultati = [0, 0.9460830704, 1.6054129768, 1.848652528, 1.7582031389, 1.5499312449, 1.4246875513, 1.4545966142, 1.5741868217, 1.6650400758, 1.6583475942]
    br = 0
    y_simpson = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    for x in [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        br = br + 1
        for n in [10, 100, 1000, 10000, 100000, 200000, 300000, 400000, 500000]
            if isapprox(integralski_sinus_simpson(x, n), rezultati[br], atol=1e-10)
                y_simpson[br] = n
                break
            end
        end
    end

    plot(x_osa, y_simpson, xlabel="vhodna vrednost", ylabel="število podintervalov (n)", title="Simpsonova metoda: odvisnost števila podintervalov od vhodne vrednosti", titlefont = font(9))

end

izris_simpsonova()


"""
    bezierova_krivulja(t, tocke)

Funkcija, ki izračuna točko Bezierove krivulje (parametrizacija) glede na kontrolni poligon in parameter `t`. Parameter t je med 0 in 1.

Primer: vhod: bezierova_krivulja(0.5, [[0,0],[1,1],[2,3],[1,4],[0,4],[-1,3],[0,1],[1,0]])
izhod: 2-elementni vektor |0.5    |
                          |3.28125|
"""

function bezierova_krivulja(t, tocke)
    n = length(tocke) - 1  # Stopnja Bezierove krivulje

    # Iterativno izračunamo točko na Bezierovi krivulji
    rezultat = zeros(length(tocke[1]))
    for (i, tocka) in enumerate(tocke)
        binomski_koeficient = factorial(n) / (factorial(i - 1) * factorial(n - i + 1))
        rezultat .+= binomski_koeficient * (1 - t)^(n - i + 1) * t^(i - 1) * tocka
    end

    return rezultat
end

rezultat = bezierova_krivulja(0.5, [[0,0],[1,1],[2,3],[1,4],[0,4],[-1,3],[0,1],[1,0]])
println(rezultat)


"""
    ploscina(kontrolne_točke)

Funkcija, ki izračuna površino zanke, ki jo omejuje Bezierova krivulja, določena s kontrolnim poligonom. 
Uporablja trapezno metodo, tako da med vsakima dvema zaporednima točkama na krivulji izračuna površino trapeza in 
potem sešteje površine vseh teh trapezov.

Primer: vhod: ploscina([[0,0],[1,1],[2,3],[1,4],[0,4],[-1,3],[0,1],[1,0]])
        izhod: 1.9666243931
"""


function ploscina(kontrolne_tocke)
    i = 0.01  
    ploscina = 0.0
    for t in 0:i:1
        tocka1 = bezierova_krivulja(t, kontrolne_tocke)
        tocka2 = bezierova_krivulja(t + i, kontrolne_tocke)
        h = tocka1[1] - tocka2[1]
        trapez = (tocka1[2] + tocka2[2]) * h  / 2
        ploscina += trapez
    end
    return round(abs(ploscina); digits=10)
end

# Primer uporabe funkcije
kontrolni_poligon = [[0,0],[1,1],[2,3],[1,4],[0,4],[-1,3],[0,1],[1,0]]
rezultat = ploscina(kontrolni_poligon)
end # module DN2