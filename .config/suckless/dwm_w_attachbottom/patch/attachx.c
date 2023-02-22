void
attachx(Client *c)
{
	Client *at;


	for (at = c->mon->clients; at && at->next; at = at->next);
	if (at) {
		at->next = c;
		c->next = NULL;
		return;
	}
	attach(c); // master (default)
}

