## ------------------------------------#
#  GNUPLOT script za crtanje dijagrama #
# -------------------------------------#

U0 = 1
nu = 1e-4
L = 2.0
Re_L = U0*L/nu
x_1 = 0.5
x_2 = 1.0
x_3 = 1.5
Rex_1 = U0*x_1/nu
Rex_2 = U0*x_2/nu
Rex_3 = U0*x_3/nu

latestTime = 2551
set loadpath sprintf("postProcessing/profili_brzine/%d", latestTime)

set grid
set terminal pdf
set xlabel 'u/U_0'
set key top left

set out 'u.pdf'
set xlabel "y [m]"
set ylabel "u/U_0 [-]
set title sprintf("Профил аксијалне брзине у граничном слоју (Re = %.4e)" , Re_L)
set key bottom right
plot 'x_1.xy' with lines lw 2 title 'x=0.5m', \
     'x_3.xy' using 1:2 with lines lw 2 title 'x=1.5m'


set out 'v.pdf'
set key bottom right
set xlabel "y [m]"
set ylabel "v/U_0 [-]
set title sprintf("Профил попречне брзине у граничном слоју (Re = %.4e)", Re_L)
plot [0:0.2] [0:] 'x_1.xy' using 1:3 with lines lw 2 title 'CFD (x = 0.5m)',\
     'x_3.xy' using 1:3 with lines lw 2 title 'CFD (x = 1.5m)'


set out "tau_w.pdf"
set xlabel "{/Times-Italics x/L} [-]"
set ylabel "{/Symbol-Italic t}_w"
set title "Профил смицајног напона на плочи"
set sample 500
set key top right
plot [-0.1:] [-0.01:] 'postProcessing/profil_tau_w/2551/line.xy' using 1:(sqrt(($2)**2 + ($3)**2)) every 10 pt 7 ps 0.5  title 'CFD', \
     'postProcessing/profil_tau_w/2551/line.xy' using 1:(sqrt(($2)**2 + ($3)**2)) with lines ls 1 notitle, \
     0.5*0.664*sqrt(nu/x) with lines lw 2 title 'Blasius'


# ---- Bezdimenzijski profili brzina
set out "u_eta.pdf"
set key bottom right
set xlabel "{/Symbol-Italic h [-]}"
set ylabel "{/Helvetica-Italic u/U_0}"
set title "Профил бездимензијске аксијалне брзине"
plot 'blasius.txt' using 1:3 pt 7 ps 0.75 title "Blasius", \
     'x_3.xy' using ($1*sqrt(U0/(2*nu*x_3))):($2/U0) with lines lw 2 title "CFD"

set out "v_eta.pdf"
set key bottom right
set title "Профил бездимензијске попречне брзине"
set xlabel "{/Symbol-Italic h [-]}"
set ylabel "Re_x {/Helvetica-Italic v/U_0 }"
set xrange [0:12]
set yrange [0:1]
plot 'blasius.txt' using 1:(sqrt(0.5)*($1*$3 - $2)) pt 7 ps 0.75 title "Blasius", \
     'x_3.xy' using ($1*sqrt(U0/(2*nu*x_3))):(sqrt(Rex_3)*$3/U0) with lines lw 2 title "CFD