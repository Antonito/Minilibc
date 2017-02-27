##
## rules.mk for minilibc in /School/asm_minilibc
##
## Made by Antoine Baché
## Login   <antoine.bache@epitech.net>
##
## Started on  Mon Feb 27 11:40:32 2017 Antoine Baché
## Last update Mon Feb 27 11:40:43 2017 Antoine Baché
##

OBJ_DIR=	./obj/
OBJ_C=		$(SRC:$(SRC_DIR)%.c=$(OBJ_DIR)%.o)
OBJ_AS=		$(SRC:$(SRC_DIR)%.s=$(OBJ_DIR)%.o)
OBJ_BONUS_AS=	$(SRC:$(BONUS_DIR)%.s=$(OBJ_DIR)%.o)
OBJ=		$(filter %.o, $(OBJ_C) $(OBJ_AS) $(OBJ_BONUS_AS))

NAME_EXTENSION=	$(suffix $(NAME))
ifeq ($(MODE),)
MODE=		bin
endif
CALLER=		""

# Messages
OK_GEN:=	$(ECHO) "$(WHITE)[$(GREEN)OK$(WHITE)] Generated $(CYAN)"$(NAME)"\n$(CLEAR)"
KO_GEN:=	$(ECHO) "$(WHITE)[$(RED)KO$(WHITE)] Generated $(CYAN)"$(NAME)"\n$(CLEAR)"
OK_LINK:=	$(ECHO) "$(WHITE)[$(GREEN)OK$(WHITE)] Linked $(CYAN)"$(NAME)"\n$(CLEAR)"
KO_LINK:=	$(ECHO) "$(WHITE)[$(RED)KO$(WHITE)] Linked $(CYAN)"$(NAME)"\n$(CLEAR)"
RM_OBJ:=	$(ECHO) "$(WHITE)[$(YELLOW)RM$(WHITE)] Removed OBJs files [$(MODE)]\n$(CLEAR)"
RM_BIN:=	$(ECHO) "$(WHITE)[$(YELLOW)RM$(WHITE)] Removed $(CYAN)"$(NAME)"\n$(CLEAR)"
INSTALLED:=	$(ECHO) "$(WHITE)[$(PURPLE)CP$(WHITE)] Installed $(CYAN)"$(NAME)"\n$(CLEAR)"
CANT_INSTALL:=  $(ECHO) "$(WHITE)[$(PURPLE)CP$(WHITE)] Cannot install $(CYAN)"$(NAME)"\n$(CLEAR)"
NOT_EXEC:=	$(ECHO) "$(WHITE)[$(PURPLE)CP$(WHITE)] Not an executable, skipping ...\n$(CLEAR)"
UNINSTALLED:=	$(ECHO) "$(WHITE)[$(RED)RM$(WHITE)] Uninstalled $(CYAN)"$(NAME)"\n$(CLEAR)"
NOT_INSTALLED:=	$(ECHO) "$(WHITE)[$(RED)RM$(WHITE)] Not an installed, skipping ...\n$(CLEAR)"
NO_TEST:=	$(ECHO) "$(WHITE)No test available.$(CLEAR)\n"
NO_BENCH:=	$(ECHO) "$(WHITE)No benchmark available.$(CLEAR)\n"

# Rules
$(NAME):	$(OBJ)
ifeq ($(NAME_EXTENSION),.a)
		@$(RANLIB) $(NAME) $(OBJ) && $(OK_GEN) || $(KO_GEN)
else
		@$(CC) $(OBJ) $(LDFLAGS) -o $(NAME) && $(OK_LINK) || $(KO_LINK)
endif

$(OBJ_DIR)%.o:	$(SRC_DIR)%.c
		@$(CC) $(CFLAGS) -c -o $@ $< && \
		$(ECHO) "$(WHITE)[$(GREEN)OK$(WHITE)] Compiled "$<"\n$(CLEAR)" || \
		$(ECHO) "$(WHITE)[$(RED)KO$(WHITE)] Compiled "$<"\n$(CLEAR)"

$(OBJ_DIR)%.o:	$(BONUS_DIR)%.s
		@$(AS) $(ASFLAGS) -o $@ $< && \
		$(ECHO) "$(WHITE)[$(GREEN)OK$(WHITE)] Compiled "$<"\n$(CLEAR)" || \
		$(ECHO) "$(WHITE)[$(RED)KO$(WHITE)] Compiled "$<"\n$(CLEAR)"

$(OBJ_DIR)%.o:	$(SRC_DIR)%.s
		@$(AS) $(ASFLAGS) -o $@ $< && \
		$(ECHO) "$(WHITE)[$(GREEN)OK$(WHITE)] Compiled "$<"\n$(CLEAR)" || \
		$(ECHO) "$(WHITE)[$(RED)KO$(WHITE)] Compiled "$<"\n$(CLEAR)"

all:		$(NAME)

infos:
		@$(ECHO) "$(CYAN)Compiler:\t\t$(CC)\n"
		@$(ECHO) "Compilation Flags:\t$(CFLAGS)\n"
ifeq ($(NAME_EXTENSION),.a)
		@$(ECHO) "Library Generation:\t$(RANLIB)\n$(CLEAR)"
else
		@$(ECHO) "Link Flags:\t\t$(LDFLAGS)\n$(CLEAR)"
endif

fclean:		CALLER="fclean"
fclean:		clean
		@$(RM) $(NAME)
		@$(RM_BIN)
		@$(MAKE) -s -i --warn-undefined-variables -C $(BENCH_DIR) fclean $(IGNORE)
		@$(MAKE) -s -i --warn-undefined-variables -C $(TEST_DIR) fclean $(IGNORE)

# We must use bash conditions because Make evaluates conditions at parsing-time.
clean:
		@$(RM) $(OBJ)
		@$(RM_OBJ)
		@if [ $(CALLER) != "fclean" ] ; then \
		$(MAKE) -s -i --warn-undefined-variables -C $(BENCH_DIR) clean $(IGNORE); \
		$(MAKE) -s -i --warn-undefined-variables -C $(TEST_DIR) clean $(IGNORE); \
		fi

re:		fclean all
		@$(MAKE) -s -i --warn-undefined-variables -C $(BENCH_DIR) $(IGNORE); \
		$(MAKE) -s -i --warn-undefined-variables -C $(TEST_DIR) $(IGNORE); \

bench:
		@$(MAKE) -s --warn-undefined-variables -C $(BENCH_DIR) re 2> /dev/null && \
		$(MAKE) -s --warn-undefined-variables -C $(BENCH_DIR) run || $(NO_BENCH)
test:
		@$(MAKE) -s --warn-undefined-variables -C $(TEST_DIR) re 2> /dev/null && \
		$(MAKE) -s --warn-undefined-variables -C $(TEST_DIR) run || $(NO_TEST)

.PHONY: all clean fclean re run bench test
