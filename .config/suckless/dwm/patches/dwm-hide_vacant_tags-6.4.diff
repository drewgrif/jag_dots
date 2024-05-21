:100644 100644 f1d86b2 0000000 M	dwm.c

diff --git a/dwm.c b/dwm.c
index f1d86b2..d41cc14 100644
--- a/dwm.c
+++ b/dwm.c
@@ -433,9 +433,15 @@ buttonpress(XEvent *e)
 	}
 	if (ev->window == selmon->barwin) {
 		i = x = 0;
-		do
+		unsigned int occ = 0;
+		for(c = m->clients; c; c=c->next)
+			occ |= c->tags == TAGMASK ? 0 : c->tags;
+		do {
+			/* Do not reserve space for vacant tags */
+			if (!(occ & 1 << i || m->tagset[m->seltags] & 1 << i))
+				continue;
 			x += TEXTW(tags[i]);
-		while (ev->x >= x && ++i < LENGTH(tags));
+		} while (ev->x >= x && ++i < LENGTH(tags));
 		if (i < LENGTH(tags)) {
 			click = ClkTagBar;
 			arg.ui = 1 << i;
@@ -715,19 +721,18 @@ drawbar(Monitor *m)
 	}
 
 	for (c = m->clients; c; c = c->next) {
-		occ |= c->tags;
+		occ |= c->tags == TAGMASK ? 0 : c->tags;
 		if (c->isurgent)
 			urg |= c->tags;
 	}
 	x = 0;
 	for (i = 0; i < LENGTH(tags); i++) {
+		/* Do not draw vacant tags */
+		if(!(occ & 1 << i || m->tagset[m->seltags] & 1 << i))
+			continue;
 		w = TEXTW(tags[i]);
 		drw_setscheme(drw, scheme[m->tagset[m->seltags] & 1 << i ? SchemeSel : SchemeNorm]);
 		drw_text(drw, x, 0, w, bh, lrpad / 2, tags[i], urg & 1 << i);
-		if (occ & 1 << i)
-			drw_rect(drw, x + boxs, boxs, boxw, boxw,
-				m == selmon && selmon->sel && selmon->sel->tags & 1 << i,
-				urg & 1 << i);
 		x += w;
 	}
 	w = TEXTW(m->ltsymbol);
