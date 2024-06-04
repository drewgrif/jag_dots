/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 4;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int gappih    = 16;       /* horiz inner gap between windows */
static const unsigned int gappiv    = 16;       /* vert inner gap between windows */
static const unsigned int gappoh    = 16;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 16;       /* vert outer gap between windows and screen edge */
static int smartgaps          = 0;        /* 1 */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft  = 0;   /* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 6;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;        /* 0 means no systray */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "JetBrainsMono Nerd Font:size=12" };
static const char dmenufont[]       = "monospace:size=10";
static const char col_gray1[]       = "#00141d";
static const char col_gray2[]       = "#80bfff";
static const char col_gray3[]       = "#FFFFFF";
static const char col_gray4[]       = "#1a1a1a";
static const char col_cyan[]        = "#b3e5fc"; /* was #6CF982  */
static const char col_barbie[]      = "#4fc3f7";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray4 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_barbie  },
};
typedef struct {
	const char *name;
	const void *cmd;
} Sp;

const char *spcmd1[] = {"st", "-n", "spterm1", "-g", "100x34", "-e", "pulsemixer", NULL };
const char *spcmd2[] = {"kitty", "--class", "spterm2", "--title", "ranger", "-e", "ranger", NULL };

static Sp scratchpads[] = {
	/* name          cmd  */
	{"spterm1",      spcmd1},
	{"spterm2",      spcmd2},
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      			instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     			NULL,       NULL,       1 << 6,         0,           -1 },
	{ "GitHub Desktop", 	NULL,       NULL,       1 << 1,         0,           -1 },
	{ "obs",  				NULL,       NULL,       1 << 8,       	0,           -1 },
	{ "discord",  			NULL,       NULL,       1 << 7,       	0,           -1 },
	{ "Thunar",  			NULL,       NULL,       1 << 2,       	0,           -1 },
	{ "Geany",  			NULL,       NULL,       1 << 3,       	0,           -1 },
	{ "mpv",  				NULL,       NULL,       0,       	1,           -1 },
	{ "qimgv",    			NULL,       NULL,       0,       	1,           -1 },
	{ "Galculator",   		NULL,       NULL,       0,       	1,           -1 },
	{ "Lxappearance",   	NULL,       NULL,       0,       	1,           -1 },
	{ "Pavucontrol",  		NULL,       NULL,       0,       	1,           -1 },
	{ "Terminator", 		NULL,       NULL,       0,       	1,           -1 },
	{ NULL,		  "spterm1",	NULL,		SPTAG(0),  		1,    	-1 },
	{ NULL,		  "spterm2",	NULL,		SPTAG(1),  		1,		-1 },
};

/* window following */
#define WFACTIVE '>'
#define WFINACTIVE 'v'
#define WFDEFAULT WFACTIVE

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

#define FORCE_VSPLIT 1  /* nrowgrid layout: force two clients to always split vertically */
#include "vanitygaps.c"

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[\\]",     dwindle },
	{ ">M>",      centeredfloatingmaster }, /* first entry is default */
	{ "|M|",      centeredmaster },	
	{ "[]=",      tile },
	{ "TTT",      bstack },
	{ "###",      nrowgrid },
	{ "===",      bstackhoriz },
	{ ":::",      gaplessgrid },
	{ "[@]",      spiral },
  	{ "---",      horizgrid },
	{ "[M]",      monocle },
	{ "HHH",      grid },
	{ "H[]",      deck },
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ NULL,       NULL },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "tilix", NULL };
#include "movestack.c"

static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY,             			XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY|ControlMask,           XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_Right,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_Left,      focusstack,     {.i = -1 } },
	{ MODKEY|ControlMask,           XK_Left,      setmfact,       {.f = -0.05} },
	{ MODKEY|ControlMask,           XK_Right,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_n,      togglefollow,   {0} },
	{ MODKEY|ShiftMask,             XK_Right,      movestack,      {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_Left,      movestack,      {.i = -1 } },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,             			XK_q,      killclient,     {0} },
	{ MODKEY|ShiftMask,             XK_space,  setlayout,      {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY|Mod1Mask,              XK_u,      incrgaps,       {.i = 1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_u,      incrgaps,       {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_i,      incrigaps,      {.i = 1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_i,      incrigaps,      {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_o,      incrogaps,      {.i = 1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_o,      incrogaps,      {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_6,      incrihgaps,     {.i = 1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_6,      incrihgaps,     {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_7,      incrivgaps,     {.i = 1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_7,      incrivgaps,     {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_8,      incrohgaps,     {.i = 1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_8,      incrohgaps,     {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_9,      incrovgaps,     {.i = 1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_9,      incrovgaps,     {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_0,      togglegaps,     {0} },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_0,      defaultgaps,    {0} },
	{ ShiftMask|ControlMask,           XK_1,      setlayout,     {.v = &layouts[0] } },
	{ ShiftMask|ControlMask,           XK_2,      setlayout,     {.v = &layouts[1] } },
	{ ShiftMask|ControlMask,           XK_3,      setlayout,     {.v = &layouts[2] } },
	{ ShiftMask|ControlMask,           XK_4,      setlayout,     {.v = &layouts[3] } },
	{ ShiftMask|ControlMask,           XK_5,      setlayout,     {.v = &layouts[4] } },
	{ ShiftMask|ControlMask,           XK_6,      setlayout,     {.v = &layouts[5] } },
	{ ShiftMask|ControlMask,           XK_7,      setlayout,     {.v = &layouts[6] } },
	{ ShiftMask|ControlMask,           XK_8,      setlayout,     {.v = &layouts[7] } },
	{ ShiftMask|ControlMask,           XK_9,      setlayout,     {.v = &layouts[8] } },
	{ ShiftMask|ControlMask,           XK_0,      setlayout,     {.v = &layouts[9] } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	TAGKEYS(                        XK_0,                      9)
	TAGKEYS(                        XK_minus,                  10)
	TAGKEYS(                        XK_equal,                  11)
	{ MODKEY|Mod1Mask|ShiftMask,   	XK_Tab,      incnmaster,     {.i = +1 } },
	{ MODKEY|Mod1Mask,			    XK_Tab,      incnmaster,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
	{ MODKEY|ShiftMask,				XK_r,      quit,           {1} }, 
	{ MODKEY,            			XK_v,  	   togglescratch,  {.ui = 0 } },
	{ MODKEY,            			XK_r,  	   togglescratch,  {.ui = 1 } },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkFollowSymbol,      0,              Button1,        togglefollow,   {0} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button1,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
