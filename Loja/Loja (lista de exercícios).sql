PGDMP     :                    |            Loja    15.4    15.4 )    $           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            %           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            &           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            '           1262    24749    Loja    DATABASE     }   CREATE DATABASE "Loja" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE "Loja";
                postgres    false            �            1255    24907    atualizar_historico_produto()    FUNCTION     $  CREATE FUNCTION public.atualizar_historico_produto() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO historico_produto (produto_id, nome, preco, estoque, data_atualizacao)
    VALUES (NEW.id, NEW.nome, NEW.preco, NEW.estoque, CURRENT_TIMESTAMP);
    RETURN NEW;
END;
$$;
 4   DROP FUNCTION public.atualizar_historico_produto();
       public          postgres    false            �            1255    24785 "   gerar_entrada_historico_produtos()    FUNCTION     )  CREATE FUNCTION public.gerar_entrada_historico_produtos() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO historico_produto (produto_id, nome, preco, estoque, data_atualizacao)
    VALUES (NEW.id, NEW.nome, NEW.preco, NEW.estoque, CURRENT_TIMESTAMP);
    RETURN NEW;
END;
$$;
 9   DROP FUNCTION public.gerar_entrada_historico_produtos();
       public          postgres    false            �            1255    24757    registro_ultima_atualizacao()    FUNCTION     �   CREATE FUNCTION public.registro_ultima_atualizacao() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.ultima_atualizacao = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;
 4   DROP FUNCTION public.registro_ultima_atualizacao();
       public          postgres    false            �            1255    24775    verifica_idade()    FUNCTION     �   CREATE FUNCTION public.verifica_idade() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.idade < 18 THEN
        NEW.endereco := NEW.endereco || ' (Menor Aprendiz)';
    END IF;
    RETURN NEW;
END;
$$;
 '   DROP FUNCTION public.verifica_idade();
       public          postgres    false            �            1259    24873    funcionarios    TABLE       CREATE TABLE public.funcionarios (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    cpf character varying(14) NOT NULL,
    email character varying(100),
    telefone character varying(15),
    idade integer,
    endereco character varying(255)
);
     DROP TABLE public.funcionarios;
       public         heap    postgres    false            �            1259    24872    funcionarios_id_seq    SEQUENCE     �   CREATE SEQUENCE public.funcionarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.funcionarios_id_seq;
       public          postgres    false    215            (           0    0    funcionarios_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.funcionarios_id_seq OWNED BY public.funcionarios.id;
          public          postgres    false    214            �            1259    24882    historico_produto    TABLE     #  CREATE TABLE public.historico_produto (
    id integer NOT NULL,
    produto_id integer NOT NULL,
    nome character varying(100) NOT NULL,
    preco numeric(10,2) NOT NULL,
    estoque integer NOT NULL,
    data_atualizacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
 %   DROP TABLE public.historico_produto;
       public         heap    postgres    false            �            1259    24881    historico_produto_id_seq    SEQUENCE     �   CREATE SEQUENCE public.historico_produto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.historico_produto_id_seq;
       public          postgres    false    217            )           0    0    historico_produto_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.historico_produto_id_seq OWNED BY public.historico_produto.id;
          public          postgres    false    216            �            1259    24890    loja    TABLE     �   CREATE TABLE public.loja (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    localizacao character varying(100) NOT NULL,
    ultima_atualizacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public.loja;
       public         heap    postgres    false            �            1259    24889    loja_id_seq    SEQUENCE     �   CREATE SEQUENCE public.loja_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.loja_id_seq;
       public          postgres    false    219            *           0    0    loja_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.loja_id_seq OWNED BY public.loja.id;
          public          postgres    false    218            �            1259    24899    produtos    TABLE     �   CREATE TABLE public.produtos (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    preco numeric(10,2) NOT NULL,
    estoque integer NOT NULL
);
    DROP TABLE public.produtos;
       public         heap    postgres    false            �            1259    24898    produtos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.produtos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.produtos_id_seq;
       public          postgres    false    221            +           0    0    produtos_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.produtos_id_seq OWNED BY public.produtos.id;
          public          postgres    false    220            x           2604    24876    funcionarios id    DEFAULT     r   ALTER TABLE ONLY public.funcionarios ALTER COLUMN id SET DEFAULT nextval('public.funcionarios_id_seq'::regclass);
 >   ALTER TABLE public.funcionarios ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214    215            y           2604    24885    historico_produto id    DEFAULT     |   ALTER TABLE ONLY public.historico_produto ALTER COLUMN id SET DEFAULT nextval('public.historico_produto_id_seq'::regclass);
 C   ALTER TABLE public.historico_produto ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            {           2604    24893    loja id    DEFAULT     b   ALTER TABLE ONLY public.loja ALTER COLUMN id SET DEFAULT nextval('public.loja_id_seq'::regclass);
 6   ALTER TABLE public.loja ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218    219            }           2604    24902    produtos id    DEFAULT     j   ALTER TABLE ONLY public.produtos ALTER COLUMN id SET DEFAULT nextval('public.produtos_id_seq'::regclass);
 :   ALTER TABLE public.produtos ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    221    221                      0    24873    funcionarios 
   TABLE DATA           W   COPY public.funcionarios (id, nome, cpf, email, telefone, idade, endereco) FROM stdin;
    public          postgres    false    215   �1                 0    24882    historico_produto 
   TABLE DATA           c   COPY public.historico_produto (id, produto_id, nome, preco, estoque, data_atualizacao) FROM stdin;
    public          postgres    false    217   �4                 0    24890    loja 
   TABLE DATA           I   COPY public.loja (id, nome, localizacao, ultima_atualizacao) FROM stdin;
    public          postgres    false    219   �4       !          0    24899    produtos 
   TABLE DATA           <   COPY public.produtos (id, nome, preco, estoque) FROM stdin;
    public          postgres    false    221   �4       ,           0    0    funcionarios_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.funcionarios_id_seq', 20, true);
          public          postgres    false    214            -           0    0    historico_produto_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.historico_produto_id_seq', 1, false);
          public          postgres    false    216            .           0    0    loja_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.loja_id_seq', 2, true);
          public          postgres    false    218            /           0    0    produtos_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.produtos_id_seq', 50, true);
          public          postgres    false    220                       2606    24880 !   funcionarios funcionarios_cpf_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.funcionarios
    ADD CONSTRAINT funcionarios_cpf_key UNIQUE (cpf);
 K   ALTER TABLE ONLY public.funcionarios DROP CONSTRAINT funcionarios_cpf_key;
       public            postgres    false    215            �           2606    24878    funcionarios funcionarios_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.funcionarios
    ADD CONSTRAINT funcionarios_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.funcionarios DROP CONSTRAINT funcionarios_pkey;
       public            postgres    false    215            �           2606    24888 (   historico_produto historico_produto_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.historico_produto
    ADD CONSTRAINT historico_produto_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.historico_produto DROP CONSTRAINT historico_produto_pkey;
       public            postgres    false    217            �           2606    24896    loja loja_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.loja
    ADD CONSTRAINT loja_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.loja DROP CONSTRAINT loja_pkey;
       public            postgres    false    219            �           2606    24904    produtos produtos_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.produtos
    ADD CONSTRAINT produtos_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.produtos DROP CONSTRAINT produtos_pkey;
       public            postgres    false    221            �           2620    24908 ,   produtos trigger_atualizar_historico_produto    TRIGGER     �   CREATE TRIGGER trigger_atualizar_historico_produto AFTER UPDATE ON public.produtos FOR EACH ROW EXECUTE FUNCTION public.atualizar_historico_produto();
 E   DROP TRIGGER trigger_atualizar_historico_produto ON public.produtos;
       public          postgres    false    221    225            �           2620    24906 1   produtos trigger_gerar_entrada_historico_produtos    TRIGGER     �   CREATE TRIGGER trigger_gerar_entrada_historico_produtos AFTER UPDATE ON public.produtos FOR EACH ROW EXECUTE FUNCTION public.gerar_entrada_historico_produtos();
 J   DROP TRIGGER trigger_gerar_entrada_historico_produtos ON public.produtos;
       public          postgres    false    221    223            �           2620    24897    loja trigger_ultima_atualizacao    TRIGGER     �   CREATE TRIGGER trigger_ultima_atualizacao BEFORE UPDATE ON public.loja FOR EACH ROW EXECUTE FUNCTION public.registro_ultima_atualizacao();
 8   DROP TRIGGER trigger_ultima_atualizacao ON public.loja;
       public          postgres    false    219    222            �           2620    24905 #   funcionarios trigger_verifica_idade    TRIGGER     �   CREATE TRIGGER trigger_verifica_idade BEFORE INSERT ON public.funcionarios FOR EACH ROW EXECUTE FUNCTION public.verifica_idade();
 <   DROP TRIGGER trigger_verifica_idade ON public.funcionarios;
       public          postgres    false    215    224               �  x�mT�n�0<������eI�:I�6���α�VR�hPv�w�)��ΒLZ�>x��w�	ݚ?�����EQ�f2/���x>�_F90�yUݱm��tT�b���9m�J,g;����j%�[��h���J�(r��	�u�J�e���JJGy1">���X�<ڦ?跏QF�ʶf�ug����C�ѣ�3JT��P�e_�vF9-{%����J�b(g6�+900"Z�b,�/��L`cT��W��4�IQ���T-C�hDV�b,8��癀�hA׍�UPb�;���eY��rtO�-�a����.u��3;QI���l_���"�YQʴ���ȐT��2T��;�Vo�꼌*�h���7�V���`��1iU�L���<<"MQ1�f�	�j�h��`����o�3���|
��6A��C���W�eQGɜnϭF/ō��=�fb�r�g'��"��ֻ��j��@: �g���0&;�M�<%xg�o�x�Ҳ�}#��?�����K!crp�d��糳
�3ڨ'մbcp�nyN�Z�I��d���;�u�#;h�����W��6g<��>����d�SJj�|�t�vVC�ݹ�U���̬��=��1Go2�x�/�Bt�Ub�w�a(���B0*�G'��^�C�_҅=�F\r������r��ɨ�q��ߕ{�p�ʞt��3�l�?c
���ɔ�����5]��و�9�9���C�eh2�e��[�����U�`iLF�u��{�p���?z�?dE����            x������ � �         G   x�3����JTp�tN�+)��4202�50�50Q02�22�25�37�010�2�(u���KT.���8F��� )�      !   5  x�M��m�0D�5YE*0�O�.R�����32^�.F��J�>�__�?�on�0k���k�kYϹf˱���k�G�5�os���խ�s��>���1ףc=��s=�9���5׫]c�����o�C]q�H�1*��T:PG�t�V�p��;d��v�J����=���4��2��]�W�=�+z@W��]��2�te@�ʀ���~L�	]���2�w{y��vCO�ʄ�Е	=�+zBW&�L�	]��z����+zAW􂮬��^>m}�����teA/�ʂ^Е��+�}�aП���`e�     