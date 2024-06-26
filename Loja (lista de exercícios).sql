PGDMP                         |            Loja    15.4    15.4                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    24749    Loja    DATABASE     }   CREATE DATABASE "Loja" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE "Loja";
                postgres    false            �            1255    24785 "   gerar_entrada_historico_produtos()    FUNCTION       CREATE FUNCTION public.gerar_entrada_historico_produtos() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO historico_produtos (Nome, Preco, Estoque, DataAtualizacao)
    VALUES (NEW.Nome, NEW.Preco, NEW.Estoque, CURRENT_TIMESTAMP);
    RETURN NEW;
END;
$$;
 9   DROP FUNCTION public.gerar_entrada_historico_produtos();
       public          postgres    false            �            1255    24757    registro_ultima_atualizacao()    FUNCTION     �   CREATE FUNCTION public.registro_ultima_atualizacao() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.UltimaAtualizacao := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;
 4   DROP FUNCTION public.registro_ultima_atualizacao();
       public          postgres    false            �            1255    24775    verifica_idade()    FUNCTION     �   CREATE FUNCTION public.verifica_idade() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.Idade < 18 THEN
        RAISE EXCEPTION 'A idade do funcionário deve ser maior ou igual a 18 anos.';
    END IF;
    RETURN NEW;
END;
$$;
 '   DROP FUNCTION public.verifica_idade();
       public          postgres    false            �            1259    24769    funcionarios    TABLE     r   CREATE TABLE public.funcionarios (
    id integer NOT NULL,
    nome character varying(100),
    idade integer
);
     DROP TABLE public.funcionarios;
       public         heap    postgres    false            �            1259    24768    funcionarios_id_seq    SEQUENCE     �   CREATE SEQUENCE public.funcionarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.funcionarios_id_seq;
       public          postgres    false    217                       0    0    funcionarios_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.funcionarios_id_seq OWNED BY public.funcionarios.id;
          public          postgres    false    216            �            1259    24778    historico_produtos    TABLE     �   CREATE TABLE public.historico_produtos (
    produtoid integer NOT NULL,
    nome character varying(100),
    preco numeric(10,2),
    estoque integer,
    dataatualizacao timestamp without time zone
);
 &   DROP TABLE public.historico_produtos;
       public         heap    postgres    false            �            1259    24777     historico_produtos_produtoid_seq    SEQUENCE     �   CREATE SEQUENCE public.historico_produtos_produtoid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.historico_produtos_produtoid_seq;
       public          postgres    false    219                       0    0     historico_produtos_produtoid_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.historico_produtos_produtoid_seq OWNED BY public.historico_produtos.produtoid;
          public          postgres    false    218            �            1259    24761    loja    TABLE     �   CREATE TABLE public.loja (
    id integer NOT NULL,
    nome character varying(100),
    localizacao character varying(100),
    ultimaatualizacao timestamp without time zone
);
    DROP TABLE public.loja;
       public         heap    postgres    false            �            1259    24760    loja_id_seq    SEQUENCE     �   CREATE SEQUENCE public.loja_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.loja_id_seq;
       public          postgres    false    215                       0    0    loja_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.loja_id_seq OWNED BY public.loja.id;
          public          postgres    false    214            s           2604    24772    funcionarios id    DEFAULT     r   ALTER TABLE ONLY public.funcionarios ALTER COLUMN id SET DEFAULT nextval('public.funcionarios_id_seq'::regclass);
 >   ALTER TABLE public.funcionarios ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            t           2604    24781    historico_produtos produtoid    DEFAULT     �   ALTER TABLE ONLY public.historico_produtos ALTER COLUMN produtoid SET DEFAULT nextval('public.historico_produtos_produtoid_seq'::regclass);
 K   ALTER TABLE public.historico_produtos ALTER COLUMN produtoid DROP DEFAULT;
       public          postgres    false    219    218    219            r           2604    24764    loja id    DEFAULT     b   ALTER TABLE ONLY public.loja ALTER COLUMN id SET DEFAULT nextval('public.loja_id_seq'::regclass);
 6   ALTER TABLE public.loja ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    214    215    215                      0    24769    funcionarios 
   TABLE DATA           7   COPY public.funcionarios (id, nome, idade) FROM stdin;
    public          postgres    false    217   �"                 0    24778    historico_produtos 
   TABLE DATA           ^   COPY public.historico_produtos (produtoid, nome, preco, estoque, dataatualizacao) FROM stdin;
    public          postgres    false    219   �"                 0    24761    loja 
   TABLE DATA           H   COPY public.loja (id, nome, localizacao, ultimaatualizacao) FROM stdin;
    public          postgres    false    215   �"                  0    0    funcionarios_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.funcionarios_id_seq', 1, false);
          public          postgres    false    216                       0    0     historico_produtos_produtoid_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.historico_produtos_produtoid_seq', 1, false);
          public          postgres    false    218                       0    0    loja_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.loja_id_seq', 1, false);
          public          postgres    false    214            x           2606    24774    funcionarios funcionarios_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.funcionarios
    ADD CONSTRAINT funcionarios_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.funcionarios DROP CONSTRAINT funcionarios_pkey;
       public            postgres    false    217            z           2606    24783 *   historico_produtos historico_produtos_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.historico_produtos
    ADD CONSTRAINT historico_produtos_pkey PRIMARY KEY (produtoid);
 T   ALTER TABLE ONLY public.historico_produtos DROP CONSTRAINT historico_produtos_pkey;
       public            postgres    false    219            v           2606    24766    loja loja_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.loja
    ADD CONSTRAINT loja_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.loja DROP CONSTRAINT loja_pkey;
       public            postgres    false    215            {           2620    24767    loja trigger_ultima_atualizacao    TRIGGER     �   CREATE TRIGGER trigger_ultima_atualizacao BEFORE UPDATE ON public.loja FOR EACH ROW EXECUTE FUNCTION public.registro_ultima_atualizacao();
 8   DROP TRIGGER trigger_ultima_atualizacao ON public.loja;
       public          postgres    false    220    215            |           2620    24776 #   funcionarios trigger_verifica_idade    TRIGGER     �   CREATE TRIGGER trigger_verifica_idade BEFORE INSERT ON public.funcionarios FOR EACH ROW EXECUTE FUNCTION public.verifica_idade();
 <   DROP TRIGGER trigger_verifica_idade ON public.funcionarios;
       public          postgres    false    221    217                  x������ � �            x������ � �            x������ � �     