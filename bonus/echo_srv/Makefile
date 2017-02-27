include ../../mk/colors.mk

ECHO:=		echo -ne

NAME:=		echo_srv

AS:=		nasm
ASFLAGS:=	-f elf64 -O3 -I${PWD}/include/

LD:=		ld

VPATH:=		./src/

OBJ_DIR:=	./obj/

SRC:=		atoi.s		\
		client.s	\
		errors.s	\
		io.s		\
		main.s		\
		put.s		\
		select.s	\
		socket.s	\
		srv.s		\
		strlen.s

OBJ:=		$(SRC:%.s=$(OBJ_DIR)%.o)

OK_LINK:=	$(ECHO) "$(WHITE)[$(GREEN)OK$(WHITE)] Linked $(CYAN)"$(NAME)"\n$(CLEAR)"
KO_LINK:=	$(ECHO) "$(WHITE)[$(RED)KO$(WHITE)] Linked $(CYAN)"$(NAME)"\n$(CLEAR)"
RM_OBJ:=	$(ECHO) "$(WHITE)[$(YELLOW)RM$(WHITE)] Removed OBJs files\n$(CLEAR)"
RM_BIN:=	$(ECHO) "$(WHITE)[$(YELLOW)RM$(WHITE)] Removed $(CYAN)"$(NAME)"\n$(CLEAR)"

$(NAME):	$(OBJ)
		@$(LD) $(OBJ) -o $(NAME) && $(OK_LINK) || $(KO_LINK)

$(OBJ_DIR)%.o:	%.s
		@$(AS) $(ASFLAGS) -o $@ $< && \
		$(ECHO) "$(WHITE)[$(GREEN)OK$(WHITE)] Compiled "$<"\n$(CLEAR)" || \
		$(ECHO) "$(WHITE)[$(RED)KO$(WHITE)] Compiled "$<"\n$(CLEAR)"

all:		$(NAME)

clean:
		@$(RM) $(OBJ)
		@$(RM_OBJ)

fclean:		clean
		@$(RM) $(NAME)
		@$(RM_BIN)

re:		fclean all

.PHONY: clean fclean re all
