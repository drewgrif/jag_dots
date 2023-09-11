From 58414bee958f2e7ed91d6fe31f503ec4a406981b Mon Sep 17 00:00:00 2001
From: cirala <thim@cederlund.de>
Date: Fri, 19 Nov 2021 18:14:07 +0100
Subject: [PATCH] Fix for dwm-uselessgap
Previous versions of the patch doubles the
gap between the master and slave stacks.

---
 config.def.h |  3 ++-
 dwm.c        | 38 +++++++++++++++++++++++++++++++-------
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/config.def.h b/config.def.h
index a2ac963..17a205f 100644
--- a/config.def.h
+++ b/config.def.h
@@ -2,6 +2,7 @@

 /* appearance */
 static const unsigned int borderpx  = 1;        /* border pixel of windows */
+static const unsigned int gappx     = 6;        /* gaps between windows */
 static const unsigned int snap      = 32;       /* snap pixel */
 static const int showbar            = 1;        /* 0 means no bar */
 static const int topbar             = 1;        /* 0 means bottom bar */
@@ -34,7 +35,7 @@ static const Rule rules[] = {
 /* layout(s) */
 static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
 static const int nmaster     = 1;    /* number of clients in master area */
-static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
+static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
 static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

 static const Layout layouts[] = {
diff --git a/dwm.c b/dwm.c
index 5e4d494..b626e89 100644
--- a/dwm.c
+++ b/dwm.c
@@ -52,8 +52,8 @@
 #define ISVISIBLE(C)            ((C->tags & C->mon->tagset[C->mon->seltags]))
 #define LENGTH(X)               (sizeof X / sizeof X[0])
 #define MOUSEMASK               (BUTTONMASK|PointerMotionMask)
-#define WIDTH(X)                ((X)->w + 2 * (X)->bw)
-#define HEIGHT(X)               ((X)->h + 2 * (X)->bw)
+#define WIDTH(X)                ((X)->w + 2 * (X)->bw + gappx)
+#define HEIGHT(X)               ((X)->h + 2 * (X)->bw + gappx)
 #define TAGMASK                 ((1 << LENGTH(tags)) - 1)
 #define TEXTW(X)                (drw_fontset_getwidth(drw, (X)) + lrpad)

@@ -1277,12 +1277,36 @@ void
 resizeclient(Client *c, int x, int y, int w, int h)
 {
 	XWindowChanges wc;
+	unsigned int n;
+	unsigned int gapoffset;
+	unsigned int gapincr;
+	Client *nbc;

-	c->oldx = c->x; c->x = wc.x = x;
-	c->oldy = c->y; c->y = wc.y = y;
-	c->oldw = c->w; c->w = wc.width = w;
-	c->oldh = c->h; c->h = wc.height = h;
 	wc.border_width = c->bw;
+
+	/* Get number of clients for the client's monitor */
+	for (n = 0, nbc = nexttiled(c->mon->clients); nbc; nbc = nexttiled(nbc->next), n++);
+
+	/* Do nothing if layout is floating */
+	if (c->isfloating || c->mon->lt[c->mon->sellt]->arrange == NULL) {
+		gapincr = gapoffset = 0;
+	} else {
+		/* Remove border and gap if layout is monocle or only one client */
+		if (c->mon->lt[c->mon->sellt]->arrange == monocle || n == 1) {
+			gapoffset = 0;
+			gapincr = -2 * borderpx;
+			wc.border_width = 0;
+		} else {
+			gapoffset = gappx;
+			gapincr = 2 * gappx;
+		}
+	}
+
+	c->oldx = c->x; c->x = wc.x = x + gapoffset;
+	c->oldy = c->y; c->y = wc.y = y + gapoffset;
+	c->oldw = c->w; c->w = wc.width = w - gapincr;
+	c->oldh = c->h; c->h = wc.height = h - gapincr;
+
 	XConfigureWindow(dpy, c->win, CWX|CWY|CWWidth|CWHeight|CWBorderWidth, &wc);
 	configure(c);
 	XSync(dpy, False);
@@ -1688,7 +1712,7 @@ tile(Monitor *m)
 	for (i = my = ty = 0, c = nexttiled(m->clients); c; c = nexttiled(c->next), i++)
 		if (i < m->nmaster) {
 			h = (m->wh - my) / (MIN(n, m->nmaster) - i);
-			resize(c, m->wx, m->wy + my, mw - (2*c->bw), h - (2*c->bw), 0);
+			resize(c, m->wx, m->wy + my, mw - (2*c->bw) + (n > 1 ? gappx : 0), h - (2*c->bw), 0);
 			if (my + HEIGHT(c) < m->wh)
 				my += HEIGHT(c);
 		} else {
--
2.33.1

