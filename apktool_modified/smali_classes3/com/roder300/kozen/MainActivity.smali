.class public final Lcom/roder300/kozen/MainActivity;
.super Landroidx/appcompat/app/AppCompatActivity;
.source "MainActivity.kt"

# interfaces
.implements Landroid/view/SurfaceHolder$Callback;
.implements Landroid/hardware/Camera$FaceDetectionListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/roder300/kozen/MainActivity$SoundManager;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nMainActivity.kt\nKotlin\n*S Kotlin\n*F\n+ 1 MainActivity.kt\ncom/roder300/kozen/MainActivity\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n+ 3 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,2284:1\n1#2:2285\n1863#3,2:2286\n1863#3,2:2288\n1863#3,2:2290\n*S KotlinDebug\n*F\n+ 1 MainActivity.kt\ncom/roder300/kozen/MainActivity\n*L\n1043#1:2286,2\n1081#1:2288,2\n2034#1:2290,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u00c1\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u000e\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0008\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\u0007\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010%\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\t\n\u0002\u0008\u0003\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0013\n\u0002\u0010\u0007\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0016\n\u0002\u0008\n\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0006\n\u0002\u0018\u0002\n\u0002\u0008\u000e\n\u0002\u0018\u0002\n\u0002\u0008\t\n\u0002\u0018\u0002\n\u0002\u0008\u0010\n\u0002\u0018\u0002\n\u0002\u0008\u0016\n\u0002\u0010\u0011\n\u0000\n\u0002\u0010\u0015\n\u0002\u0008\u000b\n\u0002\u0018\u0002\n\u0002\u0008\t\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0006\n\u0002\u0018\u0002\n\u0002\u0008\u0008*\u0003[\u0097\u0001\u0008\u0007\u0018\u00002\u00020\u00012\u00020\u00022\u00020\u0003:\u0002\u0095\u0002B\u0007\u00a2\u0006\u0004\u0008\u0004\u0010\u0005J\u0012\u0010g\u001a\u00020h2\u0008\u0010i\u001a\u0004\u0018\u00010jH\u0014J\u0006\u0010k\u001a\u00020hJ\u0010\u0010l\u001a\u00020h2\u0008\u0008\u0002\u0010m\u001a\u00020\u0007J\u0010\u0010n\u001a\u00020h2\u0006\u0010o\u001a\u00020\u0007H\u0002J\u0008\u0010p\u001a\u00020hH\u0002J\u0018\u0010q\u001a\u00020h2\u0006\u0010r\u001a\u00020\'2\u0008\u0008\u0002\u0010s\u001a\u00020\u000bJ\u0008\u0010t\u001a\u00020hH\u0014J\u0008\u0010u\u001a\u00020hH\u0014J\u0008\u0010v\u001a\u00020hH\u0014J>\u0010w\u001a\u00020h2\u0006\u0010x\u001a\u00020\'2\u0006\u0010y\u001a\u00020\u000b2\u0008\u0008\u0002\u0010z\u001a\u00020\u00122\u0008\u0008\u0002\u0010{\u001a\u00020\u00122\u0008\u0008\u0002\u0010|\u001a\u00020\u00122\u0008\u0008\u0002\u0010}\u001a\u00020~J\u001b\u0010\u007f\u001a\u00030\u0080\u00012\u0008\u0010\u0081\u0001\u001a\u00030\u0080\u00012\u0006\u0010}\u001a\u00020~H\u0002J\t\u0010\u0082\u0001\u001a\u00020hH\u0002J\t\u0010\u0083\u0001\u001a\u00020hH\u0002J\t\u0010\u0084\u0001\u001a\u00020\u0007H\u0002J\t\u0010\u0085\u0001\u001a\u00020hH\u0002J\t\u0010\u0086\u0001\u001a\u00020hH\u0002J\t\u0010\u0094\u0001\u001a\u00020hH\u0002J\t\u0010\u0095\u0001\u001a\u00020hH\u0002J\u0014\u0010\u0099\u0001\u001a\u00020h2\t\u0008\u0002\u0010\u009a\u0001\u001a\u00020\u0007H\u0002J\t\u0010\u009b\u0001\u001a\u00020hH\u0002J\t\u0010\u009c\u0001\u001a\u00020hH\u0002J\t\u0010\u009d\u0001\u001a\u00020hH\u0002J\t\u0010\u009e\u0001\u001a\u00020hH\u0002J\u0013\u0010\u009f\u0001\u001a\u00020h2\u0008\u0010\u00a0\u0001\u001a\u00030\u00a1\u0001H\u0014J\u0013\u0010\u00a2\u0001\u001a\u00020h2\u0008\u0010\u00a0\u0001\u001a\u00030\u00a1\u0001H\u0002J\u0013\u0010\u00a3\u0001\u001a\u00020h2\u0008\u0010\u00a4\u0001\u001a\u00030\u00a5\u0001H\u0002J\t\u0010\u00a6\u0001\u001a\u00020hH\u0002J\t\u0010\u00a7\u0001\u001a\u00020hH\u0002J\t\u0010\u00a8\u0001\u001a\u00020hH\u0002J%\u0010\u00a9\u0001\u001a\u00020h2\u0007\u0010\u00aa\u0001\u001a\u00020\'2\u0008\u0010\u00ab\u0001\u001a\u00030\u00ac\u00012\u0007\u0010\u00ad\u0001\u001a\u00020\'H\u0002J%\u0010\u00ae\u0001\u001a\u00020h2\u0007\u0010\u00af\u0001\u001a\u00020\'2\u000b\u0008\u0002\u0010\u00b0\u0001\u001a\u0004\u0018\u00010\u0007H\u0002\u00a2\u0006\u0003\u0010\u00b1\u0001J\t\u0010\u00b2\u0001\u001a\u00020hH\u0002J\t\u0010\u00b3\u0001\u001a\u00020hH\u0002J\u001b\u0010\u00b4\u0001\u001a\u00020h2\u0007\u0010\u00b5\u0001\u001a\u00020\'2\u0007\u0010\u00b6\u0001\u001a\u00020\u0012H\u0002J\u001d\u0010\u00b7\u0001\u001a\u00020h2\u0007\u0010\u00b5\u0001\u001a\u00020\'2\t\u0008\u0002\u0010\u00b8\u0001\u001a\u00020~H\u0002J\u0013\u0010\u00b9\u0001\u001a\u00020h2\u0008\u0010\u00ba\u0001\u001a\u00030\u00bb\u0001H\u0002J\t\u0010\u00bc\u0001\u001a\u00020hH\u0002J&\u0010\u00bd\u0001\u001a\u00020h2\u0008\u0010\u00be\u0001\u001a\u00030\u00bb\u00012\u000b\u0008\u0002\u0010\u00b0\u0001\u001a\u0004\u0018\u00010\u0007H\u0002\u00a2\u0006\u0003\u0010\u00bf\u0001J\u0010\u0010\u00c0\u0001\u001a\u00020\'2\u0007\u0010\u00c1\u0001\u001a\u00020\'J\"\u0010\u00c2\u0001\u001a\u00020h2\u0007\u0010\u00c3\u0001\u001a\u00020>2\u000e\u0010\u00c4\u0001\u001a\t\u0012\u0004\u0012\u00020h0\u00c5\u0001H\u0002J1\u0010\u00c6\u0001\u001a\u00020h2\u0007\u0010\u00c7\u0001\u001a\u00020>2\t\u0008\u0002\u0010\u00c8\u0001\u001a\u00020\u00072\t\u0008\u0002\u0010\u00c9\u0001\u001a\u00020\u00122\t\u0008\u0002\u0010\u00ca\u0001\u001a\u00020~J\u0012\u0010\u00cb\u0001\u001a\u00020h2\u0007\u0010\u00c1\u0001\u001a\u00020\'H\u0002J\t\u0010\u00cc\u0001\u001a\u00020hH\u0002J\u0012\u0010\u00cd\u0001\u001a\u00020h2\u0007\u0010\u00ce\u0001\u001a\u00020\'H\u0002J\t\u0010\u00cf\u0001\u001a\u00020hH\u0002J\u0013\u0010\u00d0\u0001\u001a\u00020h2\u0008\u0010\u00d1\u0001\u001a\u00030\u00ac\u0001H\u0002J\t\u0010\u00d2\u0001\u001a\u00020\u0007H\u0002J\t\u0010\u00d3\u0001\u001a\u00020hH\u0002J\t\u0010\u00d4\u0001\u001a\u00020hH\u0002J\n\u0010\u00d5\u0001\u001a\u00030\u00d6\u0001H\u0002J\t\u0010\u00d7\u0001\u001a\u00020\'H\u0002J\u000b\u0010\u00d8\u0001\u001a\u0004\u0018\u00010\'H\u0002J\t\u0010\u00d9\u0001\u001a\u00020\u0012H\u0002J\t\u0010\u00da\u0001\u001a\u00020\u0007H\u0002J\u0012\u0010\u00db\u0001\u001a\u00020h2\u0007\u0010\u00dc\u0001\u001a\u00020\'H\u0002J\u0012\u0010\u00dd\u0001\u001a\u00020h2\u0007\u0010\u00de\u0001\u001a\u00020\u000bH\u0002J\r\u0010\u00df\u0001\u001a\u00020~*\u00020~H\u0002J\r\u0010\u00df\u0001\u001a\u00020\u0012*\u00020\u0012H\u0002J\t\u0010\u00e0\u0001\u001a\u00020hH\u0002J\t\u0010\u00e1\u0001\u001a\u00020hH\u0002J\u0012\u0010\u00e2\u0001\u001a\u00020h2\u0007\u0010\u00e3\u0001\u001a\u00020\u0007H\u0016J\t\u0010\u00e4\u0001\u001a\u00020hH\u0002J\t\u0010\u00e5\u0001\u001a\u00020hH\u0002J\t\u0010\u00e6\u0001\u001a\u00020hH\u0002J\t\u0010\u00e7\u0001\u001a\u00020hH\u0002J\t\u0010\u00e8\u0001\u001a\u00020hH\u0016J\t\u0010\u00e9\u0001\u001a\u00020hH\u0002J4\u0010\u00ea\u0001\u001a\u00020h2\u0007\u0010\u00eb\u0001\u001a\u00020\u00122\u0010\u0010\u00ec\u0001\u001a\u000b\u0012\u0006\u0008\u0001\u0012\u00020\'0\u00ed\u00012\u0008\u0010\u00ee\u0001\u001a\u00030\u00ef\u0001H\u0016\u00a2\u0006\u0003\u0010\u00f0\u0001J\t\u0010\u00f1\u0001\u001a\u00020hH\u0002J\t\u0010\u00f2\u0001\u001a\u00020hH\u0002J\t\u0010\u00f3\u0001\u001a\u00020hH\u0002J\t\u0010\u00f4\u0001\u001a\u00020\u0007H\u0002J\t\u0010\u00f5\u0001\u001a\u00020hH\u0002J\u0012\u0010\u00f6\u0001\u001a\u00020h2\u0007\u0010\u00f7\u0001\u001a\u00020\u0012H\u0002J\t\u0010\u00f8\u0001\u001a\u00020\u0012H\u0002J\u0013\u0010\u00f9\u0001\u001a\u00020h2\u0008\u0010\u00fa\u0001\u001a\u00030\u00fb\u0001H\u0016J.\u0010\u00fc\u0001\u001a\u00020h2\u0008\u0010\u00fa\u0001\u001a\u00030\u00fb\u00012\u0007\u0010\u00fd\u0001\u001a\u00020\u00122\u0007\u0010\u00fe\u0001\u001a\u00020\u00122\u0007\u0010\u00ff\u0001\u001a\u00020\u0012H\u0016J\u0013\u0010\u0080\u0002\u001a\u00020h2\u0008\u0010\u00fa\u0001\u001a\u00030\u00fb\u0001H\u0016J\t\u0010\u0081\u0002\u001a\u00020hH\u0002J\u000f\u0010\u0082\u0002\u001a\u00020h2\u0006\u0010x\u001a\u00020\'J\t\u0010\u0083\u0002\u001a\u00020hH\u0002J\u001e\u0010\u0084\u0002\u001a\u00070\u0085\u0002R\u00020\u000f2\u000e\u0010\u0086\u0002\u001a\t\u0018\u00010\u0087\u0002R\u00020\u000fH\u0002J\t\u0010\u0088\u0002\u001a\u00020hH\u0002J\t\u0010\u0089\u0002\u001a\u00020hH\u0002J-\u0010\u008a\u0002\u001a\u00020h2\u0012\u0010\u008b\u0002\u001a\r\u0012\u0006\u0008\u0001\u0012\u00020#\u0018\u00010\u00ed\u00012\u0008\u0010\u000e\u001a\u0004\u0018\u00010\u000fH\u0016\u00a2\u0006\u0003\u0010\u008c\u0002J(\u0010\u008d\u0002\u001a\u000f\u0012\u0004\u0012\u00020\u0012\u0012\u0004\u0012\u00020\u00120\u008e\u00022\u0007\u0010\u008f\u0002\u001a\u00020\u00122\u0007\u0010\u0090\u0002\u001a\u00020\u0012H\u0002J\u001b\u0010\u0091\u0002\u001a\u00020\'2\u0007\u0010\u0092\u0002\u001a\u00020\u00072\u0007\u0010\u0093\u0002\u001a\u00020\u0007H\u0002J\u0012\u0010\u0094\u0002\u001a\u00020h2\u0007\u0010\u00dc\u0001\u001a\u00020\'H\u0002R\u000e\u0010\u0006\u001a\u00020\u0007X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0008\u001a\u00020\tX\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u0010\n\u001a\u00020\u000bX\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000c\u001a\u00020\rX\u0082.\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u000e\u001a\u0004\u0018\u00010\u000fX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0010\u001a\u00020\u0007X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0011\u001a\u00020\u0012X\u0082D\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0013\u001a\u0004\u0018\u00010\u0014X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0015\u001a\u00020\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0016\u001a\u00020\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0017\u001a\u00020\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0018\u001a\u00020\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0019\u001a\u00020\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u001a\u001a\u00020\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u001b\u001a\u00020\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u001c\u001a\u00020\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u001d\u001a\u00020\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u001e\u001a\u00020\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u001f\u001a\u00020\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010 \u001a\u00020\u0007X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010!\u001a\u00020\u0007X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\"\u001a\u0004\u0018\u00010#X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010$\u001a\u00020\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010%\u001a\u00020\u0012X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010&\u001a\u00020\'X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010(\u001a\u00020)X\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u0010*\u001a\u00020+X\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u0010,\u001a\u00020-X\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u0010.\u001a\u00020-X\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u0010/\u001a\u000200X\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u00101\u001a\u00020\rX\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u00102\u001a\u00020\rX\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u00103\u001a\u00020\rX\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u00104\u001a\u00020\rX\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u00105\u001a\u00020\rX\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u00106\u001a\u00020\rX\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u00107\u001a\u00020\u000bX\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u00108\u001a\u000209X\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u0010:\u001a\u000209X\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u0010;\u001a\u00020+X\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u0010<\u001a\u00020+X\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u0010=\u001a\u00020>X\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u0010?\u001a\u00020>X\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u0010@\u001a\u00020+X\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u0010A\u001a\u00020+X\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u0010B\u001a\u00020CX\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u0010D\u001a\u00020\u0007X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010E\u001a\u00020\'X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010F\u001a\u00020\'X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010G\u001a\u00020HX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010I\u001a\u00020\u0007X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010J\u001a\u00020\'X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010K\u001a\u00020\'X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010L\u001a\u00020\u000bX\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u0010M\u001a\u00020\u000bX\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u0010N\u001a\u00020\u000bX\u0082.\u00a2\u0006\u0002\n\u0000R\u0010\u0010O\u001a\u0004\u0018\u00010PX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010Q\u001a\u0004\u0018\u00010RX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001a\u0010S\u001a\u000e\u0012\u0004\u0012\u00020\'\u0012\u0004\u0012\u00020\u00120TX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010U\u001a\u0004\u0018\u00010VX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010W\u001a\u00020\u0007X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010X\u001a\u00020\u0007X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010Y\u001a\u00020\u0007X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010Z\u001a\u00020[X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\\R\u0010\u0010]\u001a\u0004\u0018\u00010^X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010_\u001a\u0004\u0018\u00010`X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010a\u001a\u00020\u0007X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010b\u001a\u00020\u0014X\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u0010c\u001a\u00020dX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010e\u001a\u00020\u0007X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010f\u001a\u00020\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001f\u0010\u0087\u0001\u001a\u00020~X\u0086\u000e\u00a2\u0006\u0012\n\u0000\u001a\u0006\u0008\u0088\u0001\u0010\u0089\u0001\"\u0006\u0008\u008a\u0001\u0010\u008b\u0001R\u001f\u0010\u008c\u0001\u001a\u00020dX\u0086\u000e\u00a2\u0006\u0012\n\u0000\u001a\u0006\u0008\u008d\u0001\u0010\u008e\u0001\"\u0006\u0008\u008f\u0001\u0010\u0090\u0001R\u001f\u0010\u0091\u0001\u001a\u00020~X\u0086\u000e\u00a2\u0006\u0012\n\u0000\u001a\u0006\u0008\u0092\u0001\u0010\u0089\u0001\"\u0006\u0008\u0093\u0001\u0010\u008b\u0001R\u0013\u0010\u0096\u0001\u001a\u00030\u0097\u0001X\u0082\u0004\u00a2\u0006\u0005\n\u0003\u0010\u0098\u0001\u00a8\u0006\u0096\u0002"
    }
    d2 = {
        "Lcom/roder300/kozen/MainActivity;",
        "Landroidx/appcompat/app/AppCompatActivity;",
        "Landroid/view/SurfaceHolder$Callback;",
        "Landroid/hardware/Camera$FaceDetectionListener;",
        "<init>",
        "()V",
        "keepScreenOn",
        "",
        "surfaceView",
        "Landroid/view/SurfaceView;",
        "button",
        "Landroid/widget/ImageView;",
        "cameraContainer",
        "Landroid/widget/FrameLayout;",
        "camera",
        "Landroid/hardware/Camera;",
        "isDetecting",
        "cameraPermissionCode",
        "",
        "debugRunnable",
        "Ljava/lang/Runnable;",
        "cameraDisplayOrientation",
        "faceDetectionCount",
        "currentFaceId",
        "minConfidence",
        "requiredDetections",
        "centerRangeStartX",
        "centerRangeEndX",
        "centerRangeStartY",
        "centerRangeEndY",
        "previewWidth",
        "previewHeight",
        "validFaceDetected",
        "isPortraitMode",
        "currentFace",
        "Landroid/hardware/Camera$Face;",
        "clickCount",
        "requiredClicks",
        "correctPassword",
        "",
        "sharedPreferences",
        "Landroid/content/SharedPreferences;",
        "textTerminalId",
        "Landroid/widget/TextView;",
        "slideUpFadeIn",
        "Landroid/view/animation/Animation;",
        "fadeOut",
        "mainContainer",
        "Landroidx/constraintlayout/widget/ConstraintLayout;",
        "payContainer",
        "payPendingContainer",
        "paySuccContainer",
        "faceRecognitionPrepare",
        "faceRecognitionInView",
        "faceRecognition",
        "imageDescFace",
        "textContainer",
        "Landroid/widget/LinearLayout;",
        "buttonsContainer",
        "textAmount",
        "textAmountSucc",
        "lottieAnimationLoader",
        "Lcom/airbnb/lottie/LottieAnimationView;",
        "lottieAnimationLoaderSucc",
        "textStatusPending",
        "textContent",
        "videoBackground",
        "Landroid/widget/VideoView;",
        "isVideoPrepared",
        "REGISTRATION_URL",
        "PAYLOAD_URL",
        "handler",
        "Landroid/os/Handler;",
        "isCheckingPayload",
        "lastPayloadHash",
        "currentScreen",
        "circle1",
        "circle2",
        "circle3",
        "circleAnimator",
        "Landroid/animation/AnimatorSet;",
        "soundPool",
        "Landroid/media/SoundPool;",
        "soundMap",
        "",
        "nfcAdapter",
        "Landroid/nfc/NfcAdapter;",
        "isNfcEnabled",
        "isNfcListening",
        "isNfcProcessing",
        "payloadCheckRunnable",
        "com/roder300/kozen/MainActivity$payloadCheckRunnable$1",
        "Lcom/roder300/kozen/MainActivity$payloadCheckRunnable$1;",
        "proximitySensor",
        "Landroid/hardware/Sensor;",
        "sensorManager",
        "Landroid/hardware/SensorManager;",
        "isProximitySensorActive",
        "proximityCheckRunnable",
        "proximityStartTime",
        "",
        "isNearDetected",
        "detectionCount",
        "onCreate",
        "",
        "savedInstanceState",
        "Landroid/os/Bundle;",
        "rotateToUpsideDown",
        "doNotBlockScreen",
        "enable",
        "adjustScreenTimeout",
        "keepOn",
        "initViewsCam",
        "showImgDesc",
        "imageKey",
        "imageSet",
        "onResume",
        "onPause",
        "onDestroy",
        "generateQRCodeWithRoundedCorners",
        "text",
        "imageView",
        "size",
        "color",
        "backgroundColor",
        "cornerRadius",
        "",
        "getRoundedCornerBitmap",
        "Landroid/graphics/Bitmap;",
        "bitmap",
        "startSensorCardOld",
        "startSensorCard",
        "checkProximitySensor",
        "checkSensorType",
        "checkSensorReportingMode",
        "lastKnownValue",
        "getLastKnownValue",
        "()F",
        "setLastKnownValue",
        "(F)V",
        "lastUpdateTime",
        "getLastUpdateTime",
        "()J",
        "setLastUpdateTime",
        "(J)V",
        "maxRange",
        "getMaxRange",
        "setMaxRange",
        "startProximityPolling",
        "stopSensorCard",
        "proximitySensorListener",
        "com/roder300/kozen/MainActivity$proximitySensorListener$1",
        "Lcom/roder300/kozen/MainActivity$proximitySensorListener$1;",
        "checkProximityState",
        "fromSensor",
        "onProximityDetected",
        "setupNfc",
        "startNfcListening",
        "stopNfcListening",
        "onNewIntent",
        "intent",
        "Landroid/content/Intent;",
        "handleNfcIntent",
        "readNfcTag",
        "tag",
        "Landroid/nfc/Tag;",
        "startPayloadChecking",
        "stopPayloadChecking",
        "checkPayload",
        "handlePayloadState",
        "state",
        "jsonResponse",
        "Lorg/json/JSONObject;",
        "currentPayloadHash",
        "showScreen",
        "screen",
        "anim",
        "(Ljava/lang/String;Ljava/lang/Boolean;)V",
        "setupSoundPool",
        "loadAllSounds",
        "loadSound",
        "soundName",
        "resourceId",
        "playSound",
        "volume",
        "hideAllContainersExcept",
        "exceptContainer",
        "Landroid/view/View;",
        "setupPaymentButtons",
        "showTargetContainer",
        "container",
        "(Landroid/view/View;Ljava/lang/Boolean;)V",
        "formatAmount",
        "amount",
        "waitForAnimationCompletion",
        "animationView",
        "callback",
        "Lkotlin/Function0;",
        "startLottieAnimation",
        "lottieView",
        "loop",
        "loopCount",
        "speed",
        "showPayScreen",
        "showBioScreen",
        "showTextScreen",
        "content",
        "showPayScreenPending",
        "showButtonsScreen",
        "buttonsData",
        "isDeviceRegistered",
        "showTerminalId",
        "registerDevice",
        "collectDeviceData",
        "Lcom/roder300/kozen/DeviceData;",
        "getDeviceUniqueId",
        "getAppVersionName",
        "getAppVersionCode",
        "isNetworkAvailable",
        "showRegistrationErrorDialog",
        "message",
        "startSmoothEaseOutAnimation",
        "textImageView",
        "dpToPx",
        "setFullScreenMode",
        "setCutoutModeSafe",
        "onWindowFocusChanged",
        "hasFocus",
        "setupVideoPlayer",
        "startVideoPlayback",
        "stopVideoPlayback",
        "showPasswordDialog",
        "onBackPressed",
        "checkAndRequestCameraPermission",
        "onRequestPermissionsResult",
        "requestCode",
        "permissions",
        "",
        "grantResults",
        "",
        "(I[Ljava/lang/String;[I)V",
        "startFaceDetection",
        "resetDetectionState",
        "stopFaceDetection",
        "checkCameraHardware",
        "setupCamera",
        "setCameraDisplayOrientation",
        "cameraId",
        "findFrontCamera",
        "surfaceCreated",
        "holder",
        "Landroid/view/SurfaceHolder;",
        "surfaceChanged",
        "format",
        "width",
        "height",
        "surfaceDestroyed",
        "startPreview",
        "setTextDesc",
        "calculateCenterRanges",
        "findBestPreviewSize",
        "Landroid/hardware/Camera$Size;",
        "params",
        "Landroid/hardware/Camera$Parameters;",
        "stopPreview",
        "releaseCamera",
        "onFaceDetection",
        "faces",
        "([Landroid/hardware/Camera$Face;Landroid/hardware/Camera;)V",
        "convertFaceCoordinates",
        "Lkotlin/Pair;",
        "faceX",
        "faceY",
        "getCorrectDirection",
        "isLeftOrUp",
        "isVertical",
        "addLog",
        "SoundManager",
        "app_debug"
    }
    k = 0x1
    mv = {
        0x2,
        0x0,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final $stable:I


# instance fields
.field private final PAYLOAD_URL:Ljava/lang/String;

.field private final REGISTRATION_URL:Ljava/lang/String;

.field private button:Landroid/widget/ImageView;

.field private buttonsContainer:Landroid/widget/LinearLayout;

.field private camera:Landroid/hardware/Camera;

.field public cameraContainer:Landroid/widget/FrameLayout;

.field private cameraDisplayOrientation:I

.field private final cameraPermissionCode:I

.field private centerRangeEndX:I

.field private centerRangeEndY:I

.field private centerRangeStartX:I

.field private centerRangeStartY:I

.field private circle1:Landroid/widget/ImageView;

.field private circle2:Landroid/widget/ImageView;

.field private circle3:Landroid/widget/ImageView;

.field private circleAnimator:Landroid/animation/AnimatorSet;

.field private clickCount:I

.field private final correctPassword:Ljava/lang/String;

.field private currentFace:Landroid/hardware/Camera$Face;

.field private currentFaceId:I

.field private currentScreen:Ljava/lang/String;

.field private debugRunnable:Ljava/lang/Runnable;

.field private detectionCount:I

.field private faceDetectionCount:I

.field private faceRecognition:Landroid/widget/FrameLayout;

.field private faceRecognitionInView:Landroid/widget/FrameLayout;

.field private faceRecognitionPrepare:Landroid/widget/FrameLayout;

.field private fadeOut:Landroid/view/animation/Animation;

.field private final handler:Landroid/os/Handler;

.field private imageDescFace:Landroid/widget/ImageView;

.field private isCardPolling:Z

.field private isCheckingPayload:Z

.field private isDetecting:Z

.field private isFacePolling:Z

.field public isFaceUploading:Z

.field private isNearDetected:Z

.field private isNfcEnabled:Z

.field private isNfcListening:Z

.field private isNfcProcessing:Z

.field private isPaymentLocked:Z

.field private isPortraitMode:Z

.field private isProximitySensorActive:Z

.field private isVideoPrepared:Z

.field private keepScreenOn:Z

.field private lastKnownValue:F

.field private lastPayloadHash:Ljava/lang/String;

.field private lastUpdateTime:J

.field private lottieAnimationLoader:Lcom/airbnb/lottie/LottieAnimationView;

.field private lottieAnimationLoaderSucc:Lcom/airbnb/lottie/LottieAnimationView;

.field private mainContainer:Landroidx/constraintlayout/widget/ConstraintLayout;

.field private maxRange:F

.field private minConfidence:I

.field private nfcAdapter:Landroid/nfc/NfcAdapter;

.field private payContainer:Landroid/widget/FrameLayout;

.field private payPendingContainer:Landroid/widget/FrameLayout;

.field private paySuccContainer:Landroid/widget/FrameLayout;

.field private final payloadCheckRunnable:Lcom/roder300/kozen/MainActivity$payloadCheckRunnable$1;

.field private previewHeight:I

.field private previewWidth:I

.field private proximityCheckRunnable:Ljava/lang/Runnable;

.field private proximitySensor:Landroid/hardware/Sensor;

.field private final proximitySensorListener:Lcom/roder300/kozen/MainActivity$proximitySensorListener$1;

.field private proximityStartTime:J

.field private final requiredClicks:I

.field private requiredDetections:I

.field private sensorManager:Landroid/hardware/SensorManager;

.field private sharedPreferences:Landroid/content/SharedPreferences;

.field private slideUpFadeIn:Landroid/view/animation/Animation;

.field private final soundMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private soundPool:Landroid/media/SoundPool;

.field private surfaceView:Landroid/view/SurfaceView;

.field private textAmount:Landroid/widget/TextView;

.field private textAmountSucc:Landroid/widget/TextView;

.field private textContainer:Landroid/widget/LinearLayout;

.field private textContent:Landroid/widget/TextView;

.field private textStatusPending:Landroid/widget/TextView;

.field private textTerminalId:Landroid/widget/TextView;

.field private touchPointerCount:I

.field private touchStartY:F

.field private validFaceDetected:Z

.field private videoBackground:Landroid/widget/VideoView;


# direct methods
.method public static synthetic $r8$lambda$-AGSuRwKowXOGGQKAhqruv3ItnU(Lcom/roder300/kozen/MainActivity;Landroid/widget/ImageView;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/roder300/kozen/MainActivity;->handlePayloadState$lambda$14(Lcom/roder300/kozen/MainActivity;Landroid/widget/ImageView;)V

    return-void
.end method

.method public static synthetic $r8$lambda$-byvrYG_GVitgLNwbgPSOHLDTwU(Lcom/roder300/kozen/MainActivity;Landroid/media/MediaPlayer;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/roder300/kozen/MainActivity;->setupVideoPlayer$lambda$39(Lcom/roder300/kozen/MainActivity;Landroid/media/MediaPlayer;)V

    return-void
.end method

.method public static synthetic $r8$lambda$01Svz6MFUTEDFpWeaUCyhpBYny0(Lcom/roder300/kozen/MainActivity;Ljava/lang/Exception;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/roder300/kozen/MainActivity;->startNfcListening$lambda$10(Lcom/roder300/kozen/MainActivity;Ljava/lang/Exception;)V

    return-void
.end method

.method public static synthetic $r8$lambda$0rzaPOb08cSQfbd3LkS71jzByNs(Lcom/roder300/kozen/MainActivity;Landroid/content/DialogInterface;I)V
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/roder300/kozen/MainActivity;->showRegistrationErrorDialog$lambda$34(Lcom/roder300/kozen/MainActivity;Landroid/content/DialogInterface;I)V

    return-void
.end method

.method public static synthetic $r8$lambda$1c8okRLNwYu3IOvEMNnmoiIyI5k(Lcom/roder300/kozen/MainActivity;Landroid/view/View;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/roder300/kozen/MainActivity;->onCreate$lambda$2(Lcom/roder300/kozen/MainActivity;Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$3-wJ42NkX7Os86KFb3K-zWlfcQE(Lcom/roder300/kozen/MainActivity;)V
    .locals 0

    invoke-static {p0}, Lcom/roder300/kozen/MainActivity;->showPayScreenPending$lambda$30(Lcom/roder300/kozen/MainActivity;)V

    return-void
.end method

.method public static synthetic $r8$lambda$4ahYdHNZSSJ0-le3oXZ6TiyfXUk(Lcom/roder300/kozen/MainActivity;)V
    .locals 0

    invoke-static {p0}, Lcom/roder300/kozen/MainActivity;->startProximityPolling$lambda$6(Lcom/roder300/kozen/MainActivity;)V

    return-void
.end method

.method public static synthetic $r8$lambda$DSvCGStgfYQLTVFn96fPfDoOFtc(Lcom/roder300/kozen/MainActivity;Landroid/view/View;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/roder300/kozen/MainActivity;->setupPaymentButtons$lambda$19(Lcom/roder300/kozen/MainActivity;Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$FfnZIVgfhRz-D2qSWB5FZKNKpjI(Landroid/widget/ImageView;Lcom/roder300/kozen/MainActivity;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/roder300/kozen/MainActivity;->startSmoothEaseOutAnimation$lambda$36(Landroid/widget/ImageView;Lcom/roder300/kozen/MainActivity;)V

    return-void
.end method

.method public static synthetic $r8$lambda$Ge6gTPNl-uES6_FUrDVTvZV7N-s(Lcom/roder300/kozen/MainActivity;)V
    .locals 0

    invoke-static {p0}, Lcom/roder300/kozen/MainActivity;->showBioScreen$lambda$24(Lcom/roder300/kozen/MainActivity;)V

    return-void
.end method

.method public static synthetic $r8$lambda$ILa31DqoDe8ZxdkEfj5YGTMzSYM(Lcom/roder300/kozen/MainActivity;)Lkotlin/Unit;
    .locals 0

    invoke-static {p0}, Lcom/roder300/kozen/MainActivity;->showPayScreenPending$lambda$30$lambda$29$lambda$28$lambda$27$lambda$26(Lcom/roder300/kozen/MainActivity;)Lkotlin/Unit;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$JHPdHxDUH4olTwcskqfU2To82p4(Landroid/media/SoundPool;II)V
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/roder300/kozen/MainActivity;->setupSoundPool$lambda$16(Landroid/media/SoundPool;II)V

    return-void
.end method

.method public static synthetic $r8$lambda$MoTtaSUcfDr7JthDqJsduh5scoU(B)Ljava/lang/CharSequence;
    .locals 0

    invoke-static {p0}, Lcom/roder300/kozen/MainActivity;->handleNfcIntent$lambda$12(B)Ljava/lang/CharSequence;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$SdFmuk-XeIn1l0mVI-BoyhzQscM(Lcom/roder300/kozen/MainActivity;)V
    .locals 0

    invoke-static {p0}, Lcom/roder300/kozen/MainActivity;->onProximityDetected$lambda$7(Lcom/roder300/kozen/MainActivity;)V

    return-void
.end method

.method public static synthetic $r8$lambda$U70Ovn3e6uk6HiRVyZ8pR9e9FJY(Lcom/roder300/kozen/MainActivity;)V
    .locals 0

    invoke-static {p0}, Lcom/roder300/kozen/MainActivity;->showPayScreenPending$lambda$30$lambda$29$lambda$28$lambda$27$lambda$26$lambda$25(Lcom/roder300/kozen/MainActivity;)V

    return-void
.end method

.method public static synthetic $r8$lambda$WwDPVVbhlxMSRDs70ASPu_IYw30(Lcom/roder300/kozen/MainActivity;)V
    .locals 0

    invoke-static {p0}, Lcom/roder300/kozen/MainActivity;->showPayScreenPending$lambda$30$lambda$29$lambda$28(Lcom/roder300/kozen/MainActivity;)V

    return-void
.end method

.method public static synthetic $r8$lambda$ZZQKWlNkLIHMOgd-3EESmy835Ec(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 0

    invoke-static {p0, p1}, Lcom/roder300/kozen/MainActivity;->setupPaymentButtons$lambda$22$lambda$21(Landroid/view/View;Landroid/view/MotionEvent;)Z

    move-result p0

    return p0
.end method

.method public static synthetic $r8$lambda$ZrO58nD9mRDuQjpT4N6aclbAC-4(Landroid/content/DialogInterface;I)V
    .locals 0

    invoke-static {p0, p1}, Lcom/roder300/kozen/MainActivity;->showPasswordDialog$lambda$41(Landroid/content/DialogInterface;I)V

    return-void
.end method

.method public static synthetic $r8$lambda$amHyTHR4V-JdXchGcd2IZkEX72o(Lcom/roder300/kozen/MainActivity;)V
    .locals 0

    invoke-static {p0}, Lcom/roder300/kozen/MainActivity;->showPayScreenPending$lambda$30$lambda$29(Lcom/roder300/kozen/MainActivity;)V

    return-void
.end method

.method public static synthetic $r8$lambda$c71GBBaZZtENOqr6-Lg-y3iu6b4(Lcom/roder300/kozen/MainActivity;Landroid/widget/ImageView;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/roder300/kozen/MainActivity;->onCreate$lambda$1(Lcom/roder300/kozen/MainActivity;Landroid/widget/ImageView;)V

    return-void
.end method

.method public static synthetic $r8$lambda$cU8LE0zSdoit0rLue6cAA0-ObIE(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;Ljava/lang/String;Landroid/view/View;)V
    .locals 0

    invoke-static {p0, p1, p2, p3}, Lcom/roder300/kozen/MainActivity;->showButtonsScreen$lambda$33$lambda$31(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;Ljava/lang/String;Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$dtIehAG6Mc-MKnC0pAChZFx6kCA(Landroid/widget/EditText;Lcom/roder300/kozen/MainActivity;Landroid/content/DialogInterface;I)V
    .locals 0

    invoke-static {p0, p1, p2, p3}, Lcom/roder300/kozen/MainActivity;->showPasswordDialog$lambda$40(Landroid/widget/EditText;Lcom/roder300/kozen/MainActivity;Landroid/content/DialogInterface;I)V

    return-void
.end method

.method public static synthetic $r8$lambda$dtRkhnRTWqBlN2ayNFDA5U6f5R4(Lcom/roder300/kozen/MainActivity;Landroid/view/View;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/roder300/kozen/MainActivity;->setupPaymentButtons$lambda$20(Lcom/roder300/kozen/MainActivity;Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$eM8VsTLCfCSvUJYjXY5a4kyqKRM(Lcom/roder300/kozen/MainActivity;Landroid/view/View;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/roder300/kozen/MainActivity;->setupPaymentButtons$lambda$18(Lcom/roder300/kozen/MainActivity;Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$f2AnXit5WxBNndceqq6ll6aUIGA(Lcom/roder300/kozen/MainActivity;Landroid/content/DialogInterface;I)V
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/roder300/kozen/MainActivity;->showRegistrationErrorDialog$lambda$35(Lcom/roder300/kozen/MainActivity;Landroid/content/DialogInterface;I)V

    return-void
.end method

.method public static synthetic $r8$lambda$jpHz5pklnJae3ljV5Y66hIqZG2U(Lcom/roder300/kozen/MainActivity;)V
    .locals 0

    invoke-static {p0}, Lcom/roder300/kozen/MainActivity;->showPayScreenPending$lambda$30$lambda$29$lambda$28$lambda$27(Lcom/roder300/kozen/MainActivity;)V

    return-void
.end method

.method public static synthetic $r8$lambda$m3StaeBpGkD7aB89wxXD1z9Z0T4(Lcom/roder300/kozen/MainActivity;)V
    .locals 0

    invoke-static {p0}, Lcom/roder300/kozen/MainActivity;->onResume$lambda$3(Lcom/roder300/kozen/MainActivity;)V

    return-void
.end method

.method public static synthetic $r8$lambda$mfHUYIVd4XJefzcFwgcwTMBthJw(Landroid/media/MediaPlayer;II)Z
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/roder300/kozen/MainActivity;->setupVideoPlayer$lambda$38(Landroid/media/MediaPlayer;II)Z

    move-result p0

    return p0
.end method

.method public static synthetic $r8$lambda$qIUZrWmfpRQrASBlK5zgmq_NKDk(Landroid/view/ViewGroup;)V
    .locals 0

    invoke-static {p0}, Lcom/roder300/kozen/MainActivity;->showScreen$lambda$15(Landroid/view/ViewGroup;)V

    return-void
.end method

.method public static synthetic $r8$lambda$vIE10IfgaAEKYsuaJUEXookw88I(Lcom/roder300/kozen/MainActivity;[Landroid/hardware/Camera$Face;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/roder300/kozen/MainActivity;->onFaceDetection$lambda$44(Lcom/roder300/kozen/MainActivity;[Landroid/hardware/Camera$Face;)V

    return-void
.end method

.method public static synthetic $r8$lambda$xK2iJgiEHZQladd_4KKIwtAMC0s(Lcom/roder300/kozen/MainActivity;Landroid/media/MediaPlayer;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/roder300/kozen/MainActivity;->setupVideoPlayer$lambda$37(Lcom/roder300/kozen/MainActivity;Landroid/media/MediaPlayer;)V

    return-void
.end method

.method public static synthetic $r8$lambda$zC18kHfOSXIewR-WxYppjshnQtU(Lcom/roder300/kozen/MainActivity;)V
    .locals 0

    invoke-static {p0}, Lcom/roder300/kozen/MainActivity;->handleNfcIntent$lambda$13(Lcom/roder300/kozen/MainActivity;)V

    return-void
.end method

.method public static synthetic $r8$lambda$zaMve6IsVe0rWbrn9JdRij0EU5E(Lcom/roder300/kozen/MainActivity;)V
    .locals 0

    invoke-static {p0}, Lcom/roder300/kozen/MainActivity;->onCreate$lambda$0(Lcom/roder300/kozen/MainActivity;)V

    return-void
.end method

.method static constructor <clinit>()V
    .locals 1

    const/16 v0, 0x8

    sput v0, Lcom/roder300/kozen/MainActivity;->$stable:I

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 83
    invoke-direct {p0}, Landroidx/appcompat/app/AppCompatActivity;-><init>()V

    .line 94
    const/16 v0, 0x65

    iput v0, p0, Lcom/roder300/kozen/MainActivity;->cameraPermissionCode:I

    .line 100
    const/4 v0, -0x1

    iput v0, p0, Lcom/roder300/kozen/MainActivity;->currentFaceId:I

    .line 101
    const/16 v0, 0x2d

    iput v0, p0, Lcom/roder300/kozen/MainActivity;->minConfidence:I

    .line 102
    const/16 v0, 0x19

    iput v0, p0, Lcom/roder300/kozen/MainActivity;->requiredDetections:I

    .line 110
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isPortraitMode:Z

    .line 117
    const/4 v0, 0x5

    iput v0, p0, Lcom/roder300/kozen/MainActivity;->requiredClicks:I

    .line 118
    const-string v0, "q"

    iput-object v0, p0, Lcom/roder300/kozen/MainActivity;->correctPassword:Ljava/lang/String;

    .line 147
    const-string v0, "https://sberpos-api.onrender.com/register"

    iput-object v0, p0, Lcom/roder300/kozen/MainActivity;->REGISTRATION_URL:Ljava/lang/String;

    .line 148
    const-string v0, "https://sberpos-api.onrender.com/admin/payload"

    iput-object v0, p0, Lcom/roder300/kozen/MainActivity;->PAYLOAD_URL:Ljava/lang/String;

    .line 152
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/roder300/kozen/MainActivity;->handler:Landroid/os/Handler;

    .line 154
    const-string v0, ""

    iput-object v0, p0, Lcom/roder300/kozen/MainActivity;->lastPayloadHash:Ljava/lang/String;

    .line 155
    const-string v0, "main"

    iput-object v0, p0, Lcom/roder300/kozen/MainActivity;->currentScreen:Ljava/lang/String;

    .line 164
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    check-cast v0, Ljava/util/Map;

    iput-object v0, p0, Lcom/roder300/kozen/MainActivity;->soundMap:Ljava/util/Map;

    .line 172
    new-instance v0, Lcom/roder300/kozen/MainActivity$payloadCheckRunnable$1;

    invoke-direct {v0, p0}, Lcom/roder300/kozen/MainActivity$payloadCheckRunnable$1;-><init>(Lcom/roder300/kozen/MainActivity;)V

    iput-object v0, p0, Lcom/roder300/kozen/MainActivity;->payloadCheckRunnable:Lcom/roder300/kozen/MainActivity$payloadCheckRunnable$1;

    .line 511
    const/high16 v0, 0x41200000    # 10.0f

    iput v0, p0, Lcom/roder300/kozen/MainActivity;->lastKnownValue:F

    .line 570
    new-instance v0, Lcom/roder300/kozen/MainActivity$proximitySensorListener$1;

    invoke-direct {v0, p0}, Lcom/roder300/kozen/MainActivity$proximitySensorListener$1;-><init>(Lcom/roder300/kozen/MainActivity;)V

    iput-object v0, p0, Lcom/roder300/kozen/MainActivity;->proximitySensorListener:Lcom/roder300/kozen/MainActivity$proximitySensorListener$1;

    .line 83
    return-void
.end method

.method public static final synthetic access$checkPayload(Lcom/roder300/kozen/MainActivity;)V
    .locals 0
    .param p0, "$this"    # Lcom/roder300/kozen/MainActivity;

    .line 83
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->checkPayload()V

    return-void
.end method

.method public static final synthetic access$getDetectionCount$p(Lcom/roder300/kozen/MainActivity;)I
    .locals 1
    .param p0, "$this"    # Lcom/roder300/kozen/MainActivity;

    .line 83
    iget v0, p0, Lcom/roder300/kozen/MainActivity;->detectionCount:I

    return v0
.end method

.method public static final synthetic access$getHandler$p(Lcom/roder300/kozen/MainActivity;)Landroid/os/Handler;
    .locals 1
    .param p0, "$this"    # Lcom/roder300/kozen/MainActivity;

    .line 83
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->handler:Landroid/os/Handler;

    return-object v0
.end method

.method public static final synthetic access$getLottieAnimationLoaderSucc$p(Lcom/roder300/kozen/MainActivity;)Lcom/airbnb/lottie/LottieAnimationView;
    .locals 1
    .param p0, "$this"    # Lcom/roder300/kozen/MainActivity;

    .line 83
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->lottieAnimationLoaderSucc:Lcom/airbnb/lottie/LottieAnimationView;

    return-object v0
.end method

.method public static final synthetic access$getMainContainer$p(Lcom/roder300/kozen/MainActivity;)Landroidx/constraintlayout/widget/ConstraintLayout;
    .locals 1
    .param p0, "$this"    # Lcom/roder300/kozen/MainActivity;

    .line 83
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->mainContainer:Landroidx/constraintlayout/widget/ConstraintLayout;

    return-object v0
.end method

.method public static final synthetic access$getProximitySensor$p(Lcom/roder300/kozen/MainActivity;)Landroid/hardware/Sensor;
    .locals 1
    .param p0, "$this"    # Lcom/roder300/kozen/MainActivity;

    .line 83
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->proximitySensor:Landroid/hardware/Sensor;

    return-object v0
.end method

.method public static final synthetic access$getSharedPreferences$p(Lcom/roder300/kozen/MainActivity;)Landroid/content/SharedPreferences;
    .locals 1
    .param p0, "$this"    # Lcom/roder300/kozen/MainActivity;

    .line 83
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->sharedPreferences:Landroid/content/SharedPreferences;

    return-object v0
.end method

.method public static final synthetic access$handlePayloadState(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;Lorg/json/JSONObject;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/roder300/kozen/MainActivity;
    .param p1, "state"    # Ljava/lang/String;
    .param p2, "jsonResponse"    # Lorg/json/JSONObject;
    .param p3, "currentPayloadHash"    # Ljava/lang/String;

    .line 83
    invoke-direct {p0, p1, p2, p3}, Lcom/roder300/kozen/MainActivity;->handlePayloadState(Ljava/lang/String;Lorg/json/JSONObject;Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$hideAllContainersExcept(Lcom/roder300/kozen/MainActivity;Landroid/view/View;)V
    .locals 0
    .param p0, "$this"    # Lcom/roder300/kozen/MainActivity;
    .param p1, "exceptContainer"    # Landroid/view/View;

    .line 83
    invoke-direct {p0, p1}, Lcom/roder300/kozen/MainActivity;->hideAllContainersExcept(Landroid/view/View;)V

    return-void
.end method

.method public static final synthetic access$isCheckingPayload$p(Lcom/roder300/kozen/MainActivity;)Z
    .locals 1
    .param p0, "$this"    # Lcom/roder300/kozen/MainActivity;

    .line 83
    iget-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isCheckingPayload:Z

    return v0
.end method

.method public static final synthetic access$isDeviceRegistered(Lcom/roder300/kozen/MainActivity;)Z
    .locals 1
    .param p0, "$this"    # Lcom/roder300/kozen/MainActivity;

    .line 83
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->isDeviceRegistered()Z

    move-result v0

    return v0
.end method

.method public static final synthetic access$isNearDetected$p(Lcom/roder300/kozen/MainActivity;)Z
    .locals 1
    .param p0, "$this"    # Lcom/roder300/kozen/MainActivity;

    .line 83
    iget-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isNearDetected:Z

    return v0
.end method

.method public static final synthetic access$setDetectionCount$p(Lcom/roder300/kozen/MainActivity;I)V
    .locals 0
    .param p0, "$this"    # Lcom/roder300/kozen/MainActivity;
    .param p1, "<set-?>"    # I

    .line 83
    iput p1, p0, Lcom/roder300/kozen/MainActivity;->detectionCount:I

    return-void
.end method

.method public static final synthetic access$setNearDetected$p(Lcom/roder300/kozen/MainActivity;Z)V
    .locals 0
    .param p0, "$this"    # Lcom/roder300/kozen/MainActivity;
    .param p1, "<set-?>"    # Z

    .line 83
    iput-boolean p1, p0, Lcom/roder300/kozen/MainActivity;->isNearDetected:Z

    return-void
.end method

.method public static final synthetic access$setProximityStartTime$p(Lcom/roder300/kozen/MainActivity;J)V
    .locals 0
    .param p0, "$this"    # Lcom/roder300/kozen/MainActivity;
    .param p1, "<set-?>"    # J

    .line 83
    iput-wide p1, p0, Lcom/roder300/kozen/MainActivity;->proximityStartTime:J

    return-void
.end method

.method public static final synthetic access$showRegistrationErrorDialog(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/roder300/kozen/MainActivity;
    .param p1, "message"    # Ljava/lang/String;

    .line 83
    invoke-direct {p0, p1}, Lcom/roder300/kozen/MainActivity;->showRegistrationErrorDialog(Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$showTerminalId(Lcom/roder300/kozen/MainActivity;)V
    .locals 0
    .param p0, "$this"    # Lcom/roder300/kozen/MainActivity;

    .line 83
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->showTerminalId()V

    return-void
.end method

.method public static final synthetic access$startPayloadChecking(Lcom/roder300/kozen/MainActivity;)V
    .locals 0
    .param p0, "$this"    # Lcom/roder300/kozen/MainActivity;

    .line 83
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->startPayloadChecking()V

    return-void
.end method

.method private final addLog(Ljava/lang/String;)V
    .locals 3
    .param p1, "message"    # Ljava/lang/String;

    .line 2256
    new-instance v0, Ljava/text/SimpleDateFormat;

    const-string v1, "HH:mm:ss"

    invoke-direct {v0, v1}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    new-instance v1, Ljava/util/Date;

    invoke-direct {v1}, Ljava/util/Date;-><init>()V

    invoke-virtual {v0, v1}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    .line 2257
    .local v0, "timestamp":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "] "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\n"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 2259
    .local v1, "logMessage":Ljava/lang/String;
    const-string v2, "FaceDetection"

    invoke-static {v2, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 2260
    return-void
.end method

.method private adjustCameraViewSize()V
    .locals 10

    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v1, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    iget v2, v0, Landroid/util/DisplayMetrics;->heightPixels:I

    iget v3, p0, Lcom/roder300/kozen/MainActivity;->previewWidth:I

    iget v4, p0, Lcom/roder300/kozen/MainActivity;->previewHeight:I

    if-eqz v4, :cond_1

    const/16 v5, 0x55

    mul-int v5, v1, v5

    const/16 v6, 0x64

    div-int v5, v5, v6

    int-to-float v6, v3

    int-to-float v7, v4

    div-float v6, v6, v7

    int-to-float v7, v5

    div-float v7, v7, v6

    float-to-int v7, v7

    const/16 v8, 0x46

    mul-int v8, v2, v8

    const/16 v9, 0x64

    div-int v8, v8, v9

    if-le v7, v8, :cond_0

    move v7, v8

    int-to-float v5, v7

    mul-float v5, v5, v6

    float-to-int v5, v5

    :cond_0
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->cameraContainer:Landroid/widget/FrameLayout;

    if-eqz v0, :cond_1

    const/16 v6, 0x11

    new-instance v8, Landroid/widget/FrameLayout$LayoutParams;

    invoke-direct {v8, v5, v7, v6}, Landroid/widget/FrameLayout$LayoutParams;-><init>(III)V

    invoke-virtual {v0, v8}, Landroid/widget/FrameLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->surfaceView:Landroid/view/SurfaceView;

    if-eqz v0, :cond_1

    new-instance v8, Landroid/widget/FrameLayout$LayoutParams;

    invoke-direct {v8, v5, v7, v6}, Landroid/widget/FrameLayout$LayoutParams;-><init>(III)V

    invoke-virtual {v0, v8}, Landroid/view/SurfaceView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    :cond_1
    return-void
.end method

.method private final adjustScreenTimeout(Z)V
    .locals 2
    .param p1, "keepOn"    # Z

    .line 314
    if-eqz p1, :cond_0

    .line 316
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    .line 317
    .local v0, "params":Landroid/view/WindowManager$LayoutParams;
    const/high16 v1, -0x40800000    # -1.0f

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->screenBrightness:F

    .line 318
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V

    .line 320
    .end local v0    # "params":Landroid/view/WindowManager$LayoutParams;
    :cond_0
    return-void
.end method

.method private final calculateCenterRanges()V
    .locals 8

    .line 2017
    iget v0, p0, Lcom/roder300/kozen/MainActivity;->previewWidth:I

    int-to-double v0, v0

    const-wide v2, 0x3fd999999999999aL    # 0.4

    mul-double v0, v0, v2

    double-to-int v0, v0

    .line 2018
    .local v0, "centerWidth":I
    iget v1, p0, Lcom/roder300/kozen/MainActivity;->previewHeight:I

    int-to-double v4, v1

    mul-double v4, v4, v2

    double-to-int v1, v4

    .line 2020
    .local v1, "centerHeight":I
    iget v2, p0, Lcom/roder300/kozen/MainActivity;->previewWidth:I

    sub-int/2addr v2, v0

    div-int/lit8 v2, v2, 0x2

    iput v2, p0, Lcom/roder300/kozen/MainActivity;->centerRangeStartX:I

    .line 2021
    iget v2, p0, Lcom/roder300/kozen/MainActivity;->centerRangeStartX:I

    add-int/2addr v2, v0

    iput v2, p0, Lcom/roder300/kozen/MainActivity;->centerRangeEndX:I

    .line 2023
    iget v2, p0, Lcom/roder300/kozen/MainActivity;->previewHeight:I

    sub-int/2addr v2, v1

    div-int/lit8 v2, v2, 0x2

    iput v2, p0, Lcom/roder300/kozen/MainActivity;->centerRangeStartY:I

    .line 2024
    iget v2, p0, Lcom/roder300/kozen/MainActivity;->centerRangeStartY:I

    add-int/2addr v2, v1

    iput v2, p0, Lcom/roder300/kozen/MainActivity;->centerRangeEndY:I

    .line 2026
    iget v2, p0, Lcom/roder300/kozen/MainActivity;->centerRangeStartX:I

    iget v3, p0, Lcom/roder300/kozen/MainActivity;->centerRangeEndX:I

    iget v4, p0, Lcom/roder300/kozen/MainActivity;->centerRangeStartY:I

    iget v5, p0, Lcom/roder300/kozen/MainActivity;->centerRangeEndY:I

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "\u0420\u0430\u0441\u0441\u0447\u0438\u0442\u0430\u043d\u044b \u0446\u0435\u043d\u0442\u0440\u0430\u043b\u044c\u043d\u044b\u0435 \u043e\u0431\u043b\u0430\u0441\u0442\u0438: X="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v6, "-"

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", Y="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " px"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 2027
    return-void
.end method

.method private final checkAndRequestCameraPermission()V
    .locals 2

    .line 1776
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    if-lt v0, v1, :cond_1

    .line 1778
    const-string v0, "android.permission.CAMERA"

    invoke-virtual {p0, v0}, Lcom/roder300/kozen/MainActivity;->checkSelfPermission(Ljava/lang/String;)I

    move-result v1

    if-nez v1, :cond_0

    .line 1779
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->startFaceDetection()V

    goto :goto_0

    .line 1781
    :cond_0
    filled-new-array {v0}, [Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0x3e9

    invoke-virtual {p0, v0, v1}, Lcom/roder300/kozen/MainActivity;->requestPermissions([Ljava/lang/String;I)V

    .line 1782
    const-string v0, "\u0417\u0430\u043f\u0440\u043e\u0448\u0435\u043d\u043e \u0440\u0430\u0437\u0440\u0435\u0448\u0435\u043d\u0438\u0435 \u043d\u0430 \u0438\u0441\u043f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u043d\u0438\u0435 \u043a\u0430\u043c\u0435\u0440\u044b..."

    invoke-direct {p0, v0}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    goto :goto_0

    .line 1786
    :cond_1
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->startFaceDetection()V

    .line 1788
    :goto_0
    return-void
.end method

.method private final checkCameraHardware()Z
    .locals 5

    .line 1855
    nop

    .line 1856
    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    const-string v2, "android.hardware.camera"

    invoke-virtual {v1, v2}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v1

    .line 1857
    .local v1, "hasCamera":Z
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v2

    const-string v3, "android.hardware.camera.front"

    invoke-virtual {v2, v3}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v2

    .line 1858
    .local v2, "hasFrontCamera":Z
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "\u041a\u0430\u043c\u0435\u0440\u0430 \u0434\u043e\u0441\u0442\u0443\u043f\u043d\u0430: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", \u0424\u0440\u043e\u043d\u0442\u0430\u043b\u044c\u043d\u0430\u044f: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1859
    if-nez v1, :cond_0

    if-eqz v2, :cond_1

    :cond_0
    const/4 v0, 0x1

    goto :goto_0

    .line 1860
    .end local v1    # "hasCamera":Z
    .end local v2    # "hasFrontCamera":Z
    :catch_0
    move-exception v1

    .line 1861
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "\u041e\u0448\u0438\u0431\u043a\u0430 \u043f\u0440\u043e\u0432\u0435\u0440\u043a\u0438 \u043a\u0430\u043c\u0435\u0440\u044b: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 1862
    nop

    .line 1855
    .end local v1    # "e":Ljava/lang/Exception;
    :cond_1
    :goto_0
    return v0
.end method

.method private final checkPayload()V
    .locals 8

    .line 790
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->isNetworkAvailable()Z

    move-result v0

    if-nez v0, :cond_0

    .line 791
    return-void

    .line 795
    :cond_0
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->sharedPreferences:Landroid/content/SharedPreferences;

    const/4 v1, 0x0

    const-string v2, "sharedPreferences"

    if-nez v0, :cond_1

    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v0, v1

    :cond_1
    const-string v3, "terminal_id"

    const-string v4, ""

    invoke-interface {v0, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_2

    move-object v0, v4

    .line 796
    .local v0, "terminalId":Ljava/lang/String;
    :cond_2
    iget-object v3, p0, Lcom/roder300/kozen/MainActivity;->sharedPreferences:Landroid/content/SharedPreferences;

    if-nez v3, :cond_3

    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_0

    :cond_3
    move-object v1, v3

    :goto_0
    const-string v2, "uuid"

    invoke-interface {v1, v2, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_4

    goto :goto_1

    :cond_4
    move-object v4, v1

    .line 797
    .local v4, "uuid":Ljava/lang/String;
    :goto_1
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->getAppVersionCode()I

    move-result v1

    .line 799
    .local v1, "appVersion":I
    move-object v2, v0

    check-cast v2, Ljava/lang/CharSequence;

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v2

    const/4 v3, 0x1

    const/4 v5, 0x0

    if-nez v2, :cond_5

    const/4 v2, 0x1

    goto :goto_2

    :cond_5
    const/4 v2, 0x0

    :goto_2
    if-nez v2, :cond_8

    move-object v2, v4

    check-cast v2, Ljava/lang/CharSequence;

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-nez v2, :cond_6

    goto :goto_3

    :cond_6
    const/4 v3, 0x0

    :goto_3
    if-eqz v3, :cond_7

    goto/16 :goto_4

    .line 805
    :cond_7
    move-object v5, v4

    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getServerUrl()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "/api/payload"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "?terminal_id="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "&uuid="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "&appVersion="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 807
    .local v2, "urlWithParams":Ljava/lang/String;
    new-instance v3, Lokhttp3/OkHttpClient$Builder;

    invoke-direct {v3}, Lokhttp3/OkHttpClient$Builder;-><init>()V

    .line 808
    sget-object v5, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v6, 0x5

    invoke-virtual {v3, v6, v7, v5}, Lokhttp3/OkHttpClient$Builder;->connectTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 809
    sget-object v5, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v3, v6, v7, v5}, Lokhttp3/OkHttpClient$Builder;->readTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 810
    invoke-virtual {v3}, Lokhttp3/OkHttpClient$Builder;->build()Lokhttp3/OkHttpClient;

    move-result-object v3

    .line 807
    nop

    .line 812
    .local v3, "client":Lokhttp3/OkHttpClient;
    new-instance v5, Lokhttp3/Request$Builder;

    invoke-direct {v5}, Lokhttp3/Request$Builder;-><init>()V

    .line 813
    invoke-virtual {v5, v2}, Lokhttp3/Request$Builder;->url(Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v5

    .line 814
    invoke-virtual {v5}, Lokhttp3/Request$Builder;->get()Lokhttp3/Request$Builder;

    move-result-object v5

    .line 815
    const-string v6, "Content-Type"

    const-string v7, "application/json"

    invoke-virtual {v5, v6, v7}, Lokhttp3/Request$Builder;->addHeader(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v5

    .line 816
    invoke-virtual {v5}, Lokhttp3/Request$Builder;->build()Lokhttp3/Request;

    move-result-object v5

    .line 812
    nop

    .line 818
    .local v5, "request":Lokhttp3/Request;
    invoke-virtual {v3, v5}, Lokhttp3/OkHttpClient;->newCall(Lokhttp3/Request;)Lokhttp3/Call;

    move-result-object v6

    new-instance v7, Lcom/roder300/kozen/MainActivity$checkPayload$1;

    invoke-direct {v7, p0}, Lcom/roder300/kozen/MainActivity$checkPayload$1;-><init>(Lcom/roder300/kozen/MainActivity;)V

    check-cast v7, Lokhttp3/Callback;

    invoke-interface {v6, v7}, Lokhttp3/Call;->enqueue(Lokhttp3/Callback;)V

    .line 840
    return-void

    .line 800
    .end local v2    # "urlWithParams":Ljava/lang/String;
    .end local v3    # "client":Lokhttp3/OkHttpClient;
    .end local v5    # "request":Lokhttp3/Request;
    :cond_8
    :goto_4
    const-string v2, "PayloadCheck"

    const-string v3, "Terminal ID \u0438\u043b\u0438 UUID \u043d\u0435 \u043d\u0430\u0439\u0434\u0435\u043d\u044b"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 801
    return-void
.end method

.method private final checkProximitySensor()Z
    .locals 2

    .line 475
    const-string v0, "sensor"

    invoke-virtual {p0, v0}, Lcom/roder300/kozen/MainActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    const-string v1, "null cannot be cast to non-null type android.hardware.SensorManager"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Landroid/hardware/SensorManager;

    iput-object v0, p0, Lcom/roder300/kozen/MainActivity;->sensorManager:Landroid/hardware/SensorManager;

    .line 476
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->sensorManager:Landroid/hardware/SensorManager;

    if-eqz v0, :cond_0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/hardware/SensorManager;->getDefaultSensor(I)Landroid/hardware/Sensor;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    .line 477
    .local v0, "proximitySensor":Landroid/hardware/Sensor;
    :goto_0
    if-eqz v0, :cond_1

    const/4 v1, 0x1

    goto :goto_1

    :cond_1
    const/4 v1, 0x0

    :goto_1
    return v1
.end method

.method private final checkProximityState(Z)V
    .locals 6
    .param p1, "fromSensor"    # Z

    .line 606
    if-eqz p1, :cond_3

    .line 607
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->proximitySensor:Landroid/hardware/Sensor;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/hardware/Sensor;->getMaximumRange()F

    move-result v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iput v0, p0, Lcom/roder300/kozen/MainActivity;->maxRange:F

    .line 608
    iget v0, p0, Lcom/roder300/kozen/MainActivity;->maxRange:F

    const v1, 0x3f99999a    # 1.2f

    div-float/2addr v0, v1

    .line 609
    .local v0, "triggerDistance":F
    iget v1, p0, Lcom/roder300/kozen/MainActivity;->lastKnownValue:F

    const/4 v2, 0x0

    const/4 v3, 0x1

    cmpg-float v1, v1, v0

    if-gez v1, :cond_1

    const/4 v1, 0x1

    goto :goto_1

    :cond_1
    const/4 v1, 0x0

    .line 611
    .local v1, "isNear":Z
    :goto_1
    if-eqz v1, :cond_2

    .line 613
    iput-boolean v3, p0, Lcom/roder300/kozen/MainActivity;->isNearDetected:Z

    .line 614
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    iput-wide v4, p0, Lcom/roder300/kozen/MainActivity;->proximityStartTime:J

    .line 615
    iget v2, p0, Lcom/roder300/kozen/MainActivity;->detectionCount:I

    add-int/2addr v2, v3

    iput v2, p0, Lcom/roder300/kozen/MainActivity;->detectionCount:I

    .line 616
    iget v2, p0, Lcom/roder300/kozen/MainActivity;->detectionCount:I

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Detection count By handle: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " distance "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "Proximity"

    invoke-static {v3, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_2

    .line 617
    :cond_2
    if-nez v1, :cond_3

    iget-boolean v3, p0, Lcom/roder300/kozen/MainActivity;->isNearDetected:Z

    if-eqz v3, :cond_3

    .line 619
    iput-boolean v2, p0, Lcom/roder300/kozen/MainActivity;->isNearDetected:Z

    .line 622
    .end local v0    # "triggerDistance":F
    .end local v1    # "isNear":Z
    :cond_3
    :goto_2
    iget-wide v0, p0, Lcom/roder300/kozen/MainActivity;->proximityStartTime:J

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-lez v4, :cond_5

    .line 623
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lcom/roder300/kozen/MainActivity;->proximityStartTime:J

    sub-long/2addr v0, v2

    .line 626
    .local v0, "elapsedTime":J
    iget v2, p0, Lcom/roder300/kozen/MainActivity;->detectionCount:I

    const/4 v3, 0x6

    if-lt v2, v3, :cond_4

    .line 627
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->onProximityDetected()V

    .line 628
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->stopSensorCard()V

    goto :goto_3

    .line 631
    :cond_4
    const-wide/32 v2, 0xea60

    cmp-long v4, v0, v2

    if-ltz v4, :cond_5

    .line 632
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->stopSensorCard()V

    .line 635
    .end local v0    # "elapsedTime":J
    :cond_5
    :goto_3
    return-void
.end method

.method static synthetic checkProximityState$default(Lcom/roder300/kozen/MainActivity;ZILjava/lang/Object;)V
    .locals 0

    .line 605
    and-int/lit8 p2, p2, 0x1

    if-eqz p2, :cond_0

    const/4 p1, 0x0

    :cond_0
    invoke-direct {p0, p1}, Lcom/roder300/kozen/MainActivity;->checkProximityState(Z)V

    return-void
.end method

.method private final checkSensorReportingMode()V
    .locals 5

    .line 497
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->proximitySensor:Landroid/hardware/Sensor;

    if-eqz v0, :cond_0

    .local v0, "sensor\\1":Landroid/hardware/Sensor;
    const/4 v1, 0x0

    .line 498
    .local v1, "$i$a$-let-MainActivity$checkSensorReportingMode$1\\1\\497\\0":I
    nop

    .line 499
    invoke-virtual {v0}, Landroid/hardware/Sensor;->getReportingMode()I

    move-result v2

    packed-switch v2, :pswitch_data_0

    .line 504
    const-string v2, "UNKNOWN"

    goto :goto_0

    .line 503
    :pswitch_0
    const-string v2, "SPECIAL_TRIGGER"

    goto :goto_0

    .line 502
    :pswitch_1
    const-string v2, "ONE_SHOT"

    goto :goto_0

    .line 501
    :pswitch_2
    const-string v2, "ON_CHANGE"

    goto :goto_0

    .line 500
    :pswitch_3
    const-string v2, "CONTINUOUS"

    .line 499
    :goto_0
    nop

    .line 506
    .local v2, "reportingMode\\1":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Reporting mode: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const-string v4, "Proximity"

    invoke-static {v4, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 508
    .end local v2    # "reportingMode\\1":Ljava/lang/String;
    nop

    .line 497
    .end local v0    # "sensor\\1":Landroid/hardware/Sensor;
    .end local v1    # "$i$a$-let-MainActivity$checkSensorReportingMode$1\\1\\497\\0":I
    nop

    .line 509
    :cond_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private final checkSensorType()V
    .locals 6

    .line 480
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->proximitySensor:Landroid/hardware/Sensor;

    if-eqz v0, :cond_2

    .local v0, "sensor\\1":Landroid/hardware/Sensor;
    const/4 v1, 0x0

    .line 481
    .local v1, "$i$a$-let-MainActivity$checkSensorType$1\\1\\480\\0":I
    const-string v2, "=== Sensor Info ==="

    const-string v3, "Proximity"

    invoke-static {v3, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 482
    invoke-virtual {v0}, Landroid/hardware/Sensor;->getName()Ljava/lang/String;

    move-result-object v2

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Name: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v3, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 483
    invoke-virtual {v0}, Landroid/hardware/Sensor;->getVendor()Ljava/lang/String;

    move-result-object v2

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Vendor: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v3, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 484
    invoke-virtual {v0}, Landroid/hardware/Sensor;->getMaximumRange()F

    move-result v2

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Max range: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, " cm"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v3, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 485
    invoke-virtual {v0}, Landroid/hardware/Sensor;->getResolution()F

    move-result v2

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Resolution: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v3, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 486
    invoke-virtual {v0}, Landroid/hardware/Sensor;->getMinDelay()I

    move-result v2

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Min delay: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, " \u03bcs"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v3, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 489
    invoke-virtual {v0}, Landroid/hardware/Sensor;->getResolution()F

    move-result v2

    const/4 v4, 0x0

    cmpg-float v2, v2, v4

    if-nez v2, :cond_0

    const/4 v2, 0x1

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    if-eqz v2, :cond_1

    .line 490
    const-string v2, "\u26a0\ufe0f Binary sensor (only 0 and max values)"

    invoke-static {v3, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 492
    :cond_1
    const-string v2, "\u2705 Analog sensor (continuous values)"

    invoke-static {v3, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 493
    :goto_1
    nop

    .line 480
    .end local v0    # "sensor\\1":Landroid/hardware/Sensor;
    .end local v1    # "$i$a$-let-MainActivity$checkSensorType$1\\1\\480\\0":I
    nop

    .line 495
    :cond_2
    return-void
.end method

.method private final collectDeviceData()Lcom/roder300/kozen/DeviceData;
    .locals 19

    .line 1365
    new-instance v0, Lcom/roder300/kozen/DeviceData;

    .line 1366
    sget-object v1, Landroid/os/Build;->MODEL:Ljava/lang/String;

    const-string v2, "MODEL"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1367
    sget-object v2, Landroid/os/Build;->BRAND:Ljava/lang/String;

    const-string v3, "BRAND"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1368
    sget-object v3, Landroid/os/Build;->PRODUCT:Ljava/lang/String;

    const-string v4, "PRODUCT"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1369
    sget-object v4, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    const-string v5, "MANUFACTURER"

    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1370
    sget-object v5, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    const-string v6, "RELEASE"

    invoke-static {v5, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1371
    sget v6, Landroid/os/Build$VERSION;->SDK_INT:I

    .line 1372
    sget-object v7, Landroid/os/Build;->BOARD:Ljava/lang/String;

    const-string v8, "BOARD"

    invoke-static {v7, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1373
    sget-object v8, Landroid/os/Build;->HARDWARE:Ljava/lang/String;

    const-string v9, "HARDWARE"

    invoke-static {v8, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1374
    sget-object v9, Landroid/os/Build;->FINGERPRINT:Ljava/lang/String;

    const-string v10, "FINGERPRINT"

    invoke-static {v9, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1375
    invoke-direct/range {p0 .. p0}, Lcom/roder300/kozen/MainActivity;->getDeviceUniqueId()Ljava/lang/String;

    move-result-object v10

    .line 1376
    invoke-virtual/range {p0 .. p0}, Lcom/roder300/kozen/MainActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v11

    invoke-virtual {v11}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v11

    iget v11, v11, Landroid/util/DisplayMetrics;->widthPixels:I

    invoke-virtual/range {p0 .. p0}, Lcom/roder300/kozen/MainActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v12

    invoke-virtual {v12}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v12

    iget v12, v12, Landroid/util/DisplayMetrics;->heightPixels:I

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v13, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v13, "x"

    invoke-virtual {v11, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    .line 1377
    invoke-virtual/range {p0 .. p0}, Lcom/roder300/kozen/MainActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v12

    invoke-virtual {v12}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v12

    iget v12, v12, Landroid/util/DisplayMetrics;->density:F

    invoke-static {v12}, Ljava/lang/String;->valueOf(F)Ljava/lang/String;

    move-result-object v12

    .line 1378
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v13

    invoke-virtual {v13}, Ljava/util/Locale;->toString()Ljava/lang/String;

    move-result-object v13

    const-string v14, "toString(...)"

    invoke-static {v13, v14}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1379
    invoke-static {}, Ljava/util/TimeZone;->getDefault()Ljava/util/TimeZone;

    move-result-object v14

    invoke-virtual {v14}, Ljava/util/TimeZone;->getID()Ljava/lang/String;

    move-result-object v14

    const-string v15, "getID(...)"

    invoke-static {v14, v15}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1380
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v15

    .line 1381
    invoke-direct/range {p0 .. p0}, Lcom/roder300/kozen/MainActivity;->getAppVersionName()Ljava/lang/String;

    move-result-object v17

    .line 1382
    invoke-direct/range {p0 .. p0}, Lcom/roder300/kozen/MainActivity;->getAppVersionCode()I

    move-result v18

    .line 1365
    invoke-direct/range {v0 .. v18}, Lcom/roder300/kozen/DeviceData;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;JLjava/lang/String;I)V

    return-object v0
.end method

.method private final convertFaceCoordinates(II)Lkotlin/Pair;
    .locals 5
    .param p1, "faceX"    # I
    .param p2, "faceY"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(II)",
            "Lkotlin/Pair<",
            "Ljava/lang/Integer;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    .line 2210
    add-int/lit16 v0, p1, 0x3e8

    iget v1, p0, Lcom/roder300/kozen/MainActivity;->previewWidth:I

    mul-int v0, v0, v1

    div-int/lit16 v0, v0, 0x7d0

    .line 2211
    .local v0, "normalizedX":I
    add-int/lit16 v1, p2, 0x3e8

    iget v2, p0, Lcom/roder300/kozen/MainActivity;->previewHeight:I

    mul-int v1, v1, v2

    div-int/lit16 v1, v1, 0x7d0

    .line 2213
    .local v1, "normalizedY":I
    iget v2, p0, Lcom/roder300/kozen/MainActivity;->cameraDisplayOrientation:I

    sparse-switch v2, :sswitch_data_0

    .line 2220
    new-instance v2, Lkotlin/Pair;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-direct {v2, v3, v4}, Lkotlin/Pair;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V

    goto :goto_0

    .line 2219
    :sswitch_0
    new-instance v2, Lkotlin/Pair;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    iget v4, p0, Lcom/roder300/kozen/MainActivity;->previewWidth:I

    sub-int/2addr v4, v0

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-direct {v2, v3, v4}, Lkotlin/Pair;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V

    goto :goto_0

    .line 2218
    :sswitch_1
    new-instance v2, Lkotlin/Pair;

    iget v3, p0, Lcom/roder300/kozen/MainActivity;->previewWidth:I

    sub-int/2addr v3, v0

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    iget v4, p0, Lcom/roder300/kozen/MainActivity;->previewHeight:I

    sub-int/2addr v4, v1

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-direct {v2, v3, v4}, Lkotlin/Pair;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V

    goto :goto_0

    .line 2216
    :sswitch_2
    new-instance v2, Lkotlin/Pair;

    iget v3, p0, Lcom/roder300/kozen/MainActivity;->previewWidth:I

    sub-int/2addr v3, v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-direct {v2, v3, v4}, Lkotlin/Pair;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V

    .line 2213
    :goto_0
    return-object v2

    nop

    :sswitch_data_0
    .sparse-switch
        0x5a -> :sswitch_2
        0xb4 -> :sswitch_1
        0x10e -> :sswitch_0
    .end sparse-switch
.end method

.method public static synthetic doNotBlockScreen$default(Lcom/roder300/kozen/MainActivity;ZILjava/lang/Object;)V
    .locals 0

    .line 293
    const/4 p3, 0x1

    and-int/2addr p2, p3

    if-eqz p2, :cond_0

    const/4 p1, 0x1

    :cond_0
    invoke-virtual {p0, p1}, Lcom/roder300/kozen/MainActivity;->doNotBlockScreen(Z)V

    return-void
.end method

.method private final dpToPx(F)F
    .locals 1
    .param p1, "$this$dpToPx"    # F

    .line 1497
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    mul-float v0, v0, p1

    return v0
.end method

.method private final dpToPx(I)I
    .locals 2
    .param p1, "$this$dpToPx"    # I

    .line 1501
    int-to-float v0, p1

    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    iget v1, v1, Landroid/util/DisplayMetrics;->density:F

    mul-float v0, v0, v1

    float-to-int v0, v0

    return v0
.end method

.method private final findBestPreviewSize(Landroid/hardware/Camera$Parameters;)Landroid/hardware/Camera$Size;
    .locals 18
    .param p1, "params"    # Landroid/hardware/Camera$Parameters;

    .line 2030
    const-wide v0, 0x3ff5555555555555L    # 1.3333333333333333

    .line 2031
    .local v0, "targetRatio":D
    const/4 v2, 0x0

    .line 2032
    .local v2, "bestSize":Ljava/lang/Object;
    const-wide/16 v3, 0x0

    .local v3, "minDiff":D
    const-wide v3, 0x7fefffffffffffffL    # Double.MAX_VALUE

    .line 2034
    if-eqz p1, :cond_3

    invoke-virtual/range {p1 .. p1}, Landroid/hardware/Camera$Parameters;->getSupportedPreviewSizes()Ljava/util/List;

    move-result-object v5

    if-eqz v5, :cond_3

    check-cast v5, Ljava/lang/Iterable;

    .local v5, "$this$forEach\\1":Ljava/lang/Iterable;
    const/4 v6, 0x0

    .line 2290
    .local v6, "$i$f$forEach\\1\\2034":I
    invoke-interface {v5}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v7

    :goto_0
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_2

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    .local v8, "element\\1":Ljava/lang/Object;
    move-object v9, v8

    check-cast v9, Landroid/hardware/Camera$Size;

    .local v9, "size\\2":Landroid/hardware/Camera$Size;
    const/4 v10, 0x0

    .line 2035
    .local v10, "$i$a$-forEach-MainActivity$findBestPreviewSize$1\\2\\2290\\0":I
    iget v11, v9, Landroid/hardware/Camera$Size;->width:I

    int-to-double v11, v11

    iget v13, v9, Landroid/hardware/Camera$Size;->height:I

    int-to-double v13, v13

    div-double/2addr v11, v13

    .line 2036
    .local v11, "ratio\\2":D
    sub-double v13, v11, v0

    invoke-static {v13, v14}, Ljava/lang/Math;->abs(D)D

    move-result-wide v13

    .line 2038
    .local v13, "diff\\2":D
    cmpg-double v15, v13, v3

    if-gez v15, :cond_0

    iget v15, v9, Landroid/hardware/Camera$Size;->width:I

    move-wide/from16 v16, v0

    .end local v0    # "targetRatio":D
    .local v16, "targetRatio":D
    const/16 v0, 0x500

    if-gt v15, v0, :cond_1

    .line 2039
    move-wide v0, v13

    .line 2040
    .end local v3    # "minDiff":D
    .local v0, "minDiff":D
    move-object v2, v9

    move-wide v3, v0

    goto :goto_1

    .line 2038
    .end local v16    # "targetRatio":D
    .local v0, "targetRatio":D
    .restart local v3    # "minDiff":D
    :cond_0
    move-wide/from16 v16, v0

    .line 2042
    .end local v0    # "targetRatio":D
    .restart local v16    # "targetRatio":D
    :cond_1
    :goto_1
    nop

    .line 2290
    .end local v9    # "size\\2":Landroid/hardware/Camera$Size;
    .end local v10    # "$i$a$-forEach-MainActivity$findBestPreviewSize$1\\2\\2290\\0":I
    .end local v11    # "ratio\\2":D
    .end local v13    # "diff\\2":D
    move-wide/from16 v0, v16

    .end local v8    # "element\\1":Ljava/lang/Object;
    goto :goto_0

    .line 2291
    .end local v16    # "targetRatio":D
    .restart local v0    # "targetRatio":D
    :cond_2
    move-wide/from16 v16, v0

    .end local v0    # "targetRatio":D
    .end local v5    # "$this$forEach\\1":Ljava/lang/Iterable;
    .end local v6    # "$i$f$forEach\\1\\2034":I
    .restart local v16    # "targetRatio":D
    goto :goto_2

    .line 2034
    .end local v16    # "targetRatio":D
    .restart local v0    # "targetRatio":D
    :cond_3
    move-wide/from16 v16, v0

    .line 2044
    .end local v0    # "targetRatio":D
    .restart local v16    # "targetRatio":D
    :goto_2
    if-nez v2, :cond_6

    if-eqz p1, :cond_4

    invoke-virtual/range {p1 .. p1}, Landroid/hardware/Camera$Parameters;->getSupportedPreviewSizes()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_4

    invoke-static {v0}, Lkotlin/collections/CollectionsKt;->first(Ljava/util/List;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/Camera$Size;

    goto :goto_3

    :cond_4
    const/4 v0, 0x0

    :goto_3
    if-eqz v0, :cond_5

    goto :goto_4

    .line 2045
    :cond_5
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "No preview sizes available"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 2044
    :cond_6
    move-object v0, v2

    :goto_4
    return-object v0
.end method

.method private final findFrontCamera()I
    .locals 6

    .line 1930
    nop

    .line 1931
    :try_start_0
    new-instance v0, Landroid/hardware/Camera$CameraInfo;

    invoke-direct {v0}, Landroid/hardware/Camera$CameraInfo;-><init>()V

    .line 1932
    .local v0, "cameraInfo":Landroid/hardware/Camera$CameraInfo;
    const/4 v1, -0x1

    .line 1934
    .local v1, "frontCameraId":I
    const/4 v2, 0x0

    .local v2, "i":I
    invoke-static {}, Landroid/hardware/Camera;->getNumberOfCameras()I

    move-result v3

    :goto_0
    if-ge v2, v3, :cond_1

    .line 1935
    invoke-static {v2, v0}, Landroid/hardware/Camera;->getCameraInfo(ILandroid/hardware/Camera$CameraInfo;)V

    .line 1936
    iget v4, v0, Landroid/hardware/Camera$CameraInfo;->facing:I

    const/4 v5, 0x1

    if-ne v4, v5, :cond_0

    .line 1937
    move v1, v2

    .line 1938
    goto :goto_1

    .line 1934
    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 1942
    .end local v2    # "i":I
    :cond_1
    :goto_1
    invoke-static {}, Landroid/hardware/Camera;->getNumberOfCameras()I

    move-result v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "\u041d\u0430\u0439\u0434\u0435\u043d\u043e \u043a\u0430\u043c\u0435\u0440: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", \u0424\u0440\u043e\u043d\u0442\u0430\u043b\u044c\u043d\u0430\u044f: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1943
    nop

    .end local v0    # "cameraInfo":Landroid/hardware/Camera$CameraInfo;
    .end local v1    # "frontCameraId":I
    goto :goto_2

    .line 1944
    :catch_0
    move-exception v0

    .line 1945
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u041e\u0448\u0438\u0431\u043a\u0430 \u043f\u043e\u0438\u0441\u043a\u0430 \u043a\u0430\u043c\u0435\u0440: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 1946
    const/4 v1, -0x1

    .line 1930
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_2
    return v1
.end method

.method public static synthetic generateQRCodeWithRoundedCorners$default(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;Landroid/widget/ImageView;IIIFILjava/lang/Object;)V
    .locals 7

    .line 390
    and-int/lit8 p8, p7, 0x4

    if-eqz p8, :cond_0

    .line 393
    const/16 p3, 0x200

    const/16 v3, 0x200

    goto :goto_0

    .line 390
    :cond_0
    move v3, p3

    :goto_0
    and-int/lit8 p3, p7, 0x8

    if-eqz p3, :cond_1

    .line 394
    const/high16 p4, -0x1000000

    const/high16 v4, -0x1000000

    goto :goto_1

    .line 390
    :cond_1
    move v4, p4

    :goto_1
    and-int/lit8 p3, p7, 0x10

    if-eqz p3, :cond_2

    .line 395
    const/4 p5, -0x1

    const/4 v5, -0x1

    goto :goto_2

    .line 390
    :cond_2
    move v5, p5

    :goto_2
    and-int/lit8 p3, p7, 0x20

    if-eqz p3, :cond_3

    .line 396
    const/high16 p6, 0x41a00000    # 20.0f

    const/high16 v6, 0x41a00000    # 20.0f

    goto :goto_3

    .line 390
    :cond_3
    move v6, p6

    :goto_3
    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    invoke-virtual/range {v0 .. v6}, Lcom/roder300/kozen/MainActivity;->generateQRCodeWithRoundedCorners(Ljava/lang/String;Landroid/widget/ImageView;IIIF)V

    return-void
.end method

.method private final getAppVersionCode()I
    .locals 3

    .line 1409
    nop

    .line 1410
    :try_start_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1c

    const/4 v2, 0x0

    if-lt v0, v1, :cond_0

    .line 1411
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, v2}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/pm/PackageInfo;->getLongVersionCode()J

    move-result-wide v0

    long-to-int v1, v0

    goto :goto_0

    .line 1414
    :cond_0
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, v2}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v0

    iget v1, v0, Landroid/content/pm/PackageInfo;->versionCode:I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    goto :goto_1

    .line 1416
    :catch_0
    move-exception v0

    .line 1417
    .local v0, "e":Ljava/lang/Exception;
    const/4 v1, 0x1

    .line 1409
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_1
    return v1
.end method

.method private final getAppVersionName()Ljava/lang/String;
    .locals 3

    .line 1401
    nop

    .line 1402
    :try_start_0
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v0

    iget-object v0, v0, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 1403
    :catch_0
    move-exception v0

    .line 1404
    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "1.0"

    move-object v0, v1

    .line 1401
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-object v0
.end method

.method private final getCorrectDirection(ZZ)Ljava/lang/String;
    .locals 5
    .param p1, "isLeftOrUp"    # Z
    .param p2, "isVertical"    # Z

    .line 2226
    iget v0, p0, Lcom/roder300/kozen/MainActivity;->cameraDisplayOrientation:I

    const-string v1, "\u0432\u0432\u0435\u0440\u0445"

    const-string v2, "\u0432\u043b\u0435\u0432\u043e"

    const-string v3, "\u0432\u043d\u0438\u0437"

    const-string v4, "\u0432\u043f\u0440\u0430\u0432\u043e"

    sparse-switch v0, :sswitch_data_0

    .line 2246
    nop

    .line 2247
    if-eqz p2, :cond_9

    if-eqz p1, :cond_9

    goto/16 :goto_0

    .line 2240
    :sswitch_0
    nop

    .line 2241
    if-eqz p2, :cond_0

    if-eqz p1, :cond_0

    move-object v1, v2

    goto/16 :goto_0

    .line 2242
    :cond_0
    if-eqz p2, :cond_1

    if-nez p1, :cond_1

    move-object v1, v4

    goto :goto_0

    .line 2243
    :cond_1
    if-nez p2, :cond_2

    if-eqz p1, :cond_2

    move-object v1, v3

    goto :goto_0

    .line 2244
    :cond_2
    goto :goto_0

    .line 2234
    :sswitch_1
    nop

    .line 2235
    if-eqz p2, :cond_3

    if-eqz p1, :cond_3

    move-object v1, v3

    goto :goto_0

    .line 2236
    :cond_3
    if-eqz p2, :cond_4

    if-nez p1, :cond_4

    goto :goto_0

    .line 2237
    :cond_4
    if-nez p2, :cond_5

    if-eqz p1, :cond_5

    move-object v1, v4

    goto :goto_0

    .line 2238
    :cond_5
    move-object v1, v2

    goto :goto_0

    .line 2227
    :sswitch_2
    nop

    .line 2229
    if-eqz p2, :cond_6

    if-eqz p1, :cond_6

    move-object v1, v4

    goto :goto_0

    .line 2230
    :cond_6
    if-eqz p2, :cond_7

    if-nez p1, :cond_7

    move-object v1, v2

    goto :goto_0

    .line 2231
    :cond_7
    if-nez p2, :cond_8

    if-eqz p1, :cond_8

    goto :goto_0

    .line 2232
    :cond_8
    move-object v1, v3

    goto :goto_0

    .line 2248
    :cond_9
    if-eqz p2, :cond_a

    if-nez p1, :cond_a

    move-object v1, v3

    goto :goto_0

    .line 2249
    :cond_a
    if-nez p2, :cond_b

    if-eqz p1, :cond_b

    move-object v1, v2

    goto :goto_0

    .line 2250
    :cond_b
    move-object v1, v4

    .line 2226
    :goto_0
    return-object v1

    nop

    :sswitch_data_0
    .sparse-switch
        0x5a -> :sswitch_2
        0xb4 -> :sswitch_1
        0x10e -> :sswitch_0
    .end sparse-switch
.end method

.method private final getDeviceUniqueId()Ljava/lang/String;
    .locals 4

    .line 1387
    const-string v0, ""

    const-string v1, "android_id"

    .line 1388
    :try_start_0
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x1d

    if-lt v2, v3, :cond_1

    .line 1389
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    invoke-static {v2, v1}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_0

    goto :goto_0

    :cond_0
    move-object v0, v1

    goto :goto_0

    .line 1392
    :cond_1
    const-string v2, "phone"

    invoke-virtual {p0, v2}, Lcom/roder300/kozen/MainActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    const-string v3, "null cannot be cast to non-null type android.telephony.TelephonyManager"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v2, Landroid/telephony/TelephonyManager;

    invoke-virtual {v2}, Landroid/telephony/TelephonyManager;->getDeviceId()Ljava/lang/String;

    move-result-object v2

    if-nez v2, :cond_3

    .line 1393
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    invoke-static {v2, v1}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1392
    if-nez v1, :cond_2

    .line 1393
    goto :goto_0

    .line 1392
    :cond_2
    move-object v0, v1

    goto :goto_0

    :cond_3
    move-object v0, v2

    .line 1393
    :goto_0
    goto :goto_1

    .line 1395
    :catch_0
    move-exception v2

    .line 1396
    .local v2, "e":Ljava/lang/Exception;
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    invoke-static {v3, v1}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_4

    goto :goto_1

    :cond_4
    move-object v0, v1

    .line 1387
    .end local v2    # "e":Ljava/lang/Exception;
    :goto_1
    return-object v0
.end method

.method private final getRoundedCornerBitmap(Landroid/graphics/Bitmap;F)Landroid/graphics/Bitmap;
    .locals 7
    .param p1, "bitmap"    # Landroid/graphics/Bitmap;
    .param p2, "cornerRadius"    # F

    .line 436
    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v1

    sget-object v2, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v0, v1, v2}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v0

    const-string v1, "createBitmap(...)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 437
    .local v0, "output":Landroid/graphics/Bitmap;
    new-instance v1, Landroid/graphics/Canvas;

    invoke-direct {v1, v0}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    .line 438
    .local v1, "canvas":Landroid/graphics/Canvas;
    new-instance v2, Landroid/graphics/Paint;

    const/4 v3, 0x1

    invoke-direct {v2, v3}, Landroid/graphics/Paint;-><init>(I)V

    .line 439
    .local v2, "paint":Landroid/graphics/Paint;
    new-instance v3, Landroid/graphics/Rect;

    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v4

    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v5

    const/4 v6, 0x0

    invoke-direct {v3, v6, v6, v4, v5}, Landroid/graphics/Rect;-><init>(IIII)V

    .line 440
    .local v3, "rect":Landroid/graphics/Rect;
    new-instance v4, Landroid/graphics/RectF;

    invoke-direct {v4, v3}, Landroid/graphics/RectF;-><init>(Landroid/graphics/Rect;)V

    .line 442
    .local v4, "rectF":Landroid/graphics/RectF;
    invoke-virtual {v1, v4, p2, p2, v2}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 443
    new-instance v5, Landroid/graphics/PorterDuffXfermode;

    sget-object v6, Landroid/graphics/PorterDuff$Mode;->SRC_IN:Landroid/graphics/PorterDuff$Mode;

    invoke-direct {v5, v6}, Landroid/graphics/PorterDuffXfermode;-><init>(Landroid/graphics/PorterDuff$Mode;)V

    check-cast v5, Landroid/graphics/Xfermode;

    invoke-virtual {v2, v5}, Landroid/graphics/Paint;->setXfermode(Landroid/graphics/Xfermode;)Landroid/graphics/Xfermode;

    .line 444
    invoke-virtual {v1, p1, v3, v3, v2}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;Landroid/graphics/Rect;Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    .line 446
    return-object v0
.end method

.method private handleFaceConfirmed()V
    .locals 6

    const-string v5, "FaceDebug"

    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->sharedPreferences:Landroid/content/SharedPreferences;

    const-string v4, "handleFaceConfirmed: prefs=?"

    if-nez v0, :cond_0

    const-string v4, "handleFaceConfirmed: prefs=NULL!"

    :cond_0
    invoke-static {v5, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {v0}, Lcom/roder300/kozen/ServiceMenuHelper;->isSendFacePhotoEnabled(Landroid/content/SharedPreferences;)Z

    move-result v0

    const-string v4, "isSendFacePhotoEnabled=true"

    if-nez v0, :cond_1

    const-string v4, "isSendFacePhotoEnabled=false -> send_disabled"

    :cond_1
    invoke-static {v5, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz v0, :cond_5

    iget-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isFaceUploading:Z

    if-nez v0, :cond_4

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isFaceUploading:Z

    const-string v4, "payPending"

    const/4 v3, 0x0

    const/4 v2, 0x2

    invoke-static {p0, v4, v3, v2, v3}, Lcom/roder300/kozen/MainActivity;->showScreen$default(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;Ljava/lang/Boolean;ILjava/lang/Object;)V

    const-string v4, "calling showScreen(payPending) + takePicture"

    invoke-static {v5, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->camera:Landroid/hardware/Camera;

    const-string v4, "camera is NOT null - calling takePicture"

    if-nez v0, :cond_2

    const-string v4, "camera IS NULL - fallback to success"

    :cond_2
    invoke-static {v5, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz v0, :cond_3

    new-instance v1, Lcom/roder300/kozen/MainActivity$FaceJpegCallback;

    invoke-direct {v1, p0}, Lcom/roder300/kozen/MainActivity$FaceJpegCallback;-><init>(Lcom/roder300/kozen/MainActivity;)V

    const/4 v2, 0x0

    invoke-virtual {v0, v2, v2, v1}, Landroid/hardware/Camera;->takePicture(Landroid/hardware/Camera$ShutterCallback;Landroid/hardware/Camera$PictureCallback;Landroid/hardware/Camera$PictureCallback;)V

    const-string v4, "takePicture called successfully"

    invoke-static {v5, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :cond_3
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isFaceUploading:Z

    iput v0, p0, Lcom/roder300/kozen/MainActivity;->faceDetectionCount:I

    const-string v4, "camera_null - reset and retry faceRecognition"

    invoke-static {v5, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->startFaceDetection()V

    return-void

    :cond_4
    const-string v4, "already uploading - skip"

    invoke-static {v5, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :cond_5
    const-string v4, "send_disabled - showPayScreenSuccess"

    invoke-static {v5, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->showPayScreenSuccess()V

    return-void
.end method

.method private final handleNfcIntent(Landroid/content/Intent;)V
    .locals 10
    .param p1, "intent"    # Landroid/content/Intent;

    .line 736
    iget-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isNfcListening:Z

    if-nez v0, :cond_0

    return-void

    .line 738
    :cond_0
    const-string v0, "android.nfc.extra.TAG"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Landroid/nfc/Tag;

    .line 739
    .local v0, "tag":Landroid/nfc/Tag;
    if-eqz v0, :cond_1

    .line 740
    invoke-virtual {v0}, Landroid/nfc/Tag;->getId()[B

    move-result-object v1

    const-string v2, "getId(...)"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v2, ""

    check-cast v2, Ljava/lang/CharSequence;

    new-instance v7, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda17;

    invoke-direct {v7}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda17;-><init>()V

    const/16 v8, 0x1e

    const/4 v9, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-static/range {v1 .. v9}, Lkotlin/collections/ArraysKt;->joinToString$default([BLjava/lang/CharSequence;Ljava/lang/CharSequence;Ljava/lang/CharSequence;ILjava/lang/CharSequence;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "NFC \u043a\u0430\u0440\u0442\u0430 \u043e\u0431\u043d\u0430\u0440\u0443\u0436\u0435\u043d\u0430: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "NFC"

    invoke-static {v2, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 743
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->stopNfcListening()V

    .line 745
    new-instance v1, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda18;

    invoke-direct {v1, p0}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda18;-><init>(Lcom/roder300/kozen/MainActivity;)V

    invoke-virtual {p0, v1}, Lcom/roder300/kozen/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 751
    invoke-direct {p0, v0}, Lcom/roder300/kozen/MainActivity;->readNfcTag(Landroid/nfc/Tag;)V

    .line 753
    :cond_1
    return-void
.end method

.method private static final handleNfcIntent$lambda$12(B)Ljava/lang/CharSequence;
    .locals 4
    .param p0, "it"    # B

    .line 740
    invoke-static {p0}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v0

    const/4 v1, 0x1

    new-array v2, v1, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object v0, v2, v3

    invoke-static {v2, v1}, Ljava/util/Arrays;->copyOf([Ljava/lang/Object;I)[Ljava/lang/Object;

    move-result-object v0

    const-string v1, "%02x"

    invoke-static {v1, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "format(...)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Ljava/lang/CharSequence;

    return-object v0
.end method

.method private static final handleNfcIntent$lambda$13(Lcom/roder300/kozen/MainActivity;)V
    .locals 3
    .param p0, "this$0"    # Lcom/roder300/kozen/MainActivity;

    .line 746
    move-object v0, p0

    check-cast v0, Landroid/content/Context;

    const-string v1, "\u041a\u0430\u0440\u0442\u0430 \u043e\u0431\u043d\u0430\u0440\u0443\u0436\u0435\u043d\u0430!"

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 747
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->showPayScreenPending()V

    const-string v0, "nfc"

    invoke-direct {p0, v0}, Lcom/roder300/kozen/MainActivity;->startCardConfirmPolling(Ljava/lang/String;)V

    .line 748
    return-void
.end method

.method private final handlePayloadState(Ljava/lang/String;Lorg/json/JSONObject;Ljava/lang/String;)V
    .locals 12
    .param p1, "state"    # Ljava/lang/String;
    .param p2, "jsonResponse"    # Lorg/json/JSONObject;
    .param p3, "currentPayloadHash"    # Ljava/lang/String;

    .line 844
    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    move-result v0

    const-string v1, "content"

    const-string v2, "payPending"

    const-string v3, ""

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x1

    const-string v7, "data"

    sparse-switch v0, :sswitch_data_0

    move-object v5, p0

    goto/16 :goto_4

    :sswitch_0
    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    goto/16 :goto_2

    .line 882
    :cond_0
    invoke-virtual {p2, v7}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->currentScreen:Ljava/lang/String;

    const-string v2, "pending"

    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_5

    .line 883
    invoke-virtual {p2, v7}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    .line 884
    .local v0, "data":Lorg/json/JSONObject;
    if-eqz v0, :cond_1

    invoke-virtual {v0, v1, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 886
    .local v4, "content":Ljava/lang/String;
    :cond_1
    iget-object v1, p0, Lcom/roder300/kozen/MainActivity;->lastPayloadHash:Ljava/lang/String;

    invoke-static {p3, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_4

    if-eqz v4, :cond_3

    move-object v1, v4

    check-cast v1, Ljava/lang/CharSequence;

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-lez v1, :cond_2

    const/4 v1, 0x1

    goto :goto_0

    :cond_2
    const/4 v1, 0x0

    :goto_0
    if-ne v1, v6, :cond_3

    const/4 v5, 0x1

    :cond_3
    if-eqz v5, :cond_4

    .line 887
    iput-object p3, p0, Lcom/roder300/kozen/MainActivity;->lastPayloadHash:Ljava/lang/String;

    .line 888
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->showPayScreenPending()V

    move-object v5, p0

    .end local v0    # "data":Lorg/json/JSONObject;
    .end local v4    # "content":Ljava/lang/String;
    goto/16 :goto_5

    .line 886
    .restart local v0    # "data":Lorg/json/JSONObject;
    .restart local v4    # "content":Ljava/lang/String;
    :cond_4
    move-object v5, p0

    goto/16 :goto_5

    .line 882
    .end local v0    # "data":Lorg/json/JSONObject;
    .end local v4    # "content":Ljava/lang/String;
    :cond_5
    move-object v5, p0

    goto/16 :goto_5

    .line 844
    :sswitch_1
    const-string v0, "buttons"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_6

    goto/16 :goto_2

    .line 893
    :cond_6
    invoke-virtual {p2, v7}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_8

    iget-object v1, p0, Lcom/roder300/kozen/MainActivity;->currentScreen:Ljava/lang/String;

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_8

    .line 894
    invoke-virtual {p2, v7}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    .line 896
    .restart local v0    # "data":Lorg/json/JSONObject;
    iget-object v1, p0, Lcom/roder300/kozen/MainActivity;->lastPayloadHash:Ljava/lang/String;

    invoke-static {p3, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_7

    if-eqz v0, :cond_7

    .line 897
    iput-object p3, p0, Lcom/roder300/kozen/MainActivity;->lastPayloadHash:Ljava/lang/String;

    .line 898
    invoke-direct {p0, v0}, Lcom/roder300/kozen/MainActivity;->showButtonsScreen(Lorg/json/JSONObject;)V

    move-object v5, p0

    .end local v0    # "data":Lorg/json/JSONObject;
    goto/16 :goto_5

    .line 896
    .restart local v0    # "data":Lorg/json/JSONObject;
    :cond_7
    move-object v5, p0

    goto/16 :goto_5

    .line 893
    .end local v0    # "data":Lorg/json/JSONObject;
    :cond_8
    move-object v5, p0

    goto/16 :goto_5

    .line 844
    :sswitch_2
    const-string v0, "text"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_9

    goto/16 :goto_2

    .line 871
    :cond_9
    invoke-virtual {p2, v7}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_e

    iget-object v2, p0, Lcom/roder300/kozen/MainActivity;->currentScreen:Ljava/lang/String;

    invoke-static {v2, v0}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_e

    .line 872
    invoke-virtual {p2, v7}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    .line 873
    .restart local v0    # "data":Lorg/json/JSONObject;
    if-eqz v0, :cond_a

    invoke-virtual {v0, v1, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 875
    .restart local v4    # "content":Ljava/lang/String;
    :cond_a
    iget-object v1, p0, Lcom/roder300/kozen/MainActivity;->lastPayloadHash:Ljava/lang/String;

    invoke-static {p3, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_d

    if-eqz v4, :cond_c

    move-object v1, v4

    check-cast v1, Ljava/lang/CharSequence;

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-lez v1, :cond_b

    const/4 v1, 0x1

    goto :goto_1

    :cond_b
    const/4 v1, 0x0

    :goto_1
    if-ne v1, v6, :cond_c

    const/4 v5, 0x1

    :cond_c
    if-eqz v5, :cond_d

    .line 876
    iput-object p3, p0, Lcom/roder300/kozen/MainActivity;->lastPayloadHash:Ljava/lang/String;

    .line 877
    invoke-direct {p0, v4}, Lcom/roder300/kozen/MainActivity;->showTextScreen(Ljava/lang/String;)V

    move-object v5, p0

    .end local v0    # "data":Lorg/json/JSONObject;
    .end local v4    # "content":Ljava/lang/String;
    goto/16 :goto_5

    .line 875
    .restart local v0    # "data":Lorg/json/JSONObject;
    .restart local v4    # "content":Ljava/lang/String;
    :cond_d
    move-object v5, p0

    goto/16 :goto_5

    .line 871
    .end local v0    # "data":Lorg/json/JSONObject;
    .end local v4    # "content":Ljava/lang/String;
    :cond_e
    move-object v5, p0

    goto/16 :goto_5

    .line 844
    :sswitch_3
    const-string v0, "idle"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_f

    goto :goto_2

    .line 903
    :cond_f
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->currentScreen:Ljava/lang/String;

    const-string v1, "main"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_10

    .line 904
    iput-object v3, p0, Lcom/roder300/kozen/MainActivity;->lastPayloadHash:Ljava/lang/String;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isPaymentLocked:Z

    .line 905
    const/4 v0, 0x2

    invoke-static {p0, v1, v4, v0, v4}, Lcom/roder300/kozen/MainActivity;->showScreen$default(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;Ljava/lang/Boolean;ILjava/lang/Object;)V

    .line 906
    sget v0, Lcom/roder300/kozen/R$id;->textImageView:I

    invoke-virtual {p0, v0}, Lcom/roder300/kozen/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    .line 907
    .local v0, "textImageView":Landroid/widget/ImageView;
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setAlpha(F)V

    .line 908
    new-instance v1, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v2

    invoke-direct {v1, v2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v2, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda8;

    invoke-direct {v2, p0, v0}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda8;-><init>(Lcom/roder300/kozen/MainActivity;Landroid/widget/ImageView;)V

    .line 910
    nop

    .line 908
    const-wide/16 v3, 0x2bc

    invoke-virtual {v1, v2, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    move-object v5, p0

    .end local v0    # "textImageView":Landroid/widget/ImageView;
    goto/16 :goto_5

    .line 903
    :cond_10
    move-object v5, p0

    goto/16 :goto_5

    .line 844
    :sswitch_4
    const-string v0, "pay"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_11

    :goto_2
    move-object v5, p0

    goto/16 :goto_4

    .line 846
    :cond_11
    invoke-virtual {p2, v7}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_16

    iget-object v1, p0, Lcom/roder300/kozen/MainActivity;->currentScreen:Ljava/lang/String;

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_16

    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->currentScreen:Ljava/lang/String;

    const-string v1, "payContainer"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_16

    .line 847
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->currentScreen:Ljava/lang/String;

    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_15

    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->currentScreen:Ljava/lang/String;

    const-string v1, "paySuccContainer"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_15

    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->currentScreen:Ljava/lang/String;

    const-string v1, "faceRecognition"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_15

    .line 848
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->currentScreen:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "fdsgdgd: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "infoPay"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 849
    invoke-virtual {p2, v7}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    .line 850
    .local v0, "data":Lorg/json/JSONObject;
    const-string v2, "0"

    if-eqz v0, :cond_12

    const-string v3, "amount"

    invoke-virtual {v0, v3, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 851
    .local v4, "amount":Ljava/lang/String;
    :cond_12
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "amount: "

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, " , json is "

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 853
    iget-object v1, p0, Lcom/roder300/kozen/MainActivity;->lastPayloadHash:Ljava/lang/String;

    invoke-static {p3, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_14

    .line 854
    iput-object p3, p0, Lcom/roder300/kozen/MainActivity;->lastPayloadHash:Ljava/lang/String;

    .line 855
    if-nez v4, :cond_13

    goto :goto_3

    :cond_13
    move-object v2, v4

    :goto_3
    invoke-direct {p0, v2}, Lcom/roder300/kozen/MainActivity;->showPayScreen(Ljava/lang/String;)V

    .line 856
    move-object v1, p0

    check-cast v1, Landroid/content/Context;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u041d\u043e\u0432\u0430\u044f \u043e\u043f\u043b\u0430\u0442\u0430: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " \u0440\u0443\u0431."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v1, v2, v5}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/Toast;->show()V

    .line 857
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->startVideoPlayback()V

    .line 858
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->setupNfc()V

    .line 859
    nop

    .line 860
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getSharedPreferences()Landroid/content/SharedPreferences;

    move-result-object v1

    const-string v2, "terminal_id"

    const-string v3, ""

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 861
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getSharedPreferences()Landroid/content/SharedPreferences;

    move-result-object v2

    const-string v3, "qr_password"

    const-string v5, "000000"

    invoke-interface {v2, v3, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 862
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "https://sberpos-web.onrender.com/pay/"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v5, "/key="

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 861
    sget v1, Lcom/roder300/kozen/R$id;->qrImage:I

    invoke-virtual {p0, v1}, Lcom/roder300/kozen/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    const-string v2, "findViewById(...)"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v7, v1

    check-cast v7, Landroid/widget/ImageView;

    .line 862
    nop

    .line 863
    nop

    .line 864
    nop

    .line 865
    nop

    .line 859
    const/16 v8, 0x1ae

    const/4 v9, -0x1

    const/4 v10, 0x0

    const/high16 v11, 0x41200000    # 10.0f

    move-object v5, p0

    invoke-virtual/range {v5 .. v11}, Lcom/roder300/kozen/MainActivity;->generateQRCodeWithRoundedCorners(Ljava/lang/String;Landroid/widget/ImageView;IIIF)V

    .end local v0    # "data":Lorg/json/JSONObject;
    .end local v4    # "amount":Ljava/lang/String;
    goto :goto_5

    .line 853
    .restart local v0    # "data":Lorg/json/JSONObject;
    .restart local v4    # "amount":Ljava/lang/String;
    :cond_14
    move-object v5, p0

    goto :goto_5

    .line 847
    .end local v0    # "data":Lorg/json/JSONObject;
    .end local v4    # "amount":Ljava/lang/String;
    :cond_15
    move-object v5, p0

    goto :goto_5

    .line 846
    :cond_16
    move-object v5, p0

    goto :goto_5

    .line 915
    :goto_4
    iget-object v0, v5, Lcom/roder300/kozen/MainActivity;->lastPayloadHash:Ljava/lang/String;

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_17

    invoke-virtual {p2, v7}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_17

    .line 916
    iput-object p3, v5, Lcom/roder300/kozen/MainActivity;->lastPayloadHash:Ljava/lang/String;

    .line 917
    invoke-virtual {p2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "toString(...)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 918
    .local v0, "rawData":Ljava/lang/String;
    move-object v1, v5

    check-cast v1, Landroid/content/Context;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u041d\u043e\u0432\u044b\u0439 payload: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v1, v2, v6}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/Toast;->show()V

    .line 922
    .end local v0    # "rawData":Ljava/lang/String;
    :cond_17
    :goto_5
    return-void

    :sswitch_data_0
    .sparse-switch
        0x1b0a8 -> :sswitch_4
        0x313fd4 -> :sswitch_3
        0x36452d -> :sswitch_2
        0xe62bf81 -> :sswitch_1
        0x6206e3cf -> :sswitch_0
    .end sparse-switch
.end method

.method private static final handlePayloadState$lambda$14(Lcom/roder300/kozen/MainActivity;Landroid/widget/ImageView;)V
    .locals 0
    .param p0, "this$0"    # Lcom/roder300/kozen/MainActivity;
    .param p1, "$textImageView"    # Landroid/widget/ImageView;

    .line 909
    invoke-static {p1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-direct {p0, p1}, Lcom/roder300/kozen/MainActivity;->startSmoothEaseOutAnimation(Landroid/widget/ImageView;)V

    .line 910
    return-void
.end method

.method private final hideAllContainersExcept(Landroid/view/View;)V
    .locals 8
    .param p1, "exceptContainer"    # Landroid/view/View;

    .line 1041
    const/4 v0, 0x7

    new-array v0, v0, [Landroid/view/ViewGroup;

    iget-object v1, p0, Lcom/roder300/kozen/MainActivity;->mainContainer:Landroidx/constraintlayout/widget/ConstraintLayout;

    const/4 v2, 0x0

    if-nez v1, :cond_0

    const-string v1, "mainContainer"

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v1, v2

    :cond_0
    const/4 v3, 0x0

    aput-object v1, v0, v3

    iget-object v1, p0, Lcom/roder300/kozen/MainActivity;->payContainer:Landroid/widget/FrameLayout;

    if-nez v1, :cond_1

    const-string v1, "payContainer"

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v1, v2

    :cond_1
    const/4 v3, 0x1

    aput-object v1, v0, v3

    iget-object v1, p0, Lcom/roder300/kozen/MainActivity;->payPendingContainer:Landroid/widget/FrameLayout;

    if-nez v1, :cond_2

    const-string v1, "payPendingContainer"

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v1, v2

    :cond_2
    const/4 v3, 0x2

    aput-object v1, v0, v3

    iget-object v1, p0, Lcom/roder300/kozen/MainActivity;->faceRecognition:Landroid/widget/FrameLayout;

    if-nez v1, :cond_3

    const-string v1, "faceRecognition"

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v1, v2

    :cond_3
    const/4 v3, 0x3

    aput-object v1, v0, v3

    iget-object v1, p0, Lcom/roder300/kozen/MainActivity;->paySuccContainer:Landroid/widget/FrameLayout;

    if-nez v1, :cond_4

    const-string v1, "paySuccContainer"

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v1, v2

    :cond_4
    const/4 v3, 0x4

    aput-object v1, v0, v3

    iget-object v1, p0, Lcom/roder300/kozen/MainActivity;->textContainer:Landroid/widget/LinearLayout;

    if-nez v1, :cond_5

    const-string v1, "textContainer"

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v1, v2

    :cond_5
    const/4 v3, 0x5

    aput-object v1, v0, v3

    iget-object v1, p0, Lcom/roder300/kozen/MainActivity;->buttonsContainer:Landroid/widget/LinearLayout;

    if-nez v1, :cond_6

    const-string v1, "buttonsContainer"

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_0

    :cond_6
    move-object v2, v1

    :goto_0
    const/4 v1, 0x6

    aput-object v2, v0, v1

    invoke-static {v0}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    .line 1043
    .local v0, "containers":Ljava/util/List;
    move-object v1, v0

    check-cast v1, Ljava/lang/Iterable;

    .local v1, "$this$forEach\\1":Ljava/lang/Iterable;
    const/4 v2, 0x0

    .line 2286
    .local v2, "$i$f$forEach\\1\\1043":I
    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_8

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    .local v4, "element\\1":Ljava/lang/Object;
    move-object v5, v4

    check-cast v5, Landroid/view/ViewGroup;

    .local v5, "container\\2":Landroid/view/ViewGroup;
    const/4 v6, 0x0

    .line 1044
    .local v6, "$i$a$-forEach-MainActivity$hideAllContainersExcept$1\\2\\2286\\0":I
    invoke-static {v5, p1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_7

    .line 1046
    const/16 v7, 0x8

    invoke-virtual {v5, v7}, Landroid/view/ViewGroup;->setVisibility(I)V

    .line 1047
    const/high16 v7, 0x3f800000    # 1.0f

    invoke-virtual {v5, v7}, Landroid/view/ViewGroup;->setAlpha(F)V

    .line 1048
    const/4 v7, 0x0

    invoke-virtual {v5, v7}, Landroid/view/ViewGroup;->setTranslationY(F)V

    .line 1050
    :cond_7
    nop

    .line 2286
    .end local v5    # "container\\2":Landroid/view/ViewGroup;
    .end local v6    # "$i$a$-forEach-MainActivity$hideAllContainersExcept$1\\2\\2286\\0":I
    nop

    .end local v4    # "element\\1":Ljava/lang/Object;
    goto :goto_1

    .line 2287
    :cond_8
    nop

    .line 1051
    .end local v1    # "$this$forEach\\1":Ljava/lang/Iterable;
    .end local v2    # "$i$f$forEach\\1\\1043":I
    return-void
.end method

.method private final initViewsCam()V
    .locals 2

    .line 323
    sget v0, Lcom/roder300/kozen/R$id;->cameraContainers:I

    invoke-virtual {p0, v0}, Lcom/roder300/kozen/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/FrameLayout;

    iput-object v0, p0, Lcom/roder300/kozen/MainActivity;->cameraContainer:Landroid/widget/FrameLayout;

    .line 324
    sget v0, Lcom/roder300/kozen/R$id;->closeButtonCamera:I

    invoke-virtual {p0, v0}, Lcom/roder300/kozen/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lcom/roder300/kozen/MainActivity;->button:Landroid/widget/ImageView;

    .line 325
    sget v0, Lcom/roder300/kozen/R$id;->imageDescFace:I

    invoke-virtual {p0, v0}, Lcom/roder300/kozen/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lcom/roder300/kozen/MainActivity;->imageDescFace:Landroid/widget/ImageView;

    .line 327
    new-instance v0, Landroid/view/SurfaceView;

    move-object v1, p0

    check-cast v1, Landroid/content/Context;

    invoke-direct {v0, v1}, Landroid/view/SurfaceView;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/roder300/kozen/MainActivity;->surfaceView:Landroid/view/SurfaceView;

    .line 328
    return-void
.end method

.method private final isDeviceRegistered()Z
    .locals 3

    .line 1283
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->sharedPreferences:Landroid/content/SharedPreferences;

    if-nez v0, :cond_0

    const-string v0, "sharedPreferences"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v0, 0x0

    :cond_0
    const-string v1, "is_registered"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method private final isNetworkAvailable()Z
    .locals 4

    .line 1422
    const-string v0, "connectivity"

    invoke-virtual {p0, v0}, Lcom/roder300/kozen/MainActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    const-string v1, "null cannot be cast to non-null type android.net.ConnectivityManager"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Landroid/net/ConnectivityManager;

    .line 1423
    .local v0, "connectivityManager":Landroid/net/ConnectivityManager;
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x17

    const/4 v3, 0x0

    if-lt v1, v2, :cond_2

    .line 1424
    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetwork()Landroid/net/Network;

    move-result-object v1

    if-nez v1, :cond_0

    return v3

    .line 1425
    .local v1, "network":Landroid/net/Network;
    :cond_0
    invoke-virtual {v0, v1}, Landroid/net/ConnectivityManager;->getNetworkCapabilities(Landroid/net/Network;)Landroid/net/NetworkCapabilities;

    move-result-object v2

    if-nez v2, :cond_1

    return v3

    .line 1426
    .local v2, "capabilities":Landroid/net/NetworkCapabilities;
    :cond_1
    const/16 v3, 0xc

    invoke-virtual {v2, v3}, Landroid/net/NetworkCapabilities;->hasCapability(I)Z

    move-result v3

    return v3

    .line 1429
    .end local v1    # "network":Landroid/net/Network;
    .end local v2    # "capabilities":Landroid/net/NetworkCapabilities;
    :cond_2
    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v1

    .line 1428
    nop

    .line 1430
    .local v1, "networkInfo":Landroid/net/NetworkInfo;
    if-eqz v1, :cond_3

    invoke-virtual {v1}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v2

    if-eqz v2, :cond_3

    const/4 v3, 0x1

    :cond_3
    return v3
.end method

.method private final loadAllSounds()V
    .locals 2

    .line 1014
    const-string v0, "success_pay"

    sget v1, Lcom/roder300/kozen/R$raw;->success_sound:I

    invoke-direct {p0, v0, v1}, Lcom/roder300/kozen/MainActivity;->loadSound(Ljava/lang/String;I)V

    const-string v0, "success_face"

    sget v1, Lcom/roder300/kozen/R$raw;->success_face:I

    invoke-direct {p0, v0, v1}, Lcom/roder300/kozen/MainActivity;->loadSound(Ljava/lang/String;I)V

    .line 1015
    const-string v0, "error_pay"

    sget v1, Lcom/roder300/kozen/R$raw;->error_payment:I

    invoke-direct {p0, v0, v1}, Lcom/roder300/kozen/MainActivity;->loadSound(Ljava/lang/String;I)V

    .line 1016
    const-string v0, "beep"

    sget v1, Lcom/roder300/kozen/R$raw;->beep_4:I

    invoke-direct {p0, v0, v1}, Lcom/roder300/kozen/MainActivity;->loadSound(Ljava/lang/String;I)V

    .line 1017
    return-void
.end method

.method private final loadSound(Ljava/lang/String;I)V
    .locals 4
    .param p1, "soundName"    # Ljava/lang/String;
    .param p2, "resourceId"    # I

    .line 1020
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->soundPool:Landroid/media/SoundPool;

    if-eqz v0, :cond_0

    move-object v1, p0

    check-cast v1, Landroid/content/Context;

    const/4 v2, 0x1

    invoke-virtual {v0, v1, p2, v2}, Landroid/media/SoundPool;->load(Landroid/content/Context;II)I

    move-result v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    .line 1021
    .local v0, "soundId":I
    :goto_0
    const-string v1, "SoundPool"

    if-eqz v0, :cond_1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    .line 1022
    iget-object v3, p0, Lcom/roder300/kozen/MainActivity;->soundMap:Ljava/util/Map;

    invoke-interface {v3, p1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1023
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u0417\u0432\u0443\u043a \'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\' \u0437\u0430\u0433\u0440\u0443\u0436\u0435\u043d \u0441 ID: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 1025
    :cond_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u041d\u0435 \u0443\u0434\u0430\u043b\u043e\u0441\u044c \u0437\u0430\u0433\u0440\u0443\u0437\u0438\u0442\u044c \u0437\u0432\u0443\u043a: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1027
    :goto_1
    return-void
.end method

.method private static final onCreate$lambda$0(Lcom/roder300/kozen/MainActivity;)V
    .locals 3
    .param p0, "this$0"    # Lcom/roder300/kozen/MainActivity;

    .line 267
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->mainContainer:Landroidx/constraintlayout/widget/ConstraintLayout;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    const-string v0, "mainContainer"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v0, v1

    :cond_0
    check-cast v0, Landroid/view/View;

    invoke-direct {p0, v0}, Lcom/roder300/kozen/MainActivity;->hideAllContainersExcept(Landroid/view/View;)V

    .line 268
    const-string v0, "main"

    const/4 v2, 0x2

    invoke-static {p0, v0, v1, v2, v1}, Lcom/roder300/kozen/MainActivity;->showScreen$default(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;Ljava/lang/Boolean;ILjava/lang/Object;)V

    .line 269
    return-void
.end method

.method private static final onCreate$lambda$1(Lcom/roder300/kozen/MainActivity;Landroid/widget/ImageView;)V
    .locals 0
    .param p0, "this$0"    # Lcom/roder300/kozen/MainActivity;
    .param p1, "$textImageView"    # Landroid/widget/ImageView;

    .line 276
    invoke-static {p1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-direct {p0, p1}, Lcom/roder300/kozen/MainActivity;->startSmoothEaseOutAnimation(Landroid/widget/ImageView;)V

    .line 277
    return-void
.end method

.method private static final onCreate$lambda$2(Lcom/roder300/kozen/MainActivity;Landroid/view/View;)V
    .locals 2
    .param p0, "this$0"    # Lcom/roder300/kozen/MainActivity;
    .param p1, "it"    # Landroid/view/View;

    .line 280
    iget v0, p0, Lcom/roder300/kozen/MainActivity;->clickCount:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/roder300/kozen/MainActivity;->clickCount:I

    .line 282
    iget v0, p0, Lcom/roder300/kozen/MainActivity;->clickCount:I

    iget v1, p0, Lcom/roder300/kozen/MainActivity;->requiredClicks:I

    if-lt v0, v1, :cond_0

    .line 283
    const/4 v0, 0x0

    iput v0, p0, Lcom/roder300/kozen/MainActivity;->clickCount:I

    .line 284
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->showPasswordDialog()V

    .line 286
    :cond_0
    return-void
.end method

.method private static final onFaceDetection$lambda$44(Lcom/roder300/kozen/MainActivity;[Landroid/hardware/Camera$Face;)V
    .locals 17
    .param p0, "this$0"    # Lcom/roder300/kozen/MainActivity;
    .param p1, "$faces"    # [Landroid/hardware/Camera$Face;

    .line 2072
    move-object/from16 v1, p0

    move-object/from16 v2, p1

    const-string v0, ", Y="

    const-string v3, ""

    const-string v4, "-"

    const-string v5, " px (\u0434\u0438\u0430\u043f\u0430\u0437\u043e\u043d: "

    .line 2073
    const/4 v6, 0x0

    :try_start_0
    iput-object v6, v1, Lcom/roder300/kozen/MainActivity;->currentFace:Landroid/hardware/Camera$Face;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 2075
    const-string v7, "face_normal"

    const/4 v8, 0x2

    if-eqz v2, :cond_f

    :try_start_1
    array-length v9, v2

    const/4 v10, 0x0

    const/4 v11, 0x1

    if-nez v9, :cond_0

    const/4 v9, 0x1

    goto :goto_0

    :cond_0
    const/4 v9, 0x0

    :goto_0
    if-eqz v9, :cond_1

    goto/16 :goto_6

    .line 2085
    :cond_1
    array-length v9, v2
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    const-string v12, "face_two"

    const-string v13, "\u041e\u0431\u043d\u0430\u0440\u0443\u0436\u0435\u043d\u043e \u043d\u0435\u0441\u043a\u043e\u043b\u044c\u043a\u043e \u043b\u0438\u0446"

    if-le v9, v11, :cond_2

    .line 2086
    :try_start_2
    array-length v0, v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "\u041e\u0431\u043d\u0430\u0440\u0443\u0436\u0435\u043d\u043e \u043d\u0435\u0441\u043a\u043e\u043b\u044c\u043a\u043e \u043b\u0438\u0446 ("

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "). \u0421\u0431\u0440\u043e\u0441 \u043f\u0440\u043e\u0432\u0435\u0440\u043a\u0438."

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 2087
    invoke-virtual {v1, v13}, Lcom/roder300/kozen/MainActivity;->setTextDesc(Ljava/lang/String;)V

    .line 2088
    invoke-static {v1, v12, v6, v8, v6}, Lcom/roder300/kozen/MainActivity;->showImgDesc$default(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;Landroid/widget/ImageView;ILjava/lang/Object;)V

    .line 2089
    invoke-direct {v1}, Lcom/roder300/kozen/MainActivity;->resetDetectionState()V

    .line 2090
    return-void

    .line 2093
    :cond_2
    aget-object v9, v2, v10

    .line 2094
    .local v9, "face":Landroid/hardware/Camera$Face;
    iput-object v9, v1, Lcom/roder300/kozen/MainActivity;->currentFace:Landroid/hardware/Camera$Face;

    .line 2096
    iget v14, v9, Landroid/hardware/Camera$Face;->score:I

    iget v15, v1, Lcom/roder300/kozen/MainActivity;->minConfidence:I

    if-ge v14, v15, :cond_3

    .line 2097
    iget v0, v9, Landroid/hardware/Camera$Face;->score:I

    iget v3, v1, Lcom/roder300/kozen/MainActivity;->minConfidence:I

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "\u041d\u0438\u0437\u043a\u0430\u044f \u0434\u043e\u0441\u0442\u043e\u0432\u0435\u0440\u043d\u043e\u0441\u0442\u044c: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v4, "% < "

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "%. \u0421\u0431\u0440\u043e\u0441."

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 2098
    const-string v0, "\u041f\u043e\u0434\u043e\u0439\u0434\u0438\u0442\u0435 \u0431\u043b\u0438\u0436\u0435"

    invoke-virtual {v1, v0}, Lcom/roder300/kozen/MainActivity;->setTextDesc(Ljava/lang/String;)V

    .line 2099
    const-string v0, "face_far"

    invoke-static {v1, v0, v6, v8, v6}, Lcom/roder300/kozen/MainActivity;->showImgDesc$default(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;Landroid/widget/ImageView;ILjava/lang/Object;)V

    .line 2100
    invoke-direct {v1}, Lcom/roder300/kozen/MainActivity;->resetDetectionState()V

    .line 2101
    return-void

    .line 2104
    :cond_3
    iget v14, v1, Lcom/roder300/kozen/MainActivity;->currentFaceId:I

    const/4 v15, -0x1

    if-eq v14, v15, :cond_4

    iget v14, v9, Landroid/hardware/Camera$Face;->id:I

    iget v10, v1, Lcom/roder300/kozen/MainActivity;->currentFaceId:I

    if-eq v14, v10, :cond_4

    .line 2105
    iget v0, v9, Landroid/hardware/Camera$Face;->id:I

    iget v3, v1, Lcom/roder300/kozen/MainActivity;->currentFaceId:I

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "\u041e\u0431\u043d\u0430\u0440\u0443\u0436\u0435\u043d\u043e \u0434\u0440\u0443\u0433\u043e\u0435 \u043b\u0438\u0446\u043e (ID: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v4, " vs "

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "). \u0421\u0431\u0440\u043e\u0441."

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 2106
    invoke-virtual {v1, v13}, Lcom/roder300/kozen/MainActivity;->setTextDesc(Ljava/lang/String;)V

    .line 2107
    invoke-static {v1, v12, v6, v8, v6}, Lcom/roder300/kozen/MainActivity;->showImgDesc$default(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;Landroid/widget/ImageView;ILjava/lang/Object;)V

    .line 2108
    invoke-direct {v1}, Lcom/roder300/kozen/MainActivity;->resetDetectionState()V

    .line 2109
    return-void

    .line 2112
    :cond_4
    iget v10, v1, Lcom/roder300/kozen/MainActivity;->currentFaceId:I

    if-ne v10, v15, :cond_5

    .line 2113
    iget v10, v9, Landroid/hardware/Camera$Face;->id:I

    iput v10, v1, Lcom/roder300/kozen/MainActivity;->currentFaceId:I

    .line 2114
    iget v10, v1, Lcom/roder300/kozen/MainActivity;->currentFaceId:I

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "\u041d\u0430\u0447\u0430\u0442\u043e \u043e\u0442\u0441\u043b\u0435\u0436\u0438\u0432\u0430\u043d\u0438\u0435 \u043b\u0438\u0446\u0430 ID: "

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-direct {v1, v10}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 2115
    const-string v10, "\u0423\u043b\u044b\u0431\u043d\u0438\u0442\u0435\u0441\u044c!"

    invoke-virtual {v1, v10}, Lcom/roder300/kozen/MainActivity;->setTextDesc(Ljava/lang/String;)V

    .line 2116
    invoke-static {v1, v7, v6, v8, v6}, Lcom/roder300/kozen/MainActivity;->showImgDesc$default(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;Landroid/widget/ImageView;ILjava/lang/Object;)V

    .line 2120
    :cond_5
    iget-object v10, v9, Landroid/hardware/Camera$Face;->rect:Landroid/graphics/Rect;

    invoke-virtual {v10}, Landroid/graphics/Rect;->centerX()I

    move-result v10

    iget-object v12, v9, Landroid/hardware/Camera$Face;->rect:Landroid/graphics/Rect;

    invoke-virtual {v12}, Landroid/graphics/Rect;->centerY()I

    move-result v12

    invoke-direct {v1, v10, v12}, Lcom/roder300/kozen/MainActivity;->convertFaceCoordinates(II)Lkotlin/Pair;

    move-result-object v10

    invoke-virtual {v10}, Lkotlin/Pair;->component1()Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Ljava/lang/Number;

    invoke-virtual {v12}, Ljava/lang/Number;->intValue()I

    move-result v12

    .local v12, "faceCenterX":I
    invoke-virtual {v10}, Lkotlin/Pair;->component2()Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/lang/Number;

    invoke-virtual {v10}, Ljava/lang/Number;->intValue()I

    move-result v10

    .line 2122
    .local v10, "faceCenterY":I
    iget v13, v1, Lcom/roder300/kozen/MainActivity;->centerRangeStartX:I

    iget v14, v1, Lcom/roder300/kozen/MainActivity;->centerRangeEndX:I

    .line 2123
    iget v15, v1, Lcom/roder300/kozen/MainActivity;->centerRangeStartY:I

    iget v6, v1, Lcom/roder300/kozen/MainActivity;->centerRangeEndY:I

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "\u0426\u0435\u043d\u0442\u0440 \u043b\u0438\u0446\u0430: X="

    invoke-virtual {v8, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v11, "), Y="

    invoke-virtual {v8, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v15}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ")"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 2122
    invoke-direct {v1, v4}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 2126
    const/4 v4, 0x0

    .line 2127
    .local v4, "needToMoveX":Z
    move-object v5, v3

    .line 2128
    .local v5, "xDirection":Ljava/lang/String;
    iget v6, v1, Lcom/roder300/kozen/MainActivity;->centerRangeStartX:I

    if-ge v12, v6, :cond_6

    .line 2129
    const/4 v4, 0x1

    .line 2130
    const/4 v6, 0x0

    const/4 v8, 0x1

    invoke-direct {v1, v8, v6}, Lcom/roder300/kozen/MainActivity;->getCorrectDirection(ZZ)Ljava/lang/String;

    move-result-object v11

    move-object v5, v11

    goto :goto_1

    .line 2132
    :cond_6
    iget v6, v1, Lcom/roder300/kozen/MainActivity;->centerRangeEndX:I

    if-le v12, v6, :cond_7

    .line 2133
    const/4 v4, 0x1

    .line 2134
    const/4 v6, 0x0

    invoke-direct {v1, v6, v6}, Lcom/roder300/kozen/MainActivity;->getCorrectDirection(ZZ)Ljava/lang/String;

    move-result-object v8

    move-object v5, v8

    .line 2138
    :cond_7
    :goto_1
    const/4 v6, 0x0

    .line 2139
    .local v6, "needToMoveY":Z
    nop

    .line 2140
    .local v3, "yDirection":Ljava/lang/String;
    iget v8, v1, Lcom/roder300/kozen/MainActivity;->centerRangeStartY:I

    if-ge v10, v8, :cond_8

    .line 2141
    const/4 v6, 0x1

    .line 2142
    const/4 v8, 0x0

    const/4 v11, 0x1

    invoke-direct {v1, v8, v11}, Lcom/roder300/kozen/MainActivity;->getCorrectDirection(ZZ)Ljava/lang/String;

    move-result-object v8

    move-object v3, v8

    goto :goto_2

    .line 2143
    :cond_8
    iget v8, v1, Lcom/roder300/kozen/MainActivity;->centerRangeEndY:I

    if-le v10, v8, :cond_9

    .line 2144
    const/4 v6, 0x1

    .line 2145
    const/4 v8, 0x1

    invoke-direct {v1, v8, v8}, Lcom/roder300/kozen/MainActivity;->getCorrectDirection(ZZ)Ljava/lang/String;

    move-result-object v11

    move-object v3, v11

    .line 2151
    :cond_9
    :goto_2
    if-nez v4, :cond_b

    if-eqz v6, :cond_a

    goto/16 :goto_3

    .line 2174
    :cond_a
    iget v8, v1, Lcom/roder300/kozen/MainActivity;->faceDetectionCount:I

    const/16 v16, 0x1

    add-int/lit8 v8, v8, 0x1

    iput v8, v1, Lcom/roder300/kozen/MainActivity;->faceDetectionCount:I

    .line 2175
    iget v8, v1, Lcom/roder300/kozen/MainActivity;->faceDetectionCount:I

    iget v11, v1, Lcom/roder300/kozen/MainActivity;->requiredDetections:I

    .line 2176
    iget v13, v9, Landroid/hardware/Camera$Face;->id:I

    iget v14, v9, Landroid/hardware/Camera$Face;->score:I

    .line 2177
    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "\u2713 \u041e\u0431\u043d\u0430\u0440\u0443\u0436\u0435\u043d\u0438\u0435 "

    invoke-virtual {v15, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v8, "/"

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v8, ": ID:"

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v8, " \u0414\u043e\u0441\u0442\u043e\u0432\u0435\u0440\u043d\u043e\u0441\u0442\u044c:"

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v8, "% \u041f\u043e\u0437\u0438\u0446\u0438\u044f: X="

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 2175
    invoke-direct {v1, v2}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 2179
    iget v2, v1, Lcom/roder300/kozen/MainActivity;->faceDetectionCount:I

    iget v8, v1, Lcom/roder300/kozen/MainActivity;->requiredDetections:I

    if-lt v2, v8, :cond_11

    iget-boolean v2, v1, Lcom/roder300/kozen/MainActivity;->validFaceDetected:Z

    if-nez v2, :cond_11

    .line 2180
    const/4 v8, 0x1

    iput-boolean v8, v1, Lcom/roder300/kozen/MainActivity;->validFaceDetected:Z

    .line 2181
    const-string v2, "\u2705 \u041b\u0418\u0426\u041e \u0423\u0421\u041f\u0415\u0428\u041d\u041e \u041e\u0411\u041d\u0410\u0420\u0423\u0416\u0415\u041d\u041e!"

    invoke-direct {v1, v2}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 2182
    iget v2, v1, Lcom/roder300/kozen/MainActivity;->requiredDetections:I

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "\u2705 \u041f\u0440\u043e\u0448\u043b\u043e \u0432\u0441\u0435 \u043f\u0440\u043e\u0432\u0435\u0440\u043a\u0438: "

    invoke-virtual {v8, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v8, " \u043e\u0431\u043d\u0430\u0440\u0443\u0436\u0435\u043d\u0438\u0439"

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 2183
    iget v2, v9, Landroid/hardware/Camera$Face;->score:I

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "\u2705 \u0414\u043e\u0441\u0442\u043e\u0432\u0435\u0440\u043d\u043e\u0441\u0442\u044c: "

    invoke-virtual {v8, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v8, "%"

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 2184
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "\u2705 \u041f\u043e\u0437\u0438\u0446\u0438\u044f \u0432 \u0446\u0435\u043d\u0442\u0440\u0435: X="

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 2185
    const-string v0, "\u0423\u0441\u043f\u0435\u0448\u043d\u043e!"

    invoke-virtual {v1, v0}, Lcom/roder300/kozen/MainActivity;->setTextDesc(Ljava/lang/String;)V

    .line 2186
    const/4 v0, 0x2

    const/4 v2, 0x0

    invoke-static {v1, v7, v2, v0, v2}, Lcom/roder300/kozen/MainActivity;->showImgDesc$default(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;Landroid/widget/ImageView;ILjava/lang/Object;)V

    .line 2194
    invoke-direct {v1}, Lcom/roder300/kozen/MainActivity;->handleFaceConfirmed()V

    .line 2196
    invoke-direct {v1}, Lcom/roder300/kozen/MainActivity;->stopFaceDetection()V

    .end local v3    # "yDirection":Ljava/lang/String;
    .end local v4    # "needToMoveX":Z
    .end local v5    # "xDirection":Ljava/lang/String;
    .end local v6    # "needToMoveY":Z
    .end local v9    # "face":Landroid/hardware/Camera$Face;
    .end local v10    # "faceCenterY":I
    .end local v12    # "faceCenterX":I
    goto/16 :goto_7

    .line 2152
    .restart local v3    # "yDirection":Ljava/lang/String;
    .restart local v4    # "needToMoveX":Z
    .restart local v5    # "xDirection":Ljava/lang/String;
    .restart local v6    # "needToMoveY":Z
    .restart local v9    # "face":Landroid/hardware/Camera$Face;
    .restart local v10    # "faceCenterY":I
    .restart local v12    # "faceCenterX":I
    :cond_b
    :goto_3
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    move-object v2, v0

    .local v2, "$this$onFaceDetection_u24lambda_u2444_u24lambda_u2443\\1":Ljava/lang/StringBuilder;
    const/4 v7, 0x0

    .line 2153
    .local v7, "$i$a$-buildString-MainActivity$onFaceDetection$1$message$1\\1\\2152\\0":I
    if-eqz v4, :cond_c

    if-eqz v6, :cond_c

    .line 2154
    const-string v8, "\u0421\u043c\u0435\u0441\u0442\u0438\u0442\u0435\u0441\u044c"

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_4

    .line 2155
    :cond_c
    const-string v8, "\u0421\u043c\u0435\u0441\u0442\u0438\u0442\u0435\u0441\u044c \u043d\u0435\u043c\u043d\u043e\u0433\u043e"

    if-eqz v4, :cond_d

    .line 2156
    :try_start_3
    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_4

    .line 2158
    :cond_d
    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 2160
    :goto_4
    nop

    .line 2152
    .end local v2    # "$this$onFaceDetection_u24lambda_u2444_u24lambda_u2443\\1":Ljava/lang/StringBuilder;
    .end local v7    # "$i$a$-buildString-MainActivity$onFaceDetection$1$message$1\\1\\2152\\0":I
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v2, "toString(...)"

    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 2162
    .local v0, "message":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "\u041b\u0438\u0446\u043e \u043d\u0435 \u0432 \u0446\u0435\u043d\u0442\u0440\u0435: "

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 2163
    invoke-virtual {v1, v0}, Lcom/roder300/kozen/MainActivity;->setTextDesc(Ljava/lang/String;)V

    .line 2164
    iget v2, v1, Lcom/roder300/kozen/MainActivity;->previewWidth:I

    const/4 v7, 0x2

    div-int/2addr v2, v7

    if-ge v12, v2, :cond_e

    .line 2165
    const-string v2, "face_left"

    const/4 v8, 0x0

    invoke-static {v1, v2, v8, v7, v8}, Lcom/roder300/kozen/MainActivity;->showImgDesc$default(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;Landroid/widget/ImageView;ILjava/lang/Object;)V

    goto :goto_5

    .line 2168
    :cond_e
    const-string v2, "face_right"

    const/4 v7, 0x2

    const/4 v8, 0x0

    invoke-static {v1, v2, v8, v7, v8}, Lcom/roder300/kozen/MainActivity;->showImgDesc$default(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;Landroid/widget/ImageView;ILjava/lang/Object;)V

    .line 2170
    :goto_5
    invoke-direct {v1}, Lcom/roder300/kozen/MainActivity;->resetDetectionState()V

    .line 2171
    return-void

    .line 2076
    .end local v0    # "message":Ljava/lang/String;
    .end local v3    # "yDirection":Ljava/lang/String;
    .end local v4    # "needToMoveX":Z
    .end local v5    # "xDirection":Ljava/lang/String;
    .end local v6    # "needToMoveY":Z
    .end local v9    # "face":Landroid/hardware/Camera$Face;
    .end local v10    # "faceCenterY":I
    .end local v12    # "faceCenterX":I
    :cond_f
    :goto_6
    iget v0, v1, Lcom/roder300/kozen/MainActivity;->faceDetectionCount:I

    if-lez v0, :cond_10

    .line 2077
    iget v0, v1, Lcom/roder300/kozen/MainActivity;->faceDetectionCount:I

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u041b\u0438\u0446\u043e \u043f\u043e\u0442\u0435\u0440\u044f\u043d\u043e. \u0421\u0431\u0440\u043e\u0441 \u0441\u0447\u0435\u0442\u0447\u0438\u043a\u0430: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, " \u2192 0"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 2078
    const-string v0, "\u041f\u043e\u0441\u043c\u043e\u0442\u0440\u0438\u0442\u0435 \u0432 \u043a\u0430\u043c\u0435\u0440\u0443"

    invoke-virtual {v1, v0}, Lcom/roder300/kozen/MainActivity;->setTextDesc(Ljava/lang/String;)V

    .line 2079
    const/4 v0, 0x2

    const/4 v8, 0x0

    invoke-static {v1, v7, v8, v0, v8}, Lcom/roder300/kozen/MainActivity;->showImgDesc$default(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;Landroid/widget/ImageView;ILjava/lang/Object;)V

    .line 2080
    invoke-direct {v1}, Lcom/roder300/kozen/MainActivity;->resetDetectionState()V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0

    .line 2082
    :cond_10
    return-void

    .line 2199
    :catch_0
    move-exception v0

    .line 2200
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "\u041e\u0448\u0438\u0431\u043a\u0430 \u043e\u0431\u0440\u0430\u0431\u043e\u0442\u043a\u0438 \u043e\u0431\u043d\u0430\u0440\u0443\u0436\u0435\u043d\u0438\u044f \u043b\u0438\u0446\u0430: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 2201
    const-string v2, "\u041e\u0448\u0438\u0431\u043a\u0430!"

    invoke-virtual {v1, v2}, Lcom/roder300/kozen/MainActivity;->setTextDesc(Ljava/lang/String;)V

    .line 2202
    const-string v2, "Error in face processing"

    move-object v3, v0

    check-cast v3, Ljava/lang/Throwable;

    const-string v4, "FaceDetection"

    invoke-static {v4, v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 2204
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_11
    :goto_7
    return-void
.end method

.method private final onProximityDetected()V
    .locals 1

    .line 639
    new-instance v0, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda1;

    invoke-direct {v0, p0}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda1;-><init>(Lcom/roder300/kozen/MainActivity;)V

    invoke-virtual {p0, v0}, Lcom/roder300/kozen/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 645
    return-void
.end method

.method private static final onProximityDetected$lambda$7(Lcom/roder300/kozen/MainActivity;)V
    .locals 8
    .param p0, "this$0"    # Lcom/roder300/kozen/MainActivity;

    .line 640
    move-object v0, p0

    check-cast v0, Landroid/content/Context;

    iget v1, p0, Lcom/roder300/kozen/MainActivity;->detectionCount:I

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u041a\u0430\u0440\u0442\u0430 \u043e\u0431\u043d\u0430\u0440\u0443\u0436\u0435\u043d\u0430! \u0421\u0440\u0430\u0431\u0430\u0442\u044b\u0432\u0430\u043d\u0438\u0439: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 641
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->showPayScreenPending()V

    const-string v0, "sensor"

    invoke-direct {p0, v0}, Lcom/roder300/kozen/MainActivity;->startCardConfirmPolling(Ljava/lang/String;)V

    .line 642
    const-string v0, "beep"

    const v1, 0x3ecccccd    # 0.4f

    invoke-direct {p0, v0, v1}, Lcom/roder300/kozen/MainActivity;->playSound(Ljava/lang/String;F)V

    .line 643
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->lottieAnimationLoader:Lcom/airbnb/lottie/LottieAnimationView;

    if-nez v0, :cond_0

    const-string v0, "lottieAnimationLoader"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v0, 0x0

    :cond_0
    move-object v2, v0

    const/4 v6, 0x6

    const/4 v7, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const v5, 0x3f19999a    # 0.6f

    move-object v1, p0

    .end local p0    # "this$0":Lcom/roder300/kozen/MainActivity;
    .local v1, "this$0":Lcom/roder300/kozen/MainActivity;
    invoke-static/range {v1 .. v7}, Lcom/roder300/kozen/MainActivity;->startLottieAnimation$default(Lcom/roder300/kozen/MainActivity;Lcom/airbnb/lottie/LottieAnimationView;ZIFILjava/lang/Object;)V

    .line 644
    return-void
.end method

.method private static final onResume$lambda$3(Lcom/roder300/kozen/MainActivity;)V
    .locals 0
    .param p0, "this$0"    # Lcom/roder300/kozen/MainActivity;

    .line 357
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->setupNfc()V

    .line 358
    return-void
.end method

.method private final playSound(Ljava/lang/String;F)V
    .locals 10
    .param p1, "soundName"    # Ljava/lang/String;
    .param p2, "volume"    # F

    .line 1031
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->soundMap:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 1032
    .local v0, "soundId":Ljava/lang/Integer;
    const-string v1, "SoundPool"

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v2

    if-eqz v2, :cond_1

    .line 1033
    iget-object v3, p0, Lcom/roder300/kozen/MainActivity;->soundPool:Landroid/media/SoundPool;

    if-eqz v3, :cond_0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v4

    const/4 v8, 0x0

    const/high16 v9, 0x3f800000    # 1.0f

    const/4 v7, 0x1

    move v6, p2

    move v5, p2

    .end local p2    # "volume":F
    .local v5, "volume":F
    invoke-virtual/range {v3 .. v9}, Landroid/media/SoundPool;->play(IFFIIF)I

    goto :goto_0

    .end local v5    # "volume":F
    .restart local p2    # "volume":F
    :cond_0
    move v5, p2

    .line 1034
    .end local p2    # "volume":F
    .restart local v5    # "volume":F
    :goto_0
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "\u0412\u043e\u0441\u043f\u0440\u043e\u0438\u0437\u0432\u0435\u0434\u0435\u043d\u0438\u0435 \u0437\u0432\u0443\u043a\u0430: "

    invoke-virtual {p2, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {v1, p2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 1032
    .end local v5    # "volume":F
    .restart local p2    # "volume":F
    :cond_1
    move v5, p2

    .line 1036
    .end local p2    # "volume":F
    .restart local v5    # "volume":F
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "\u0417\u0432\u0443\u043a \'"

    invoke-virtual {p2, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string v2, "\' \u043d\u0435 \u043d\u0430\u0439\u0434\u0435\u043d \u0438\u043b\u0438 \u043d\u0435 \u0437\u0430\u0433\u0440\u0443\u0436\u0435\u043d"

    invoke-virtual {p2, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {v1, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1038
    :goto_1
    return-void
.end method

.method static synthetic playSound$default(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;FILjava/lang/Object;)V
    .locals 0

    .line 1030
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_0

    const/high16 p2, 0x3f800000    # 1.0f

    :cond_0
    invoke-direct {p0, p1, p2}, Lcom/roder300/kozen/MainActivity;->playSound(Ljava/lang/String;F)V

    return-void
.end method

.method private final readNfcTag(Landroid/nfc/Tag;)V
    .locals 11
    .param p1, "tag"    # Landroid/nfc/Tag;

    .line 756
    const-string v0, "NFC"

    .line 757
    :try_start_0
    invoke-static {p1}, Landroid/nfc/tech/Ndef;->get(Landroid/nfc/Tag;)Landroid/nfc/tech/Ndef;

    move-result-object v1

    .line 758
    .local v1, "ndef":Landroid/nfc/tech/Ndef;
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Landroid/nfc/tech/Ndef;->connect()V

    .line 760
    :cond_0
    if-eqz v1, :cond_1

    invoke-virtual {v1}, Landroid/nfc/tech/Ndef;->getNdefMessage()Landroid/nfc/NdefMessage;

    move-result-object v2

    goto :goto_0

    :cond_1
    const/4 v2, 0x0

    .line 761
    .local v2, "ndefMessage":Landroid/nfc/NdefMessage;
    :goto_0
    if-eqz v2, :cond_2

    .line 762
    invoke-virtual {v2}, Landroid/nfc/NdefMessage;->getRecords()[Landroid/nfc/NdefRecord;

    move-result-object v3

    .line 763
    .local v3, "records":[Landroid/nfc/NdefRecord;
    invoke-static {v3}, Lkotlin/jvm/internal/ArrayIteratorKt;->iterator([Ljava/lang/Object;)Ljava/util/Iterator;

    move-result-object v4

    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_2

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/nfc/NdefRecord;

    .line 764
    .local v5, "record":Landroid/nfc/NdefRecord;
    invoke-virtual {v5}, Landroid/nfc/NdefRecord;->getPayload()[B

    move-result-object v6

    .local v6, "payload":[B
    new-instance v7, Ljava/lang/String;

    .line 765
    invoke-static {v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    array-length v8, v6

    const/4 v9, 0x3

    sub-int/2addr v8, v9

    sget-object v10, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v7, v6, v9, v8, v10}, Ljava/lang/String;-><init>([BIILjava/nio/charset/Charset;)V

    .line 766
    .local v7, "text":Ljava/lang/String;
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "\u041f\u0440\u043e\u0447\u0438\u0442\u0430\u043d\u043e: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v0, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v6    # "payload":[B
    .end local v7    # "text":Ljava/lang/String;
    goto :goto_1

    .line 770
    .end local v3    # "records":[Landroid/nfc/NdefRecord;
    .end local v5    # "record":Landroid/nfc/NdefRecord;
    :cond_2
    if-eqz v1, :cond_3

    invoke-virtual {v1}, Landroid/nfc/tech/Ndef;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    .line 771
    .end local v1    # "ndef":Landroid/nfc/tech/Ndef;
    .end local v2    # "ndefMessage":Landroid/nfc/NdefMessage;
    :catch_0
    move-exception v1

    .line 772
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "\u041e\u0448\u0438\u0431\u043a\u0430 \u0447\u0442\u0435\u043d\u0438\u044f \u043a\u0430\u0440\u0442\u044b: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 774
    .end local v1    # "e":Ljava/lang/Exception;
    :cond_3
    :goto_2
    return-void
.end method

.method private final registerDevice()V
    .locals 9

    .line 1295
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->collectDeviceData()Lcom/roder300/kozen/DeviceData;

    move-result-object v0

    .line 1296
    .local v0, "deviceData":Lcom/roder300/kozen/DeviceData;
    new-instance v1, Lcom/google/gson/Gson;

    invoke-direct {v1}, Lcom/google/gson/Gson;-><init>()V

    .line 1297
    .local v1, "gson":Lcom/google/gson/Gson;
    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 1299
    .local v2, "json":Ljava/lang/String;
    new-instance v3, Lokhttp3/OkHttpClient$Builder;

    invoke-direct {v3}, Lokhttp3/OkHttpClient$Builder;-><init>()V

    .line 1300
    sget-object v4, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v5, 0x1e

    invoke-virtual {v3, v5, v6, v4}, Lokhttp3/OkHttpClient$Builder;->connectTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 1301
    sget-object v4, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v3, v5, v6, v4}, Lokhttp3/OkHttpClient$Builder;->readTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 1302
    invoke-virtual {v3}, Lokhttp3/OkHttpClient$Builder;->build()Lokhttp3/OkHttpClient;

    move-result-object v3

    .line 1299
    nop

    .line 1304
    .local v3, "client":Lokhttp3/OkHttpClient;
    sget-object v4, Lokhttp3/MediaType;->Companion:Lokhttp3/MediaType$Companion;

    const-string v5, "application/json; charset=utf-8"

    invoke-virtual {v4, v5}, Lokhttp3/MediaType$Companion;->get(Ljava/lang/String;)Lokhttp3/MediaType;

    move-result-object v4

    .line 1305
    .local v4, "mediaType":Lokhttp3/MediaType;
    sget-object v5, Lokhttp3/RequestBody;->Companion:Lokhttp3/RequestBody$Companion;

    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v5, v2, v4}, Lokhttp3/RequestBody$Companion;->create(Ljava/lang/String;Lokhttp3/MediaType;)Lokhttp3/RequestBody;

    move-result-object v5

    .line 1307
    .local v5, "body":Lokhttp3/RequestBody;
    new-instance v6, Lokhttp3/Request$Builder;

    invoke-direct {v6}, Lokhttp3/Request$Builder;-><init>()V

    .line 1308
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getServerUrl()Ljava/lang/String;

    move-result-object v7

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v7, "/api/register_device"

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Lokhttp3/Request$Builder;->url(Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v6

    .line 1309
    invoke-virtual {v6, v5}, Lokhttp3/Request$Builder;->post(Lokhttp3/RequestBody;)Lokhttp3/Request$Builder;

    move-result-object v6

    .line 1310
    const-string v7, "Content-Type"

    const-string v8, "application/json"

    invoke-virtual {v6, v7, v8}, Lokhttp3/Request$Builder;->addHeader(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v6

    .line 1311
    invoke-virtual {v6}, Lokhttp3/Request$Builder;->build()Lokhttp3/Request;

    move-result-object v6

    .line 1307
    nop

    .line 1313
    .local v6, "request":Lokhttp3/Request;
    invoke-virtual {v3, v6}, Lokhttp3/OkHttpClient;->newCall(Lokhttp3/Request;)Lokhttp3/Call;

    move-result-object v7

    new-instance v8, Lcom/roder300/kozen/MainActivity$registerDevice$1;

    invoke-direct {v8, p0}, Lcom/roder300/kozen/MainActivity$registerDevice$1;-><init>(Lcom/roder300/kozen/MainActivity;)V

    check-cast v8, Lokhttp3/Callback;

    invoke-interface {v7, v8}, Lokhttp3/Call;->enqueue(Lokhttp3/Callback;)V

    .line 1362
    return-void
.end method

.method private final resetDetectionState()V
    .locals 2

    .line 1835
    const/4 v0, 0x0

    iput v0, p0, Lcom/roder300/kozen/MainActivity;->faceDetectionCount:I

    .line 1836
    const/4 v1, -0x1

    iput v1, p0, Lcom/roder300/kozen/MainActivity;->currentFaceId:I

    .line 1837
    iput-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->validFaceDetected:Z

    .line 1838
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/roder300/kozen/MainActivity;->currentFace:Landroid/hardware/Camera$Face;

    .line 1840
    const-string v0, "\u0421\u043e\u0441\u0442\u043e\u044f\u043d\u0438\u0435 \u043e\u0431\u043d\u0430\u0440\u0443\u0436\u0435\u043d\u0438\u044f \u0441\u0431\u0440\u043e\u0448\u0435\u043d\u043e"

    invoke-direct {p0, v0}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 1841
    return-void
.end method

.method private final setCameraDisplayOrientation(I)V
    .locals 7
    .param p1, "cameraId"    # I

    .line 1901
    new-instance v0, Landroid/hardware/Camera$CameraInfo;

    invoke-direct {v0}, Landroid/hardware/Camera$CameraInfo;-><init>()V

    .line 1902
    .local v0, "info":Landroid/hardware/Camera$CameraInfo;
    invoke-static {p1, v0}, Landroid/hardware/Camera;->getCameraInfo(ILandroid/hardware/Camera$CameraInfo;)V

    .line 1904
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getWindowManager()Landroid/view/WindowManager;

    move-result-object v1

    invoke-interface {v1}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/Display;->getRotation()I

    move-result v1

    .line 1905
    .local v1, "rotation":I
    const/4 v2, 0x1

    const/4 v3, 0x0

    if-eqz v1, :cond_1

    const/4 v4, 0x2

    if-ne v1, v4, :cond_0

    goto :goto_0

    :cond_0
    const/4 v4, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v4, 0x1

    :goto_1
    iput-boolean v4, p0, Lcom/roder300/kozen/MainActivity;->isPortraitMode:Z

    .line 1907
    packed-switch v1, :pswitch_data_0

    .line 1912
    goto :goto_2

    .line 1911
    :pswitch_0
    const/16 v3, 0x10e

    goto :goto_2

    .line 1910
    :pswitch_1
    const/16 v3, 0xb4

    goto :goto_2

    .line 1909
    :pswitch_2
    const/16 v3, 0x5a

    goto :goto_2

    .line 1908
    :pswitch_3
    nop

    .line 1907
    :goto_2
    nop

    .line 1915
    .local v3, "degrees":I
    const/4 v4, 0x0

    .line 1916
    .local v4, "result":I
    iget v5, v0, Landroid/hardware/Camera$CameraInfo;->facing:I

    if-ne v5, v2, :cond_2

    .line 1917
    iget v2, v0, Landroid/hardware/Camera$CameraInfo;->orientation:I

    add-int/2addr v2, v3

    rem-int/lit16 v2, v2, 0x168

    .line 1918
    .end local v4    # "result":I
    .local v2, "result":I
    rsub-int v4, v2, 0x168

    rem-int/lit16 v4, v4, 0x168

    .end local v2    # "result":I
    .restart local v4    # "result":I
    goto :goto_3

    .line 1920
    :cond_2
    iget v2, v0, Landroid/hardware/Camera$CameraInfo;->orientation:I

    sub-int/2addr v2, v3

    add-int/lit16 v2, v2, 0x168

    rem-int/lit16 v4, v2, 0x168

    .line 1923
    :goto_3
    iput v4, p0, Lcom/roder300/kozen/MainActivity;->cameraDisplayOrientation:I

    .line 1924
    iget-object v2, p0, Lcom/roder300/kozen/MainActivity;->camera:Landroid/hardware/Camera;

    if-eqz v2, :cond_3

    invoke-virtual {v2, v4}, Landroid/hardware/Camera;->setDisplayOrientation(I)V

    .line 1926
    :cond_3
    iget-boolean v2, p0, Lcom/roder300/kozen/MainActivity;->isPortraitMode:Z

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "\u0423\u0441\u0442\u0430\u043d\u043e\u0432\u043b\u0435\u043d \u043f\u043e\u0432\u043e\u0440\u043e\u0442 \u043a\u0430\u043c\u0435\u0440\u044b: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " \u0433\u0440\u0430\u0434\u0443\u0441\u043e\u0432, \u041f\u043e\u0440\u0442\u0440\u0435\u0442\u043d\u044b\u0439 \u0440\u0435\u0436\u0438\u043c: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 1927
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private final setCutoutModeSafe()V
    .locals 10

    .line 1551
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1c

    if-lt v0, v1, :cond_0

    .line 1552
    nop

    .line 1553
    :try_start_0
    const-string v0, "android.view.WindowManager$LayoutParams"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 1554
    .local v0, "layoutParamsClass":Ljava/lang/Class;
    const-string v1, "layoutInDisplayCutoutMode"

    invoke-virtual {v0, v1}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    .line 1555
    .local v1, "cutoutModeField":Ljava/lang/reflect/Field;
    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result v2

    .line 1557
    .local v2, "shortEdgesValue":I
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v3

    .line 1558
    .local v3, "params":Landroid/view/WindowManager$LayoutParams;
    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    .line 1559
    const-string v5, "setLayoutInDisplayCutoutMode"

    .line 1560
    const/4 v6, 0x1

    new-array v7, v6, [Ljava/lang/Class;

    sget-object v8, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    const/4 v9, 0x0

    aput-object v8, v7, v9

    .line 1558
    invoke-virtual {v4, v5, v7}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    .line 1562
    .local v4, "setLayoutInDisplayCutoutModeMethod":Ljava/lang/reflect/Method;
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    new-array v6, v6, [Ljava/lang/Object;

    aput-object v5, v6, v9

    invoke-virtual {v4, v3, v6}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 1563
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object v5

    invoke-virtual {v5, v3}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "layoutParamsClass":Ljava/lang/Class;
    .end local v1    # "cutoutModeField":Ljava/lang/reflect/Field;
    .end local v2    # "shortEdgesValue":I
    .end local v3    # "params":Landroid/view/WindowManager$LayoutParams;
    .end local v4    # "setLayoutInDisplayCutoutModeMethod":Ljava/lang/reflect/Method;
    goto :goto_0

    .line 1564
    :catch_0
    move-exception v0

    .line 1566
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Cutout mode not available: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "FullScreen"

    invoke-static {v2, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 1569
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    :goto_0
    return-void
.end method

.method private final setFullScreenMode()V
    .locals 3

    .line 1507
    nop

    .line 1508
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    .line 1509
    nop

    .line 1508
    const/16 v1, 0x1706

    invoke-virtual {v0, v1}, Landroid/view/View;->setSystemUiVisibility(I)V

    .line 1525
    nop

    .line 1526
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/Window;->setStatusBarColor(I)V

    .line 1527
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/Window;->setNavigationBarColor(I)V

    .line 1528
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/high16 v1, -0x80000000

    invoke-virtual {v0, v1}, Landroid/view/Window;->addFlags(I)V

    .line 1532
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1c

    if-lt v0, v1, :cond_0

    .line 1533
    nop

    .line 1534
    :try_start_0
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    .line 1536
    .local v0, "params":Landroid/view/WindowManager$LayoutParams;
    const-class v1, Landroid/view/WindowManager$LayoutParams;

    const-string v2, "layoutInDisplayCutoutMode"

    invoke-virtual {v1, v2}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    .line 1537
    .local v1, "field":Ljava/lang/reflect/Field;
    const/4 v2, 0x1

    invoke-virtual {v1, v0, v2}, Ljava/lang/reflect/Field;->setInt(Ljava/lang/Object;I)V

    .line 1538
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object v2

    invoke-virtual {v2, v0}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "params":Landroid/view/WindowManager$LayoutParams;
    .end local v1    # "field":Ljava/lang/reflect/Field;
    goto :goto_0

    .line 1539
    :catch_0
    move-exception v0

    .line 1541
    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "FullScreen"

    const-string v2, "Cutout mode not supported on this device"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1546
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    :goto_0
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->setCutoutModeSafe()V

    .line 1547
    return-void
.end method

.method private final setupCamera()V
    .locals 8

    .line 1867
    nop

    .line 1868
    const/4 v0, 0x0

    :try_start_0
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->findFrontCamera()I

    move-result v1

    .line 1869
    .local v1, "cameraId":I
    const/4 v2, -0x1

    if-ne v1, v2, :cond_0

    .line 1870
    const-string v2, "\u041e\u0448\u0438\u0431\u043a\u0430: \u0424\u0440\u043e\u043d\u0442\u0430\u043b\u044c\u043d\u0430\u044f \u043a\u0430\u043c\u0435\u0440\u0430 \u043d\u0435 \u043d\u0430\u0439\u0434\u0435\u043d\u0430"

    invoke-direct {p0, v2}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 1871
    move-object v2, p0

    check-cast v2, Landroid/content/Context;

    const-string v3, "\u0424\u0440\u043e\u043d\u0442\u0430\u043b\u044c\u043d\u0430\u044f \u043a\u0430\u043c\u0435\u0440\u0430 \u043d\u0435 \u043d\u0430\u0439\u0434\u0435\u043d\u0430"

    check-cast v3, Ljava/lang/CharSequence;

    invoke-static {v2, v3, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v2

    invoke-virtual {v2}, Landroid/widget/Toast;->show()V

    .line 1872
    return-void

    .line 1875
    :cond_0
    invoke-static {v1}, Landroid/hardware/Camera;->open(I)Landroid/hardware/Camera;

    move-result-object v2

    iput-object v2, p0, Lcom/roder300/kozen/MainActivity;->camera:Landroid/hardware/Camera;

    .line 1876
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u041a\u0430\u043c\u0435\u0440\u0430 \u043e\u0442\u043a\u0440\u044b\u0442\u0430 (ID: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 1879
    invoke-direct {p0, v1}, Lcom/roder300/kozen/MainActivity;->setCameraDisplayOrientation(I)V

    .line 1882
    iget-object v2, p0, Lcom/roder300/kozen/MainActivity;->surfaceView:Landroid/view/SurfaceView;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string v3, "surfaceView"

    const/4 v4, 0x0

    if-nez v2, :cond_1

    :try_start_1
    invoke-static {v3}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v2, v4

    :cond_1
    invoke-virtual {v2}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v2

    .line 1883
    .local v2, "holder":Landroid/view/SurfaceHolder;
    move-object v5, p0

    check-cast v5, Landroid/view/SurfaceHolder$Callback;

    invoke-interface {v2, v5}, Landroid/view/SurfaceHolder;->addCallback(Landroid/view/SurfaceHolder$Callback;)V

    .line 1884
    const/4 v5, 0x3

    invoke-interface {v2, v5}, Landroid/view/SurfaceHolder;->setType(I)V

    .line 1886
    iget-object v5, p0, Lcom/roder300/kozen/MainActivity;->cameraContainer:Landroid/widget/FrameLayout;
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    const-string v6, "cameraContainer"

    if-nez v5, :cond_2

    :try_start_2
    invoke-static {v6}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v5, v4

    :cond_2
    invoke-virtual {v5}, Landroid/widget/FrameLayout;->removeAllViews()V

    .line 1887
    iget-object v5, p0, Lcom/roder300/kozen/MainActivity;->cameraContainer:Landroid/widget/FrameLayout;

    if-nez v5, :cond_3

    invoke-static {v6}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v5, v4

    :cond_3
    iget-object v7, p0, Lcom/roder300/kozen/MainActivity;->surfaceView:Landroid/view/SurfaceView;

    if-nez v7, :cond_4

    invoke-static {v3}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v7, v4

    :cond_4
    check-cast v7, Landroid/view/View;

    invoke-virtual {v5, v7}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    .line 1888
    iget-object v3, p0, Lcom/roder300/kozen/MainActivity;->cameraContainer:Landroid/widget/FrameLayout;

    if-nez v3, :cond_5

    invoke-static {v6}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_0

    :cond_5
    move-object v4, v3

    :goto_0
    invoke-virtual {v4, v0}, Landroid/widget/FrameLayout;->setVisibility(I)V
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    .end local v1    # "cameraId":I
    .end local v2    # "holder":Landroid/view/SurfaceHolder;
    goto :goto_1

    .line 1894
    :catch_0
    move-exception v0

    .line 1895
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u041d\u0435\u0438\u0437\u0432\u0435\u0441\u0442\u043d\u0430\u044f \u043e\u0448\u0438\u0431\u043a\u0430: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 1896
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->releaseCamera()V

    goto :goto_1

    .line 1890
    .end local v0    # "e":Ljava/lang/Exception;
    :catch_1
    move-exception v1

    .line 1891
    .local v1, "e":Ljava/lang/RuntimeException;
    invoke-virtual {v1}, Ljava/lang/RuntimeException;->getMessage()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "\u041e\u0448\u0438\u0431\u043a\u0430 \u043e\u0442\u043a\u0440\u044b\u0442\u0438\u044f \u043a\u0430\u043c\u0435\u0440\u044b: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 1892
    move-object v2, p0

    check-cast v2, Landroid/content/Context;

    const-string v3, "\u041d\u0435 \u0443\u0434\u0430\u043b\u043e\u0441\u044c \u043e\u0442\u043a\u0440\u044b\u0442\u044c \u043a\u0430\u043c\u0435\u0440\u0443"

    check-cast v3, Ljava/lang/CharSequence;

    invoke-static {v2, v3, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 1893
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->releaseCamera()V

    .line 1898
    .end local v1    # "e":Ljava/lang/RuntimeException;
    :goto_1
    return-void
.end method

.method private final setupNfc()V
    .locals 3

    .line 648
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->nfcAdapter:Landroid/nfc/NfcAdapter;

    if-nez v0, :cond_0

    .line 649
    move-object v0, p0

    check-cast v0, Landroid/content/Context;

    const-string v1, "NFC \u043d\u0435 \u043f\u043e\u0434\u0434\u0435\u0440\u0436\u0438\u0432\u0430\u0435\u0442\u0441\u044f \u043d\u0430 \u044d\u0442\u043e\u043c \u0443\u0441\u0442\u0440\u043e\u0439\u0441\u0442\u0432\u0435 :("

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 650
    return-void

    .line 653
    :cond_0
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->nfcAdapter:Landroid/nfc/NfcAdapter;

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v0}, Landroid/nfc/NfcAdapter;->isEnabled()Z

    move-result v0

    const/4 v1, 0x1

    if-nez v0, :cond_1

    .line 654
    move-object v0, p0

    check-cast v0, Landroid/content/Context;

    const-string v2, "NFC \u043e\u0442\u043a\u043b\u044e\u0447\u0435\u043d. \u0412\u043a\u043b\u044e\u0447\u0438\u0442\u0435 NFC \u0432 \u043d\u0430\u0441\u0442\u0440\u043e\u0439\u043a\u0430\u0445"

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v0, v2, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 655
    return-void

    .line 658
    :cond_1
    iput-boolean v1, p0, Lcom/roder300/kozen/MainActivity;->isNfcEnabled:Z

    .line 659
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->startNfcListening()V

    .line 660
    return-void
.end method

.method private final setupPaymentButtons()V
    .locals 11

    .line 1054
    sget v0, Lcom/roder300/kozen/R$id;->buttonQr:I

    invoke-virtual {p0, v0}, Lcom/roder300/kozen/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    .line 1055
    .local v0, "buttonQr":Landroid/widget/LinearLayout;
    sget v1, Lcom/roder300/kozen/R$id;->buttonFace:I

    invoke-virtual {p0, v1}, Lcom/roder300/kozen/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/LinearLayout;

    .line 1056
    .local v1, "buttonFace":Landroid/widget/LinearLayout;
    sget v2, Lcom/roder300/kozen/R$id;->animatedRounds:I

    invoke-virtual {p0, v2}, Lcom/roder300/kozen/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/FrameLayout;

    .line 1058
    .local v2, "animatedRounds":Landroid/widget/FrameLayout;
    new-instance v3, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda0;

    invoke-direct {v3, p0}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda0;-><init>(Lcom/roder300/kozen/MainActivity;)V

    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 1064
    new-instance v3, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda11;

    invoke-direct {v3, p0}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda11;-><init>(Lcom/roder300/kozen/MainActivity;)V

    invoke-virtual {v1, v3}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 1070
    new-instance v3, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda22;

    invoke-direct {v3, p0}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda22;-><init>(Lcom/roder300/kozen/MainActivity;)V

    invoke-virtual {v2, v3}, Landroid/widget/FrameLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 1080
    const/4 v3, 0x2

    new-array v3, v3, [Landroid/widget/LinearLayout;

    const/4 v4, 0x0

    aput-object v0, v3, v4

    const/4 v4, 0x1

    aput-object v1, v3, v4

    invoke-static {v3}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v3

    .line 1081
    .local v3, "buttons":Ljava/util/List;
    move-object v4, v3

    check-cast v4, Ljava/lang/Iterable;

    .local v4, "$this$forEach\\1":Ljava/lang/Iterable;
    const/4 v5, 0x0

    .line 2288
    .local v5, "$i$f$forEach\\1\\1081":I
    invoke-interface {v4}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_0
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_0

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    .local v7, "element\\1":Ljava/lang/Object;
    move-object v8, v7

    check-cast v8, Landroid/widget/LinearLayout;

    .local v8, "button\\2":Landroid/widget/LinearLayout;
    const/4 v9, 0x0

    .line 1082
    .local v9, "$i$a$-forEach-MainActivity$setupPaymentButtons$4\\2\\2288\\0":I
    new-instance v10, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda26;

    invoke-direct {v10}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda26;-><init>()V

    invoke-virtual {v8, v10}, Landroid/widget/LinearLayout;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 1089
    nop

    .line 2288
    .end local v8    # "button\\2":Landroid/widget/LinearLayout;
    .end local v9    # "$i$a$-forEach-MainActivity$setupPaymentButtons$4\\2\\2288\\0":I
    nop

    .end local v7    # "element\\1":Ljava/lang/Object;
    goto :goto_0

    .line 2289
    :cond_0
    nop

    .line 1090
    .end local v4    # "$this$forEach\\1":Ljava/lang/Iterable;
    .end local v5    # "$i$f$forEach\\1\\1081":I
    return-void
.end method

.method private static final setupPaymentButtons$lambda$18(Lcom/roder300/kozen/MainActivity;Landroid/view/View;)V
    .locals 0
    .param p0, "this$0"    # Lcom/roder300/kozen/MainActivity;
    .param p1, "it"    # Landroid/view/View;

    .line 1059
    return-void
.end method

.method private static final setupPaymentButtons$lambda$19(Lcom/roder300/kozen/MainActivity;Landroid/view/View;)V
    .locals 3
    .param p0, "this$0"    # Lcom/roder300/kozen/MainActivity;
    .param p1, "it"    # Landroid/view/View;

    .line 1065
    move-object v0, p0

    check-cast v0, Landroid/content/Context;

    const-string v1, "\u041e\u043f\u043b\u0430\u0442\u0430 \u0443\u043b\u044b\u0431\u043a\u043e\u0439! \ud83d\ude0a"

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 1067
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->showBioScreen()V

    .line 1068
    return-void
.end method

.method private static final setupPaymentButtons$lambda$20(Lcom/roder300/kozen/MainActivity;Landroid/view/View;)V
    .locals 3
    .param p0, "this$0"    # Lcom/roder300/kozen/MainActivity;
    .param p1, "it"    # Landroid/view/View;

    .line 1071
    move-object v0, p0

    check-cast v0, Landroid/content/Context;

    const-string v1, "\u0441\u0440\u0430\u043a\u0430"

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 1072
    nop

    .line 1073
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->showPayScreenPending()V

    const-string v0, "sensor"

    invoke-direct {p0, v0}, Lcom/roder300/kozen/MainActivity;->startCardConfirmPolling(Ljava/lang/String;)V

    .line 1074
    const-string v0, "beep"

    const v1, 0x3ecccccd    # 0.4f

    invoke-direct {p0, v0, v1}, Lcom/roder300/kozen/MainActivity;->playSound(Ljava/lang/String;F)V

    .line 1077
    return-void
.end method

.method private static final setupPaymentButtons$lambda$22$lambda$21(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 1
    .param p0, "v"    # Landroid/view/View;
    .param p1, "event"    # Landroid/view/MotionEvent;

    .line 1083
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    :pswitch_0
    goto :goto_0

    .line 1085
    :pswitch_1
    const/high16 v0, 0x3f800000    # 1.0f

    invoke-virtual {p0, v0}, Landroid/view/View;->setAlpha(F)V

    goto :goto_0

    .line 1084
    :pswitch_2
    const v0, 0x3f333333    # 0.7f

    invoke-virtual {p0, v0}, Landroid/view/View;->setAlpha(F)V

    .line 1087
    :goto_0
    const/4 v0, 0x0

    return v0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method private final setupSoundPool()V
    .locals 3

    .line 989
    nop

    .line 990
    new-instance v0, Landroid/media/AudioAttributes$Builder;

    invoke-direct {v0}, Landroid/media/AudioAttributes$Builder;-><init>()V

    .line 991
    const/16 v1, 0xe

    invoke-virtual {v0, v1}, Landroid/media/AudioAttributes$Builder;->setUsage(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v0

    .line 992
    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/media/AudioAttributes$Builder;->setContentType(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v0

    .line 993
    invoke-virtual {v0}, Landroid/media/AudioAttributes$Builder;->build()Landroid/media/AudioAttributes;

    move-result-object v0

    .line 990
    nop

    .line 995
    .local v0, "audioAttributes":Landroid/media/AudioAttributes;
    new-instance v1, Landroid/media/SoundPool$Builder;

    invoke-direct {v1}, Landroid/media/SoundPool$Builder;-><init>()V

    .line 996
    const/4 v2, 0x5

    invoke-virtual {v1, v2}, Landroid/media/SoundPool$Builder;->setMaxStreams(I)Landroid/media/SoundPool$Builder;

    move-result-object v1

    .line 997
    invoke-virtual {v1, v0}, Landroid/media/SoundPool$Builder;->setAudioAttributes(Landroid/media/AudioAttributes;)Landroid/media/SoundPool$Builder;

    move-result-object v1

    .line 998
    invoke-virtual {v1}, Landroid/media/SoundPool$Builder;->build()Landroid/media/SoundPool;

    move-result-object v1

    .line 995
    iput-object v1, p0, Lcom/roder300/kozen/MainActivity;->soundPool:Landroid/media/SoundPool;

    .line 1004
    .end local v0    # "audioAttributes":Landroid/media/AudioAttributes;
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->soundPool:Landroid/media/SoundPool;

    if-eqz v0, :cond_0

    new-instance v1, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda6;

    invoke-direct {v1}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda6;-><init>()V

    invoke-virtual {v0, v1}, Landroid/media/SoundPool;->setOnLoadCompleteListener(Landroid/media/SoundPool$OnLoadCompleteListener;)V

    .line 1011
    :cond_0
    return-void
.end method

.method private static final setupSoundPool$lambda$16(Landroid/media/SoundPool;II)V
    .locals 2
    .param p1, "sampleId"    # I
    .param p2, "status"    # I

    .line 1005
    const-string p0, "SoundPool"

    if-nez p2, :cond_0

    .line 1006
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\u0417\u0432\u0443\u043a \u0437\u0430\u0433\u0440\u0443\u0436\u0435\u043d: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 1008
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\u041e\u0448\u0438\u0431\u043a\u0430 \u0437\u0430\u0433\u0440\u0443\u0437\u043a\u0438 \u0437\u0432\u0443\u043a\u0430: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1010
    :goto_0
    return-void
.end method

.method private final setupVideoPlayer()V
    .locals 6

    .line 1579
    nop

    .line 1581
    :try_start_0
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getPackageName()Ljava/lang/String;

    move-result-object v0

    sget v1, Lcom/roder300/kozen/R$raw;->ne:I

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "android.resource://"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "/"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1582
    .local v0, "videoPath":Ljava/lang/String;
    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    .line 1583
    .local v1, "videoUri":Landroid/net/Uri;
    iget-object v2, p0, Lcom/roder300/kozen/MainActivity;->videoBackground:Landroid/widget/VideoView;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string v3, "videoBackground"

    const/4 v4, 0x0

    if-nez v2, :cond_0

    :try_start_1
    invoke-static {v3}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v2, v4

    :cond_0
    invoke-virtual {v2, v1}, Landroid/widget/VideoView;->setVideoURI(Landroid/net/Uri;)V

    .line 1586
    iget-object v2, p0, Lcom/roder300/kozen/MainActivity;->videoBackground:Landroid/widget/VideoView;

    if-nez v2, :cond_1

    invoke-static {v3}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v2, v4

    :cond_1
    invoke-virtual {v2, v4}, Landroid/widget/VideoView;->setMediaController(Landroid/widget/MediaController;)V

    .line 1589
    iget-object v2, p0, Lcom/roder300/kozen/MainActivity;->videoBackground:Landroid/widget/VideoView;

    if-nez v2, :cond_2

    invoke-static {v3}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v2, v4

    :cond_2
    new-instance v5, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda21;

    invoke-direct {v5, p0}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda21;-><init>(Lcom/roder300/kozen/MainActivity;)V

    invoke-virtual {v2, v5}, Landroid/widget/VideoView;->setOnPreparedListener(Landroid/media/MediaPlayer$OnPreparedListener;)V

    .line 1630
    iget-object v2, p0, Lcom/roder300/kozen/MainActivity;->videoBackground:Landroid/widget/VideoView;

    if-nez v2, :cond_3

    invoke-static {v3}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v2, v4

    :cond_3
    new-instance v5, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda23;

    invoke-direct {v5}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda23;-><init>()V

    invoke-virtual {v2, v5}, Landroid/widget/VideoView;->setOnErrorListener(Landroid/media/MediaPlayer$OnErrorListener;)V

    .line 1636
    iget-object v2, p0, Lcom/roder300/kozen/MainActivity;->videoBackground:Landroid/widget/VideoView;

    if-nez v2, :cond_4

    invoke-static {v3}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_0

    :cond_4
    move-object v4, v2

    :goto_0
    new-instance v2, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda24;

    invoke-direct {v2, p0}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda24;-><init>(Lcom/roder300/kozen/MainActivity;)V

    invoke-virtual {v4, v2}, Landroid/widget/VideoView;->setOnCompletionListener(Landroid/media/MediaPlayer$OnCompletionListener;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    .end local v0    # "videoPath":Ljava/lang/String;
    .end local v1    # "videoUri":Landroid/net/Uri;
    goto :goto_1

    .line 1642
    :catch_0
    move-exception v0

    .line 1643
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u041e\u0448\u0438\u0431\u043a\u0430 \u043d\u0430\u0441\u0442\u0440\u043e\u0439\u043a\u0438 \u0432\u0438\u0434\u0435\u043e: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "VideoSetup"

    invoke-static {v2, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1645
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_1
    return-void
.end method

.method private static final setupVideoPlayer$lambda$37(Lcom/roder300/kozen/MainActivity;Landroid/media/MediaPlayer;)V
    .locals 12
    .param p0, "this$0"    # Lcom/roder300/kozen/MainActivity;
    .param p1, "mediaPlayer"    # Landroid/media/MediaPlayer;

    .line 1590
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isVideoPrepared:Z

    .line 1593
    invoke-virtual {p1, v0}, Landroid/media/MediaPlayer;->setLooping(Z)V

    .line 1596
    const/4 v0, 0x2

    invoke-virtual {p1, v0}, Landroid/media/MediaPlayer;->setVideoScalingMode(I)V

    .line 1599
    invoke-virtual {p1}, Landroid/media/MediaPlayer;->getVideoWidth()I

    move-result v1

    .line 1600
    .local v1, "videoWidth":I
    invoke-virtual {p1}, Landroid/media/MediaPlayer;->getVideoHeight()I

    move-result v2

    .line 1601
    .local v2, "videoHeight":I
    iget-object v3, p0, Lcom/roder300/kozen/MainActivity;->videoBackground:Landroid/widget/VideoView;

    const/4 v4, 0x0

    const-string v5, "videoBackground"

    if-nez v3, :cond_0

    invoke-static {v5}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v3, v4

    :cond_0
    invoke-virtual {v3}, Landroid/widget/VideoView;->getWidth()I

    move-result v3

    .line 1602
    .local v3, "viewWidth":I
    iget-object v6, p0, Lcom/roder300/kozen/MainActivity;->videoBackground:Landroid/widget/VideoView;

    if-nez v6, :cond_1

    invoke-static {v5}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v6, v4

    :cond_1
    invoke-virtual {v6}, Landroid/widget/VideoView;->getHeight()I

    move-result v6

    .line 1604
    .local v6, "viewHeight":I
    if-lez v1, :cond_9

    if-lez v2, :cond_9

    if-lez v3, :cond_9

    if-lez v6, :cond_9

    .line 1605
    int-to-float v7, v1

    int-to-float v8, v2

    div-float/2addr v7, v8

    .line 1606
    .local v7, "videoRatio":F
    int-to-float v8, v3

    int-to-float v9, v6

    div-float/2addr v8, v9

    .line 1608
    .local v8, "viewRatio":F
    cmpl-float v9, v7, v8

    if-lez v9, :cond_5

    .line 1610
    int-to-float v9, v6

    mul-float v9, v9, v7

    float-to-int v9, v9

    .line 1611
    .local v9, "newWidth":I
    iget-object v10, p0, Lcom/roder300/kozen/MainActivity;->videoBackground:Landroid/widget/VideoView;

    if-nez v10, :cond_2

    invoke-static {v5}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v10, v4

    :cond_2
    invoke-virtual {v10}, Landroid/widget/VideoView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v10

    iput v9, v10, Landroid/view/ViewGroup$LayoutParams;->width:I

    .line 1612
    iget-object v10, p0, Lcom/roder300/kozen/MainActivity;->videoBackground:Landroid/widget/VideoView;

    if-nez v10, :cond_3

    invoke-static {v5}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v10, v4

    :cond_3
    invoke-virtual {v10}, Landroid/widget/VideoView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v10

    iput v6, v10, Landroid/view/ViewGroup$LayoutParams;->height:I

    .line 1613
    iget-object v10, p0, Lcom/roder300/kozen/MainActivity;->videoBackground:Landroid/widget/VideoView;

    if-nez v10, :cond_4

    invoke-static {v5}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v10, v4

    :cond_4
    sub-int v11, v3, v9

    div-int/2addr v11, v0

    int-to-float v0, v11

    invoke-virtual {v10, v0}, Landroid/widget/VideoView;->setX(F)V

    .end local v9    # "newWidth":I
    goto :goto_0

    .line 1616
    :cond_5
    int-to-float v9, v3

    div-float/2addr v9, v7

    float-to-int v9, v9

    .line 1617
    .local v9, "newHeight":I
    iget-object v10, p0, Lcom/roder300/kozen/MainActivity;->videoBackground:Landroid/widget/VideoView;

    if-nez v10, :cond_6

    invoke-static {v5}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v10, v4

    :cond_6
    invoke-virtual {v10}, Landroid/widget/VideoView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v10

    iput v3, v10, Landroid/view/ViewGroup$LayoutParams;->width:I

    .line 1618
    iget-object v10, p0, Lcom/roder300/kozen/MainActivity;->videoBackground:Landroid/widget/VideoView;

    if-nez v10, :cond_7

    invoke-static {v5}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v10, v4

    :cond_7
    invoke-virtual {v10}, Landroid/widget/VideoView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v10

    iput v9, v10, Landroid/view/ViewGroup$LayoutParams;->height:I

    .line 1619
    iget-object v10, p0, Lcom/roder300/kozen/MainActivity;->videoBackground:Landroid/widget/VideoView;

    if-nez v10, :cond_8

    invoke-static {v5}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v10, v4

    :cond_8
    sub-int v11, v6, v9

    div-int/2addr v11, v0

    int-to-float v0, v11

    invoke-virtual {v10, v0}, Landroid/widget/VideoView;->setY(F)V

    .line 1624
    .end local v7    # "videoRatio":F
    .end local v8    # "viewRatio":F
    .end local v9    # "newHeight":I
    :cond_9
    :goto_0
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->currentScreen:Ljava/lang/String;

    const-string v7, "pay"

    invoke-static {v0, v7}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_b

    .line 1625
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->videoBackground:Landroid/widget/VideoView;

    if-nez v0, :cond_a

    invoke-static {v5}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_1

    :cond_a
    move-object v4, v0

    :goto_1
    invoke-virtual {v4}, Landroid/widget/VideoView;->start()V

    .line 1627
    :cond_b
    return-void
.end method

.method private static final setupVideoPlayer$lambda$38(Landroid/media/MediaPlayer;II)Z
    .locals 2
    .param p0, "mp"    # Landroid/media/MediaPlayer;
    .param p1, "what"    # I
    .param p2, "extra"    # I

    .line 1631
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\u041e\u0448\u0438\u0431\u043a\u0430 \u0432\u0438\u0434\u0435\u043e: what="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", extra="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "VideoError"

    invoke-static {v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1632
    const/4 v0, 0x1

    return v0
.end method

.method private static final setupVideoPlayer$lambda$39(Lcom/roder300/kozen/MainActivity;Landroid/media/MediaPlayer;)V
    .locals 2
    .param p0, "this$0"    # Lcom/roder300/kozen/MainActivity;
    .param p1, "it"    # Landroid/media/MediaPlayer;

    .line 1637
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->currentScreen:Ljava/lang/String;

    const-string v1, "pay"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1638
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->videoBackground:Landroid/widget/VideoView;

    if-nez v0, :cond_0

    const-string v0, "videoBackground"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v0, 0x0

    :cond_0
    invoke-virtual {v0}, Landroid/widget/VideoView;->start()V

    .line 1640
    :cond_1
    return-void
.end method

.method private final showBioScreen()V
    .locals 4

    .line 1161
    const/4 v0, 0x2

    const-string v1, "faceRecognition"

    const/4 v2, 0x0

    invoke-static {p0, v1, v2, v0, v2}, Lcom/roder300/kozen/MainActivity;->showScreen$default(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;Ljava/lang/Boolean;ILjava/lang/Object;)V

    .line 1162
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->faceRecognitionPrepare:Landroid/widget/FrameLayout;

    if-nez v0, :cond_0

    const-string v0, "faceRecognitionPrepare"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v0, v2

    :cond_0
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setVisibility(I)V

    .line 1163
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->faceRecognitionInView:Landroid/widget/FrameLayout;

    if-nez v0, :cond_1

    const-string v0, "faceRecognitionInView"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v0, v2

    :cond_1
    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setVisibility(I)V

    .line 1164
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->videoBackground:Landroid/widget/VideoView;

    if-nez v0, :cond_2

    const-string v0, "videoBackground"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    move-object v2, v0

    :goto_0
    invoke-virtual {v2, v1}, Landroid/widget/VideoView;->setVisibility(I)V

    .line 1166
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v1, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda32;

    invoke-direct {v1, p0}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda32;-><init>(Lcom/roder300/kozen/MainActivity;)V

    .line 1168
    nop

    .line 1166
    const-wide/16 v2, 0x3e8

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 1170
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->stopVideoPlayback()V

    .line 1172
    return-void
.end method

.method private static final showBioScreen$lambda$24(Lcom/roder300/kozen/MainActivity;)V
    .locals 0
    .param p0, "this$0"    # Lcom/roder300/kozen/MainActivity;

    .line 1167
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->checkAndRequestCameraPermission()V

    .line 1168
    return-void
.end method

.method private final showButtonsScreen(Lorg/json/JSONObject;)V
    .locals 18
    .param p1, "buttonsData"    # Lorg/json/JSONObject;

    .line 1236
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/roder300/kozen/MainActivity;->buttonsContainer:Landroid/widget/LinearLayout;

    const-string v2, "buttonsContainer"

    if-nez v1, :cond_0

    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v1, 0x0

    :cond_0
    invoke-virtual {v1}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 1239
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    check-cast v1, Ljava/util/List;

    .line 1240
    .local v1, "keysList":Ljava/util/List;
    invoke-virtual/range {p1 .. p1}, Lorg/json/JSONObject;->keys()Ljava/util/Iterator;

    move-result-object v4

    .line 1241
    .local v4, "keys":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_1

    .line 1242
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    const-string v6, "next(...)"

    invoke-static {v5, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v1, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 1246
    :cond_1
    move-object v5, v1

    check-cast v5, Ljava/lang/Iterable;

    invoke-interface {v5}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v5

    const/4 v6, 0x0

    :goto_1
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_3

    move v7, v6

    .local v7, "index":I
    add-int/lit8 v6, v6, 0x1

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    .line 1247
    .local v8, "key":Ljava/lang/String;
    const-string v9, ""

    move-object/from16 v10, p1

    invoke-virtual {v10, v8, v9}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    .line 1249
    .local v9, "value":Ljava/lang/String;
    new-instance v11, Landroid/widget/Button;

    move-object v12, v0

    check-cast v12, Landroid/content/Context;

    invoke-direct {v11, v12}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V

    move-object v12, v11

    .local v12, "$this$showButtonsScreen_u24lambda_u2433\\1":Landroid/widget/Button;
    const/4 v13, 0x0

    .line 1250
    .local v13, "$i$a$-apply-MainActivity$showButtonsScreen$button$1\\1\\1249\\0":I
    move-object v14, v8

    check-cast v14, Ljava/lang/CharSequence;

    invoke-virtual {v12, v14}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 1251
    const/4 v14, -0x1

    invoke-virtual {v12, v14}, Landroid/widget/Button;->setTextColor(I)V

    .line 1252
    const-string v15, "#FF6200EE"

    invoke-static {v15}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v15

    invoke-virtual {v12, v15}, Landroid/widget/Button;->setBackgroundColor(I)V

    .line 1253
    new-instance v15, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda19;

    invoke-direct {v15, v0, v8, v9}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda19;-><init>(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v12, v15}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 1257
    new-instance v15, Landroid/widget/LinearLayout$LayoutParams;

    .line 1258
    nop

    .line 1259
    nop

    .line 1257
    const/4 v3, -0x2

    invoke-direct {v15, v14, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 1260
    move-object v3, v15

    .local v3, "$this$showButtonsScreen_u24lambda_u2433_u24lambda_u2432\\2":Landroid/widget/LinearLayout$LayoutParams;
    const/4 v14, 0x0

    .line 1261
    .local v14, "$i$a$-apply-MainActivity$showButtonsScreen$button$1$2\\2\\1260\\1":I
    move-object/from16 v16, v1

    .end local v1    # "keysList":Ljava/util/List;
    .local v16, "keysList":Ljava/util/List;
    const/16 v1, 0x28

    move-object/from16 v17, v2

    const/16 v2, 0x14

    invoke-virtual {v3, v1, v2, v1, v2}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 1262
    nop

    .line 1260
    .end local v3    # "$this$showButtonsScreen_u24lambda_u2433_u24lambda_u2432\\2":Landroid/widget/LinearLayout$LayoutParams;
    .end local v14    # "$i$a$-apply-MainActivity$showButtonsScreen$button$1$2\\2\\1260\\1":I
    check-cast v15, Landroid/view/ViewGroup$LayoutParams;

    .line 1257
    invoke-virtual {v12, v15}, Landroid/widget/Button;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 1265
    const/4 v1, 0x0

    invoke-virtual {v12, v1}, Landroid/widget/Button;->setAlpha(F)V

    .line 1266
    const/high16 v2, 0x42480000    # 50.0f

    invoke-virtual {v12, v2}, Landroid/widget/Button;->setTranslationY(F)V

    .line 1267
    invoke-virtual {v12}, Landroid/widget/Button;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    .line 1268
    const/high16 v3, 0x3f800000    # 1.0f

    invoke-virtual {v2, v3}, Landroid/view/ViewPropertyAnimator;->alpha(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    .line 1269
    invoke-virtual {v2, v1}, Landroid/view/ViewPropertyAnimator;->translationY(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v1

    .line 1270
    const-wide/16 v2, 0x12c

    invoke-virtual {v1, v2, v3}, Landroid/view/ViewPropertyAnimator;->setDuration(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v1

    .line 1271
    mul-int/lit8 v2, v7, 0x64

    int-to-long v2, v2

    invoke-virtual {v1, v2, v3}, Landroid/view/ViewPropertyAnimator;->setStartDelay(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v1

    .line 1272
    invoke-virtual {v1}, Landroid/view/ViewPropertyAnimator;->start()V

    .line 1273
    nop

    .line 1249
    .end local v12    # "$this$showButtonsScreen_u24lambda_u2433\\1":Landroid/widget/Button;
    .end local v13    # "$i$a$-apply-MainActivity$showButtonsScreen$button$1\\1\\1249\\0":I
    nop

    .line 1275
    .local v11, "button":Landroid/widget/Button;
    iget-object v1, v0, Lcom/roder300/kozen/MainActivity;->buttonsContainer:Landroid/widget/LinearLayout;

    if-nez v1, :cond_2

    invoke-static/range {v17 .. v17}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v1, 0x0

    :cond_2
    move-object v2, v11

    check-cast v2, Landroid/view/View;

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    move-object/from16 v1, v16

    move-object/from16 v2, v17

    .end local v9    # "value":Ljava/lang/String;
    .end local v11    # "button":Landroid/widget/Button;
    goto/16 :goto_1

    .line 1278
    .end local v7    # "index":I
    .end local v8    # "key":Ljava/lang/String;
    .end local v16    # "keysList":Ljava/util/List;
    .restart local v1    # "keysList":Ljava/util/List;
    :cond_3
    move-object/from16 v16, v1

    .end local v1    # "keysList":Ljava/util/List;
    .restart local v16    # "keysList":Ljava/util/List;
    const-string v1, "buttons"

    const/4 v2, 0x2

    const/4 v3, 0x0

    invoke-static {v0, v1, v3, v2, v3}, Lcom/roder300/kozen/MainActivity;->showScreen$default(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;Ljava/lang/Boolean;ILjava/lang/Object;)V

    .line 1279
    return-void
.end method

.method private static final showButtonsScreen$lambda$33$lambda$31(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;Ljava/lang/String;Landroid/view/View;)V
    .locals 3
    .param p0, "this$0"    # Lcom/roder300/kozen/MainActivity;
    .param p1, "$key"    # Ljava/lang/String;
    .param p2, "$value"    # Ljava/lang/String;
    .param p3, "it"    # Landroid/view/View;

    .line 1255
    move-object v0, p0

    check-cast v0, Landroid/content/Context;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "\u041d\u0430\u0436\u0430\u0442\u0430: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " -> "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 1256
    return-void
.end method

.method public static synthetic showImgDesc$default(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;Landroid/widget/ImageView;ILjava/lang/Object;)V
    .locals 0

    .line 331
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_0

    iget-object p2, p0, Lcom/roder300/kozen/MainActivity;->imageDescFace:Landroid/widget/ImageView;

    if-nez p2, :cond_0

    const-string p2, "imageDescFace"

    invoke-static {p2}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 p2, 0x0

    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/roder300/kozen/MainActivity;->showImgDesc(Ljava/lang/String;Landroid/widget/ImageView;)V

    return-void
.end method

.method private final showPasswordDialog()V
    .locals 4

    .line 1666
    new-instance v0, Landroid/app/AlertDialog$Builder;

    move-object v1, p0

    check-cast v1, Landroid/content/Context;

    invoke-direct {v0, v1}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 1667
    .local v0, "alertDialog":Landroid/app/AlertDialog$Builder;
    const-string v1, "\u0412\u0432\u0435\u0434\u0438\u0442\u0435 \u043f\u0430\u0440\u043e\u043b\u044c"

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 1668
    const-string v1, "\u0414\u043b\u044f \u0432\u044b\u0445\u043e\u0434\u0430 \u0432\u0432\u0435\u0434\u0438\u0442\u0435 \u043f\u0430\u0440\u043e\u043b\u044c:"

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 1670
    new-instance v1, Landroid/widget/EditText;

    move-object v2, p0

    check-cast v2, Landroid/content/Context;

    invoke-direct {v1, v2}, Landroid/widget/EditText;-><init>(Landroid/content/Context;)V

    .line 1671
    .local v1, "input":Landroid/widget/EditText;
    move-object v2, v1

    check-cast v2, Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    .line 1673
    const-string v2, "OK"

    check-cast v2, Ljava/lang/CharSequence;

    new-instance v3, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda15;

    invoke-direct {v3, v1, p0}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda15;-><init>(Landroid/widget/EditText;Lcom/roder300/kozen/MainActivity;)V

    invoke-virtual {v0, v2, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 1684
    const-string v2, "\u041e\u0442\u043c\u0435\u043d\u0430"

    check-cast v2, Ljava/lang/CharSequence;

    new-instance v3, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda16;

    invoke-direct {v3}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda16;-><init>()V

    invoke-virtual {v0, v2, v3}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 1688
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 1689
    return-void
.end method

.method private static final showPasswordDialog$lambda$40(Landroid/widget/EditText;Lcom/roder300/kozen/MainActivity;Landroid/content/DialogInterface;I)V
    .locals 4
    .param p0, "$input"    # Landroid/widget/EditText;
    .param p1, "this$0"    # Lcom/roder300/kozen/MainActivity;
    .param p2, "dialog"    # Landroid/content/DialogInterface;
    .param p3, "which"    # I

    const-string v0, "dialog"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1674
    invoke-virtual {p0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v0}, Lkotlin/text/StringsKt;->trim(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1676
    .local v0, "password":Ljava/lang/String;
    const-string v1, "servicemod"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    move-object v1, p1

    check-cast v1, Landroid/content/Context;

    invoke-virtual {p1}, Lcom/roder300/kozen/MainActivity;->getSharedPreferences()Landroid/content/SharedPreferences;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/roder300/kozen/ServiceMenuHelper;->showSettingsDialog(Landroid/content/Context;Landroid/content/SharedPreferences;)V

    return-void

    :cond_0
    iget-object v1, p1, Lcom/roder300/kozen/MainActivity;->correctPassword:Ljava/lang/String;

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_1

    .line 1677
    invoke-virtual {p1}, Lcom/roder300/kozen/MainActivity;->finishAffinity()V

    .line 1678
    invoke-static {v2}, Ljava/lang/System;->exit(I)V

    goto :goto_0

    .line 1680
    :cond_1
    move-object v1, p1

    check-cast v1, Landroid/content/Context;

    const-string v3, "\u041d\u0435\u0432\u0435\u0440\u043d\u044b\u0439 \u043f\u0430\u0440\u043e\u043b\u044c!"

    check-cast v3, Ljava/lang/CharSequence;

    invoke-static {v1, v3, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/Toast;->show()V

    .line 1682
    :goto_0
    return-void
.end method

.method private static final showPasswordDialog$lambda$41(Landroid/content/DialogInterface;I)V
    .locals 1
    .param p0, "dialog"    # Landroid/content/DialogInterface;
    .param p1, "which"    # I

    const-string v0, "dialog"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1685
    invoke-interface {p0}, Landroid/content/DialogInterface;->cancel()V

    .line 1686
    return-void
.end method

.method private final showPayScreen(Ljava/lang/String;)V
    .locals 3
    .param p1, "amount"    # Ljava/lang/String;

    .line 1150
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->textAmount:Landroid/widget/TextView;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    const-string v0, "textAmount"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v0, v1

    :cond_0
    invoke-virtual {p0, p1}, Lcom/roder300/kozen/MainActivity;->formatAmount(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 1151
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->textAmountSucc:Landroid/widget/TextView;

    if-nez v0, :cond_1

    const-string v0, "textAmountSucc"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v0, v1

    :cond_1
    invoke-virtual {p0, p1}, Lcom/roder300/kozen/MainActivity;->formatAmount(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 1152
    const-string v0, "pay"

    const/4 v2, 0x2

    invoke-static {p0, v0, v1, v2, v1}, Lcom/roder300/kozen/MainActivity;->showScreen$default(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;Ljava/lang/Boolean;ILjava/lang/Object;)V

    .line 1153
    const/4 v0, 0x1

    const/4 v2, 0x0

    invoke-static {p0, v2, v0, v1}, Lcom/roder300/kozen/MainActivity;->doNotBlockScreen$default(Lcom/roder300/kozen/MainActivity;ZILjava/lang/Object;)V

    .line 1154
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->videoBackground:Landroid/widget/VideoView;

    if-nez v0, :cond_2

    const-string v0, "videoBackground"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    move-object v1, v0

    :goto_0
    invoke-virtual {v1, v2}, Landroid/widget/VideoView;->setVisibility(I)V

    .line 1156
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->startSensorCard()V

    .line 1158
    return-void
.end method

.method private final showPayScreenPending()V
    .locals 9

    .line 1180
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->lottieAnimationLoader:Lcom/airbnb/lottie/LottieAnimationView;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    const-string v0, "lottieAnimationLoader"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v3, v1

    goto :goto_0

    :cond_0
    move-object v3, v0

    :goto_0
    const/4 v7, 0x6

    const/4 v8, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const v6, 0x3f19999a    # 0.6f

    move-object v2, p0

    invoke-static/range {v2 .. v8}, Lcom/roder300/kozen/MainActivity;->startLottieAnimation$default(Lcom/roder300/kozen/MainActivity;Lcom/airbnb/lottie/LottieAnimationView;ZIFILjava/lang/Object;)V

    .line 1181
    const-string v0, "payPending"

    const/4 v3, 0x2

    invoke-static {p0, v0, v1, v3, v1}, Lcom/roder300/kozen/MainActivity;->showScreen$default(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;Ljava/lang/Boolean;ILjava/lang/Object;)V

    .line 1182
    iget-object v0, v2, Lcom/roder300/kozen/MainActivity;->textStatusPending:Landroid/widget/TextView;

    if-nez v0, :cond_1

    const-string v0, "textStatusPending"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_1

    :cond_1
    move-object v1, v0

    :goto_1
    const-string v0, "\u041f\u0435\u0440\u0435\u0434\u0430\u044e \u0437\u0430\u043f\u0440\u043e\u0441..."

    check-cast v0, Ljava/lang/CharSequence;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 1184
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v1, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda10;

    invoke-direct {v1, p0}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda10;-><init>(Lcom/roder300/kozen/MainActivity;)V

    .line 1230
    nop

    .line 1184
    const-wide/16 v3, 0x44c

    invoke-virtual {v0, v1, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 1231
    return-void
.end method

.method private static final showPayScreenPending$lambda$30(Lcom/roder300/kozen/MainActivity;)V
    .locals 4
    .param p0, "this$0"    # Lcom/roder300/kozen/MainActivity;

    .line 1185
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->textStatusPending:Landroid/widget/TextView;

    if-nez v0, :cond_0

    const-string v0, "textStatusPending"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v0, 0x0

    :cond_0
    const-string v1, "\u0416\u0434\u0443 \u043e\u0442\u0432\u0435\u0442\u0430..."

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method private static final showPayScreenPending$lambda$30$lambda$29(Lcom/roder300/kozen/MainActivity;)V
    .locals 4
    .param p0, "this$0"    # Lcom/roder300/kozen/MainActivity;

    .line 1187
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->textStatusPending:Landroid/widget/TextView;

    if-nez v0, :cond_0

    const-string v0, "textStatusPending"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v0, 0x0

    :cond_0
    const-string v1, "\u0416\u0434\u0443 \u043e\u0442\u0432\u0435\u0442\u0430..."

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 1188
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v1, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda4;

    invoke-direct {v1, p0}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda4;-><init>(Lcom/roder300/kozen/MainActivity;)V

    .line 1228
    nop

    .line 1188
    const-wide/16 v2, 0x578

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 1229
    return-void
.end method

.method private static final showPayScreenPending$lambda$30$lambda$29$lambda$28(Lcom/roder300/kozen/MainActivity;)V
    .locals 4
    .param p0, "this$0"    # Lcom/roder300/kozen/MainActivity;

    .line 1189
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->textStatusPending:Landroid/widget/TextView;

    if-nez v0, :cond_0

    const-string v0, "textStatusPending"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v0, 0x0

    :cond_0
    const-string v1, "\u041e\u0442\u0432\u0435\u0442 \u043f\u043e\u043b\u0443\u0447\u0435\u043d..."

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 1190
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v1, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda25;

    invoke-direct {v1, p0}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda25;-><init>(Lcom/roder300/kozen/MainActivity;)V

    .line 1227
    nop

    .line 1190
    const-wide/16 v2, 0x258

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 1228
    return-void
.end method

.method private static final showPayScreenPending$lambda$30$lambda$29$lambda$28$lambda$27(Lcom/roder300/kozen/MainActivity;)V
    .locals 3
    .param p0, "this$0"    # Lcom/roder300/kozen/MainActivity;

    .line 1191
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->textStatusPending:Landroid/widget/TextView;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    const-string v0, "textStatusPending"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v0, v1

    :cond_0
    const-string v2, "\u041e\u043f\u0430..."

    check-cast v2, Ljava/lang/CharSequence;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 1193
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->lottieAnimationLoader:Lcom/airbnb/lottie/LottieAnimationView;

    if-nez v0, :cond_1

    const-string v0, "lottieAnimationLoader"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    move-object v1, v0

    :goto_0
    new-instance v0, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda27;

    invoke-direct {v0, p0}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda27;-><init>(Lcom/roder300/kozen/MainActivity;)V

    invoke-direct {p0, v1, v0}, Lcom/roder300/kozen/MainActivity;->waitForAnimationCompletion(Lcom/airbnb/lottie/LottieAnimationView;Lkotlin/jvm/functions/Function0;)V

    .line 1227
    return-void
.end method

.method private static final showPayScreenPending$lambda$30$lambda$29$lambda$28$lambda$27$lambda$26(Lcom/roder300/kozen/MainActivity;)Lkotlin/Unit;
    .locals 6
    .param p0, "this$0"    # Lcom/roder300/kozen/MainActivity;

    .line 1195
    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    const-string v1, "paySuccContainer"

    invoke-direct {p0, v1, v0}, Lcom/roder300/kozen/MainActivity;->showScreen(Ljava/lang/String;Ljava/lang/Boolean;)V

    .line 1196
    const-string v0, "success_pay"

    const/4 v1, 0x0

    const/4 v2, 0x2

    const/4 v3, 0x0

    invoke-static {p0, v0, v1, v2, v3}, Lcom/roder300/kozen/MainActivity;->playSound$default(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;FILjava/lang/Object;)V

    .line 1198
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v1, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda12;

    invoke-direct {v1, p0}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda12;-><init>(Lcom/roder300/kozen/MainActivity;)V

    .line 1204
    nop

    .line 1198
    const-wide/16 v4, 0x226

    invoke-virtual {v0, v1, v4, v5}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 1207
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->lottieAnimationLoaderSucc:Lcom/airbnb/lottie/LottieAnimationView;

    if-nez v0, :cond_0

    const-string v0, "lottieAnimationLoaderSucc"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    move-object v3, v0

    :goto_0
    new-instance v0, Lcom/roder300/kozen/MainActivity$showPayScreenPending$1$1$1$1$1$2;

    invoke-direct {v0, p0}, Lcom/roder300/kozen/MainActivity$showPayScreenPending$1$1$1$1$1$2;-><init>(Lcom/roder300/kozen/MainActivity;)V

    check-cast v0, Landroid/animation/ValueAnimator$AnimatorUpdateListener;

    invoke-virtual {v3, v0}, Lcom/airbnb/lottie/LottieAnimationView;->addAnimatorUpdateListener(Landroid/animation/ValueAnimator$AnimatorUpdateListener;)V

    .line 1226
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method private static final showPayScreenPending$lambda$30$lambda$29$lambda$28$lambda$27$lambda$26$lambda$25(Lcom/roder300/kozen/MainActivity;)V
    .locals 10
    .param p0, "this$0"    # Lcom/roder300/kozen/MainActivity;

    .line 1200
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->lottieAnimationLoaderSucc:Lcom/airbnb/lottie/LottieAnimationView;

    const/4 v1, 0x0

    const-string v2, "lottieAnimationLoaderSucc"

    if-nez v0, :cond_0

    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v4, v1

    goto :goto_0

    :cond_0
    move-object v4, v0

    :goto_0
    const/16 v8, 0x8

    const/4 v9, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v3, p0

    .end local p0    # "this$0":Lcom/roder300/kozen/MainActivity;
    .local v3, "this$0":Lcom/roder300/kozen/MainActivity;
    invoke-static/range {v3 .. v9}, Lcom/roder300/kozen/MainActivity;->startLottieAnimation$default(Lcom/roder300/kozen/MainActivity;Lcom/airbnb/lottie/LottieAnimationView;ZIFILjava/lang/Object;)V

    .line 1201
    iget-object p0, v3, Lcom/roder300/kozen/MainActivity;->lottieAnimationLoaderSucc:Lcom/airbnb/lottie/LottieAnimationView;

    if-nez p0, :cond_1

    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object p0, v1

    :cond_1
    const/high16 v0, 0x3f800000    # 1.0f

    invoke-virtual {p0, v0}, Lcom/airbnb/lottie/LottieAnimationView;->setAlpha(F)V

    .line 1202
    iget-object p0, v3, Lcom/roder300/kozen/MainActivity;->lottieAnimationLoaderSucc:Lcom/airbnb/lottie/LottieAnimationView;

    if-nez p0, :cond_2

    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object p0, v1

    :cond_2
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/airbnb/lottie/LottieAnimationView;->setTranslationY(F)V

    .line 1203
    iget-object p0, v3, Lcom/roder300/kozen/MainActivity;->lottieAnimationLoaderSucc:Lcom/airbnb/lottie/LottieAnimationView;

    if-nez p0, :cond_3

    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_1

    :cond_3
    move-object v1, p0

    :goto_1
    const/4 p0, 0x0

    invoke-virtual {v1, p0}, Lcom/airbnb/lottie/LottieAnimationView;->setVisibility(I)V

    .line 1204
    return-void
.end method

.method private final showRegistrationErrorDialog(Ljava/lang/String;)V
    .locals 3
    .param p1, "message"    # Ljava/lang/String;

    .line 1435
    new-instance v0, Landroid/app/AlertDialog$Builder;

    move-object v1, p0

    check-cast v1, Landroid/content/Context;

    invoke-direct {v0, v1}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 1436
    const-string v1, "\u041e\u0448\u0438\u0431\u043a\u0430 \u0440\u0435\u0433\u0438\u0441\u0442\u0440\u0430\u0446\u0438\u0438 \u0442\u0435\u0440\u043c\u0438\u043d\u0430\u043b\u0430"

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 1437
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\n\n\u041f\u043e\u0432\u0442\u043e\u0440\u0438\u0442\u044c \u043f\u043e\u043f\u044b\u0442\u043a\u0443 \u0440\u0435\u0433\u0438\u0441\u0442\u0440\u0430\u0446\u0438\u0438?"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 1438
    const-string v1, "\u041f\u043e\u0432\u0442\u043e\u0440\u0438\u0442\u044c"

    check-cast v1, Ljava/lang/CharSequence;

    new-instance v2, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda13;

    invoke-direct {v2, p0}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda13;-><init>(Lcom/roder300/kozen/MainActivity;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 1446
    const-string v1, "\u0412\u044b\u0439\u0442\u0438"

    check-cast v1, Ljava/lang/CharSequence;

    new-instance v2, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda14;

    invoke-direct {v2, p0}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda14;-><init>(Lcom/roder300/kozen/MainActivity;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 1451
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setCancelable(Z)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 1452
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    .line 1435
    nop

    .line 1454
    .local v0, "alertDialog":Landroid/app/AlertDialog;
    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    .line 1455
    return-void
.end method

.method private static final showRegistrationErrorDialog$lambda$34(Lcom/roder300/kozen/MainActivity;Landroid/content/DialogInterface;I)V
    .locals 0
    .param p0, "this$0"    # Lcom/roder300/kozen/MainActivity;
    .param p1, "dialog"    # Landroid/content/DialogInterface;

    .line 1439
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    .line 1440
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->isNetworkAvailable()Z

    move-result p2

    if-eqz p2, :cond_0

    .line 1441
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->registerDevice()V

    goto :goto_0

    .line 1443
    :cond_0
    const-string p2, "\u041d\u0435\u0442 \u0438\u043d\u0442\u0435\u0440\u043d\u0435\u0442-\u0441\u043e\u0435\u0434\u0438\u043d\u0435\u043d\u0438\u044f. \u041f\u0440\u043e\u0432\u0435\u0440\u044c\u0442\u0435 \u0441\u043e\u0435\u0434\u0438\u0435\u043d\u0435\u043d\u0438\u0435 \u0438"

    invoke-direct {p0, p2}, Lcom/roder300/kozen/MainActivity;->showRegistrationErrorDialog(Ljava/lang/String;)V

    .line 1445
    :goto_0
    return-void
.end method

.method private static final showRegistrationErrorDialog$lambda$35(Lcom/roder300/kozen/MainActivity;Landroid/content/DialogInterface;I)V
    .locals 0
    .param p0, "this$0"    # Lcom/roder300/kozen/MainActivity;
    .param p1, "dialog"    # Landroid/content/DialogInterface;

    .line 1447
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    .line 1448
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->finishAffinity()V

    .line 1449
    const/4 p2, 0x0

    invoke-static {p2}, Ljava/lang/System;->exit(I)V

    .line 1450
    return-void
.end method

.method private final showScreen(Ljava/lang/String;Ljava/lang/Boolean;)V
    .locals 19
    .param p1, "screen"    # Ljava/lang/String;
    .param p2, "anim"    # Ljava/lang/Boolean;

    .line 926
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    iget-object v3, v0, Lcom/roder300/kozen/MainActivity;->currentScreen:Ljava/lang/String;

    invoke-static {v3, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 927
    return-void

    .line 930
    :cond_0
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v3

    const-string v4, "payPendingContainer"

    const-string v5, "buttonsContainer"

    const-string v6, "textContainer"

    const-string v7, "payContainer"

    const-string v8, "payPending"

    const-string v9, "buttons"

    const-string v10, "text"

    const-string v11, "main"

    const-string v12, "pay"

    const-string v13, "mainContainer"

    const-string v14, "faceRecognition"

    const-string v15, "paySuccContainer"

    const/16 v16, 0x0

    sparse-switch v3, :sswitch_data_0

    :goto_0
    goto/16 :goto_1

    :sswitch_0
    invoke-virtual {v1, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1

    goto :goto_0

    .line 934
    :cond_1
    iget-object v3, v0, Lcom/roder300/kozen/MainActivity;->payPendingContainer:Landroid/widget/FrameLayout;

    if-nez v3, :cond_2

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object/from16 v3, v16

    :cond_2
    check-cast v3, Landroid/view/ViewGroup;

    goto/16 :goto_2

    .line 930
    :sswitch_1
    invoke-virtual {v1, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    goto :goto_0

    .line 936
    :cond_3
    iget-object v3, v0, Lcom/roder300/kozen/MainActivity;->faceRecognition:Landroid/widget/FrameLayout;

    if-nez v3, :cond_4

    invoke-static {v14}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object/from16 v3, v16

    :cond_4
    check-cast v3, Landroid/view/ViewGroup;

    goto/16 :goto_2

    .line 930
    :sswitch_2
    invoke-virtual {v1, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_5

    goto :goto_0

    .line 937
    :cond_5
    iget-object v3, v0, Lcom/roder300/kozen/MainActivity;->buttonsContainer:Landroid/widget/LinearLayout;

    if-nez v3, :cond_6

    invoke-static {v5}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object/from16 v3, v16

    :cond_6
    check-cast v3, Landroid/view/ViewGroup;

    goto :goto_2

    .line 930
    :sswitch_3
    invoke-virtual {v1, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_7

    goto :goto_0

    .line 933
    :cond_7
    iget-object v3, v0, Lcom/roder300/kozen/MainActivity;->textContainer:Landroid/widget/LinearLayout;

    if-nez v3, :cond_8

    invoke-static {v6}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object/from16 v3, v16

    :cond_8
    check-cast v3, Landroid/view/ViewGroup;

    goto :goto_2

    .line 930
    :sswitch_4
    invoke-virtual {v1, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_9

    goto :goto_0

    .line 931
    :cond_9
    iget-object v3, v0, Lcom/roder300/kozen/MainActivity;->mainContainer:Landroidx/constraintlayout/widget/ConstraintLayout;

    if-nez v3, :cond_a

    invoke-static {v13}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object/from16 v3, v16

    :cond_a
    check-cast v3, Landroid/view/ViewGroup;

    goto :goto_2

    .line 930
    :sswitch_5
    invoke-virtual {v1, v12}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_b

    goto :goto_0

    .line 932
    :cond_b
    iget-object v3, v0, Lcom/roder300/kozen/MainActivity;->payContainer:Landroid/widget/FrameLayout;

    if-nez v3, :cond_c

    invoke-static {v7}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object/from16 v3, v16

    :cond_c
    check-cast v3, Landroid/view/ViewGroup;

    goto :goto_2

    .line 930
    :sswitch_6
    invoke-virtual {v1, v15}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_d

    goto :goto_0

    .line 935
    :cond_d
    iget-object v3, v0, Lcom/roder300/kozen/MainActivity;->paySuccContainer:Landroid/widget/FrameLayout;

    if-nez v3, :cond_e

    invoke-static {v15}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object/from16 v3, v16

    :cond_e
    check-cast v3, Landroid/view/ViewGroup;

    goto :goto_2

    .line 938
    :goto_1
    iget-object v3, v0, Lcom/roder300/kozen/MainActivity;->mainContainer:Landroidx/constraintlayout/widget/ConstraintLayout;

    if-nez v3, :cond_f

    invoke-static {v13}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object/from16 v3, v16

    :cond_f
    check-cast v3, Landroid/view/ViewGroup;

    .line 930
    :goto_2
    nop

    .line 941
    .local v3, "targetContainer":Landroid/view/ViewGroup;
    move-object/from16 v17, v4

    iget-object v4, v0, Lcom/roder300/kozen/MainActivity;->currentScreen:Ljava/lang/String;

    invoke-virtual {v4}, Ljava/lang/String;->hashCode()I

    move-result v18

    sparse-switch v18, :sswitch_data_1

    :goto_3
    goto/16 :goto_b

    :sswitch_7
    invoke-virtual {v4, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_10

    goto :goto_3

    .line 945
    :cond_10
    iget-object v4, v0, Lcom/roder300/kozen/MainActivity;->payPendingContainer:Landroid/widget/FrameLayout;

    if-nez v4, :cond_11

    invoke-static/range {v17 .. v17}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_4

    :cond_11
    move-object/from16 v16, v4

    :goto_4
    check-cast v16, Landroid/view/ViewGroup;

    goto/16 :goto_c

    .line 941
    :sswitch_8
    invoke-virtual {v4, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_12

    goto :goto_3

    .line 947
    :cond_12
    iget-object v4, v0, Lcom/roder300/kozen/MainActivity;->faceRecognition:Landroid/widget/FrameLayout;

    if-nez v4, :cond_13

    invoke-static {v14}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_5

    :cond_13
    move-object/from16 v16, v4

    :goto_5
    check-cast v16, Landroid/view/ViewGroup;

    goto/16 :goto_c

    .line 941
    :sswitch_9
    invoke-virtual {v4, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_14

    goto :goto_3

    .line 948
    :cond_14
    iget-object v4, v0, Lcom/roder300/kozen/MainActivity;->buttonsContainer:Landroid/widget/LinearLayout;

    if-nez v4, :cond_15

    invoke-static {v5}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_6

    :cond_15
    move-object/from16 v16, v4

    :goto_6
    check-cast v16, Landroid/view/ViewGroup;

    goto :goto_c

    .line 941
    :sswitch_a
    invoke-virtual {v4, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_16

    goto :goto_3

    .line 944
    :cond_16
    iget-object v4, v0, Lcom/roder300/kozen/MainActivity;->textContainer:Landroid/widget/LinearLayout;

    if-nez v4, :cond_17

    invoke-static {v6}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_7

    :cond_17
    move-object/from16 v16, v4

    :goto_7
    check-cast v16, Landroid/view/ViewGroup;

    goto :goto_c

    .line 941
    :sswitch_b
    invoke-virtual {v4, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_18

    goto :goto_3

    .line 942
    :cond_18
    iget-object v4, v0, Lcom/roder300/kozen/MainActivity;->mainContainer:Landroidx/constraintlayout/widget/ConstraintLayout;

    if-nez v4, :cond_19

    invoke-static {v13}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_8

    :cond_19
    move-object/from16 v16, v4

    :goto_8
    check-cast v16, Landroid/view/ViewGroup;

    goto :goto_c

    .line 941
    :sswitch_c
    invoke-virtual {v4, v12}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_1a

    goto :goto_3

    .line 943
    :cond_1a
    iget-object v4, v0, Lcom/roder300/kozen/MainActivity;->payContainer:Landroid/widget/FrameLayout;

    if-nez v4, :cond_1b

    invoke-static {v7}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_9

    :cond_1b
    move-object/from16 v16, v4

    :goto_9
    check-cast v16, Landroid/view/ViewGroup;

    goto :goto_c

    .line 941
    :sswitch_d
    invoke-virtual {v4, v15}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_1c

    goto/16 :goto_3

    .line 946
    :cond_1c
    iget-object v4, v0, Lcom/roder300/kozen/MainActivity;->paySuccContainer:Landroid/widget/FrameLayout;

    if-nez v4, :cond_1d

    invoke-static {v15}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_a

    :cond_1d
    move-object/from16 v16, v4

    :goto_a
    check-cast v16, Landroid/view/ViewGroup;

    goto :goto_c

    .line 949
    :goto_b
    nop

    .line 941
    :goto_c
    move-object/from16 v4, v16

    .line 952
    .local v4, "previousContainer":Landroid/view/ViewGroup;
    const/high16 v5, -0x3db80000    # -50.0f

    .line 955
    .local v5, "translateY":F
    const/4 v6, 0x1

    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v7

    invoke-static {v2, v7}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_1e

    .line 956
    move-object v7, v3

    check-cast v7, Landroid/view/View;

    invoke-direct {v0, v7}, Lcom/roder300/kozen/MainActivity;->hideAllContainersExcept(Landroid/view/View;)V

    .line 959
    :cond_1e
    const/4 v7, 0x0

    invoke-static {v7}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v7

    invoke-static {v2, v7}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_1f

    .line 960
    const/4 v5, 0x0

    .line 964
    :cond_1f
    if-eqz v4, :cond_20

    invoke-static {v4, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_20

    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v6

    invoke-static {v2, v6}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_20

    .line 965
    invoke-virtual {v4}, Landroid/view/ViewGroup;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v6

    .line 966
    const/4 v7, 0x0

    invoke-virtual {v6, v7}, Landroid/view/ViewPropertyAnimator;->alpha(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v6

    .line 967
    invoke-virtual {v6, v5}, Landroid/view/ViewPropertyAnimator;->translationY(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v6

    .line 968
    const-wide/16 v7, 0x190

    invoke-virtual {v6, v7, v8}, Landroid/view/ViewPropertyAnimator;->setDuration(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v6

    .line 969
    new-instance v7, Landroid/view/animation/AccelerateInterpolator;

    invoke-direct {v7}, Landroid/view/animation/AccelerateInterpolator;-><init>()V

    check-cast v7, Landroid/animation/TimeInterpolator;

    invoke-virtual {v6, v7}, Landroid/view/ViewPropertyAnimator;->setInterpolator(Landroid/animation/TimeInterpolator;)Landroid/view/ViewPropertyAnimator;

    move-result-object v6

    .line 970
    new-instance v7, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda9;

    invoke-direct {v7, v4}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda9;-><init>(Landroid/view/ViewGroup;)V

    invoke-virtual {v6, v7}, Landroid/view/ViewPropertyAnimator;->withEndAction(Ljava/lang/Runnable;)Landroid/view/ViewPropertyAnimator;

    move-result-object v6

    .line 977
    invoke-virtual {v6}, Landroid/view/ViewPropertyAnimator;->start()V

    .line 979
    move-object v6, v3

    check-cast v6, Landroid/view/View;

    invoke-direct {v0, v6, v2}, Lcom/roder300/kozen/MainActivity;->showTargetContainer(Landroid/view/View;Ljava/lang/Boolean;)V

    goto :goto_d

    .line 982
    :cond_20
    move-object v6, v3

    check-cast v6, Landroid/view/View;

    invoke-direct {v0, v6, v2}, Lcom/roder300/kozen/MainActivity;->showTargetContainer(Landroid/view/View;Ljava/lang/Boolean;)V

    .line 985
    :goto_d
    iput-object v1, v0, Lcom/roder300/kozen/MainActivity;->currentScreen:Ljava/lang/String;

    .line 986
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        -0x3dc06369 -> :sswitch_6
        0x1b0a8 -> :sswitch_5
        0x3305b9 -> :sswitch_4
        0x36452d -> :sswitch_3
        0xe62bf81 -> :sswitch_2
        0x25e0a51a -> :sswitch_1
        0x6206e3cf -> :sswitch_0
    .end sparse-switch

    :sswitch_data_1
    .sparse-switch
        -0x3dc06369 -> :sswitch_d
        0x1b0a8 -> :sswitch_c
        0x3305b9 -> :sswitch_b
        0x36452d -> :sswitch_a
        0xe62bf81 -> :sswitch_9
        0x25e0a51a -> :sswitch_8
        0x6206e3cf -> :sswitch_7
    .end sparse-switch
.end method

.method static synthetic showScreen$default(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;Ljava/lang/Boolean;ILjava/lang/Object;)V
    .locals 0

    .line 924
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_0

    const/4 p2, 0x1

    invoke-static {p2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p2

    :cond_0
    invoke-direct {p0, p1, p2}, Lcom/roder300/kozen/MainActivity;->showScreen(Ljava/lang/String;Ljava/lang/Boolean;)V

    return-void
.end method

.method private static final showScreen$lambda$15(Landroid/view/ViewGroup;)V
    .locals 1
    .param p0, "$previousContainer"    # Landroid/view/ViewGroup;

    .line 971
    const/16 v0, 0x8

    invoke-virtual {p0, v0}, Landroid/view/ViewGroup;->setVisibility(I)V

    .line 972
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Landroid/view/ViewGroup;->setTranslationY(F)V

    .line 973
    const/high16 v0, 0x3f800000    # 1.0f

    invoke-virtual {p0, v0}, Landroid/view/ViewGroup;->setAlpha(F)V

    .line 976
    return-void
.end method

.method private final showTargetContainer(Landroid/view/View;Ljava/lang/Boolean;)V
    .locals 4
    .param p1, "container"    # Landroid/view/View;
    .param p2, "anim"    # Ljava/lang/Boolean;

    .line 1093
    const/high16 v0, 0x42c80000    # 100.0f

    .line 1094
    .local v0, "translateY":F
    const/4 v1, 0x0

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-static {p2, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 1095
    const/4 v0, 0x0

    .line 1098
    :cond_0
    const/4 v2, 0x0

    invoke-virtual {p1, v2}, Landroid/view/View;->setAlpha(F)V

    .line 1099
    invoke-virtual {p1, v0}, Landroid/view/View;->setTranslationY(F)V

    .line 1100
    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    .line 1103
    invoke-virtual {p1}, Landroid/view/View;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v1

    .line 1104
    const/high16 v3, 0x3f800000    # 1.0f

    invoke-virtual {v1, v3}, Landroid/view/ViewPropertyAnimator;->alpha(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v1

    .line 1105
    invoke-virtual {v1, v2}, Landroid/view/ViewPropertyAnimator;->translationY(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v1

    .line 1106
    const-wide/16 v2, 0x1b8

    invoke-virtual {v1, v2, v3}, Landroid/view/ViewPropertyAnimator;->setDuration(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v1

    .line 1107
    new-instance v2, Landroid/view/animation/DecelerateInterpolator;

    invoke-direct {v2}, Landroid/view/animation/DecelerateInterpolator;-><init>()V

    check-cast v2, Landroid/animation/TimeInterpolator;

    invoke-virtual {v1, v2}, Landroid/view/ViewPropertyAnimator;->setInterpolator(Landroid/animation/TimeInterpolator;)Landroid/view/ViewPropertyAnimator;

    move-result-object v1

    .line 1108
    invoke-virtual {v1}, Landroid/view/ViewPropertyAnimator;->start()V

    .line 1109
    return-void
.end method

.method static synthetic showTargetContainer$default(Lcom/roder300/kozen/MainActivity;Landroid/view/View;Ljava/lang/Boolean;ILjava/lang/Object;)V
    .locals 0

    .line 1092
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_0

    const/4 p2, 0x1

    invoke-static {p2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p2

    :cond_0
    invoke-direct {p0, p1, p2}, Lcom/roder300/kozen/MainActivity;->showTargetContainer(Landroid/view/View;Ljava/lang/Boolean;)V

    return-void
.end method

.method private final showTerminalId()V
    .locals 7

    .line 1287
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->sharedPreferences:Landroid/content/SharedPreferences;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    const-string v0, "sharedPreferences"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v0, v1

    :cond_0
    const-string v2, "terminal_id"

    const-string v3, ""

    invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1288
    .local v0, "terminalId":Ljava/lang/String;
    move-object v2, v0

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v3, 0x0

    if-eqz v2, :cond_2

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-nez v2, :cond_1

    goto :goto_0

    :cond_1
    const/4 v2, 0x0

    goto :goto_1

    :cond_2
    :goto_0
    const/4 v2, 0x1

    :goto_1
    if-nez v2, :cond_5

    .line 1289
    iget-object v2, p0, Lcom/roder300/kozen/MainActivity;->textTerminalId:Landroid/widget/TextView;

    const-string v4, "textTerminalId"

    if-nez v2, :cond_3

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v2, v1

    :cond_3
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "\u0422\u0435\u0440\u043c\u0438\u043d\u0430\u043b: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    check-cast v5, Ljava/lang/CharSequence;

    invoke-virtual {v2, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 1290
    iget-object v2, p0, Lcom/roder300/kozen/MainActivity;->textTerminalId:Landroid/widget/TextView;

    if-nez v2, :cond_4

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_2

    :cond_4
    move-object v1, v2

    :goto_2
    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setVisibility(I)V

    .line 1292
    :cond_5
    return-void
.end method

.method private final showTextScreen(Ljava/lang/String;)V
    .locals 8
    .param p1, "content"    # Ljava/lang/String;

    .line 1175
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->textContent:Landroid/widget/TextView;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    const-string v0, "textContent"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v0, v1

    :cond_0
    const/4 v6, 0x4

    const/4 v7, 0x0

    const-string v3, "\\n"

    const-string v4, "\n"

    const/4 v5, 0x0

    move-object v2, p1

    .end local p1    # "content":Ljava/lang/String;
    .local v2, "content":Ljava/lang/String;
    invoke-static/range {v2 .. v7}, Lkotlin/text/StringsKt;->replace$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    check-cast p1, Ljava/lang/CharSequence;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 1176
    const-string p1, "text"

    const/4 v0, 0x2

    invoke-static {p0, p1, v1, v0, v1}, Lcom/roder300/kozen/MainActivity;->showScreen$default(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;Ljava/lang/Boolean;ILjava/lang/Object;)V

    .line 1177
    return-void
.end method

.method private final startCardConfirmPolling(Ljava/lang/String;)V
    .locals 6
    .param p1, "source"    # Ljava/lang/String;

    iget-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isCardPolling:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isCardPolling:Z

    iput-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isPaymentLocked:Z

    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getServerUrl()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/roder300/kozen/MainActivity;->sharedPreferences:Landroid/content/SharedPreferences;

    const-string v2, "terminal_id"

    const-string v3, ""

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "uuid"

    const-string v4, ""

    invoke-interface {v1, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    new-instance v5, Lcom/roder300/kozen/CardConfirmPoller;

    move-object v4, v3

    move-object v3, v2

    move-object v2, v0

    move-object v1, p0

    move-object v0, v5

    move-object v5, p1

    invoke-direct/range {v0 .. v5}, Lcom/roder300/kozen/CardConfirmPoller;-><init>(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0}, Lcom/roder300/kozen/CardConfirmPoller;->start()V

    return-void
.end method

.method private final startFaceDetection()V
    .locals 5

    .line 1809
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->checkCameraHardware()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 1810
    const-string v0, "\u041e\u0448\u0438\u0431\u043a\u0430: \u041a\u0430\u043c\u0435\u0440\u0430 \u043d\u0435 \u0434\u043e\u0441\u0442\u0443\u043f\u043d\u0430 \u043d\u0430 \u0443\u0441\u0442\u0440\u043e\u0439\u0441\u0442\u0432\u0435"

    invoke-direct {p0, v0}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 1811
    move-object v0, p0

    check-cast v0, Landroid/content/Context;

    const-string v2, "\u041a\u0430\u043c\u0435\u0440\u0430 \u043d\u0435 \u0434\u043e\u0441\u0442\u0443\u043f\u043d\u0430"

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v0, v2, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 1812
    return-void

    .line 1815
    :cond_0
    nop

    .line 1816
    :try_start_0
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->resetDetectionState()V

    .line 1817
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->setupCamera()V

    .line 1818
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isDetecting:Z

    .line 1820
    const-string v0, "\u0417\u0430\u043f\u0443\u0441\u043a \u0440\u0430\u0441\u0448\u0438\u0440\u0435\u043d\u043d\u043e\u0433\u043e \u043e\u0431\u043d\u0430\u0440\u0443\u0436\u0435\u043d\u0438\u044f \u043b\u0438\u0446..."

    invoke-direct {p0, v0}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 1821
    iget v0, p0, Lcom/roder300/kozen/MainActivity;->requiredDetections:I

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u0422\u0440\u0435\u0431\u0443\u0435\u0442\u0441\u044f: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, " \u043f\u043e\u0441\u043b\u0435\u0434\u043e\u0432\u0430\u0442\u0435\u043b\u044c\u043d\u044b\u0445 \u043e\u0431\u043d\u0430\u0440\u0443\u0436\u0435\u043d\u0438\u0439"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 1822
    iget v0, p0, Lcom/roder300/kozen/MainActivity;->minConfidence:I

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u041c\u0438\u043d\u0438\u043c\u0430\u043b\u044c\u043d\u0430\u044f \u0434\u043e\u0441\u0442\u043e\u0432\u0435\u0440\u043d\u043e\u0441\u0442\u044c: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "%"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 1823
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->faceRecognitionPrepare:Landroid/widget/FrameLayout;

    const/4 v2, 0x0

    if-nez v0, :cond_1

    const-string v0, "faceRecognitionPrepare"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v0, v2

    :cond_1
    const/16 v3, 0x8

    invoke-virtual {v0, v3}, Landroid/widget/FrameLayout;->setVisibility(I)V

    .line 1824
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->faceRecognitionInView:Landroid/widget/FrameLayout;

    if-nez v0, :cond_2

    const-string v0, "faceRecognitionInView"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    move-object v2, v0

    :goto_0
    invoke-virtual {v2, v1}, Landroid/widget/FrameLayout;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 1828
    :catch_0
    move-exception v0

    .line 1829
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "\u041e\u0448\u0438\u0431\u043a\u0430 \u0437\u0430\u043f\u0443\u0441\u043a\u0430 \u043a\u0430\u043c\u0435\u0440\u044b: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 1830
    move-object v2, p0

    check-cast v2, Landroid/content/Context;

    const-string v3, "\u041e\u0448\u0438\u0431\u043a\u0430 \u0437\u0430\u043f\u0443\u0441\u043a\u0430 \u043a\u0430\u043c\u0435\u0440\u044b"

    check-cast v3, Ljava/lang/CharSequence;

    invoke-static {v2, v3, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/Toast;->show()V

    .line 1832
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_1
    return-void
.end method

.method public static synthetic startLottieAnimation$default(Lcom/roder300/kozen/MainActivity;Lcom/airbnb/lottie/LottieAnimationView;ZIFILjava/lang/Object;)V
    .locals 0

    .line 1135
    and-int/lit8 p6, p5, 0x2

    if-eqz p6, :cond_0

    .line 1137
    const/4 p2, 0x1

    .line 1135
    :cond_0
    and-int/lit8 p6, p5, 0x4

    if-eqz p6, :cond_1

    .line 1138
    const/4 p3, -0x1

    .line 1135
    :cond_1
    and-int/lit8 p5, p5, 0x8

    if-eqz p5, :cond_2

    .line 1139
    const/high16 p4, 0x3f800000    # 1.0f

    .line 1135
    :cond_2
    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/roder300/kozen/MainActivity;->startLottieAnimation(Lcom/airbnb/lottie/LottieAnimationView;ZIF)V

    return-void
.end method

.method private final startNfcListening()V
    .locals 12

    .line 663
    iget-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isNfcEnabled:Z

    const-string v1, "NFC"

    if-eqz v0, :cond_3

    iget-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isNfcListening:Z

    if-eqz v0, :cond_0

    goto/16 :goto_3

    .line 668
    :cond_0
    nop

    .line 669
    :try_start_0
    new-instance v0, Landroid/content/Intent;

    move-object v2, p0

    check-cast v2, Landroid/content/Context;

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-direct {v0, v2, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    move-object v2, v0

    .local v2, "$this$startNfcListening_u24lambda_u248\\1":Landroid/content/Intent;
    const/4 v3, 0x0

    .line 670
    .local v3, "$i$a$-apply-MainActivity$startNfcListening$intent$1\\1\\669\\0":I
    const/high16 v4, 0x20000000

    invoke-virtual {v2, v4}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 671
    nop

    .line 669
    .end local v2    # "$this$startNfcListening_u24lambda_u248\\1":Landroid/content/Intent;
    .end local v3    # "$i$a$-apply-MainActivity$startNfcListening$intent$1\\1\\669\\0":I
    nop

    .line 674
    .local v0, "intent":Landroid/content/Intent;
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x1f

    if-lt v2, v3, :cond_1

    .line 675
    const/high16 v2, 0xc000000

    goto :goto_0

    .line 677
    :cond_1
    const/high16 v2, 0x8000000

    .line 674
    :goto_0
    nop

    .line 681
    .local v2, "pendingIntentFlags":I
    move-object v3, p0

    check-cast v3, Landroid/content/Context;

    .line 680
    const/4 v4, 0x0

    invoke-static {v3, v4, v0, v2}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v3

    .line 686
    .local v3, "pendingIntent":Landroid/app/PendingIntent;
    const/4 v5, 0x3

    new-array v5, v5, [Landroid/content/IntentFilter;

    new-instance v6, Landroid/content/IntentFilter;

    const-string v7, "android.nfc.action.NDEF_DISCOVERED"

    invoke-direct {v6, v7}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    move-object v7, v6

    .local v7, "$this$startNfcListening_u24lambda_u249\\2":Landroid/content/IntentFilter;
    const/4 v8, 0x0

    .line 687
    .local v8, "$i$a$-apply-MainActivity$startNfcListening$intentFilters$1\\2\\686\\0":I
    :try_start_1
    const-string v9, "*/*"

    invoke-virtual {v7, v9}, Landroid/content/IntentFilter;->addDataType(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    :catch_0
    move-exception v9

    .line 688
    .local v9, "e\\2":Ljava/lang/Exception;
    :try_start_2
    const-string v10, "\u041e\u0448\u0438\u0431\u043a\u0430 \u0444\u0438\u043b\u044c\u0442\u0440\u0430"

    move-object v11, v9

    check-cast v11, Ljava/lang/Throwable;

    invoke-static {v1, v10, v11}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 690
    .end local v9    # "e\\2":Ljava/lang/Exception;
    :goto_1
    nop

    .end local v7    # "$this$startNfcListening_u24lambda_u249\\2":Landroid/content/IntentFilter;
    .end local v8    # "$i$a$-apply-MainActivity$startNfcListening$intentFilters$1\\2\\686\\0":I
    sget-object v7, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    .line 686
    aput-object v6, v5, v4

    .line 691
    new-instance v6, Landroid/content/IntentFilter;

    const-string v7, "android.nfc.action.TAG_DISCOVERED"

    invoke-direct {v6, v7}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    const/4 v7, 0x1

    aput-object v6, v5, v7

    .line 686
    nop

    .line 692
    new-instance v6, Landroid/content/IntentFilter;

    const-string v8, "android.nfc.action.TECH_DISCOVERED"

    invoke-direct {v6, v8}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    const/4 v8, 0x2

    aput-object v6, v5, v8

    .line 686
    nop

    .line 685
    nop

    .line 695
    .local v5, "intentFilters":[Landroid/content/IntentFilter;
    const-class v6, Landroid/nfc/tech/Ndef;

    invoke-virtual {v6}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/String;

    move-result-object v6

    new-array v8, v7, [[Ljava/lang/String;

    aput-object v6, v8, v4

    .line 697
    .local v8, "techLists":[[Ljava/lang/String;
    iget-object v4, p0, Lcom/roder300/kozen/MainActivity;->nfcAdapter:Landroid/nfc/NfcAdapter;

    if-eqz v4, :cond_2

    move-object v6, p0

    check-cast v6, Landroid/app/Activity;

    invoke-virtual {v4, v6, v3, v5, v8}, Landroid/nfc/NfcAdapter;->enableForegroundDispatch(Landroid/app/Activity;Landroid/app/PendingIntent;[Landroid/content/IntentFilter;[[Ljava/lang/String;)V

    .line 698
    :cond_2
    iput-boolean v7, p0, Lcom/roder300/kozen/MainActivity;->isNfcListening:Z

    .line 699
    const-string v4, "NFC \u0441\u043b\u0443\u0448\u0430\u0442\u0435\u043b\u044c \u0437\u0430\u043f\u0443\u0449\u0435\u043d"

    invoke-static {v1, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    .end local v0    # "intent":Landroid/content/Intent;
    .end local v2    # "pendingIntentFlags":I
    .end local v3    # "pendingIntent":Landroid/app/PendingIntent;
    .end local v5    # "intentFilters":[Landroid/content/IntentFilter;
    .end local v8    # "techLists":[[Ljava/lang/String;
    goto :goto_2

    .line 701
    :catch_1
    move-exception v0

    .line 702
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "\u041e\u0448\u0438\u0431\u043a\u0430 \u0437\u0430\u043f\u0443\u0441\u043a\u0430 NFC: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 703
    new-instance v1, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda7;

    invoke-direct {v1, p0, v0}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda7;-><init>(Lcom/roder300/kozen/MainActivity;Ljava/lang/Exception;)V

    invoke-virtual {p0, v1}, Lcom/roder300/kozen/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 707
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_2
    return-void

    .line 664
    :cond_3
    :goto_3
    iget-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isNfcEnabled:Z

    iget-boolean v2, p0, Lcom/roder300/kozen/MainActivity;->isNfcListening:Z

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "\u041d\u0435 \u043c\u043e\u0433\u0443 \u0437\u0430\u043f\u0443\u0441\u0442\u0438\u0442\u044c \u0441\u043b\u0443\u0448\u0430\u0442\u0435\u043b\u044c: enabled="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, ", listening="

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 665
    return-void
.end method

.method private static final startNfcListening$lambda$10(Lcom/roder300/kozen/MainActivity;Ljava/lang/Exception;)V
    .locals 4
    .param p0, "this$0"    # Lcom/roder300/kozen/MainActivity;
    .param p1, "$e"    # Ljava/lang/Exception;

    .line 704
    move-object v0, p0

    check-cast v0, Landroid/content/Context;

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u041e\u0448\u0438\u0431\u043a\u0430 \u0437\u0430\u043f\u0443\u0441\u043a\u0430 NFC: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 705
    return-void
.end method

.method private final startPayloadChecking()V
    .locals 2

    .line 778
    iget-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isCheckingPayload:Z

    if-nez v0, :cond_0

    .line 779
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isCheckingPayload:Z

    .line 780
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->handler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/roder300/kozen/MainActivity;->payloadCheckRunnable:Lcom/roder300/kozen/MainActivity$payloadCheckRunnable$1;

    check-cast v1, Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 782
    :cond_0
    return-void
.end method

.method private final startPreview()V
    .locals 8

    .line 1982
    const-string v0, " px"

    const-string v1, " - "

    .line 1983
    :try_start_0
    iget-object v2, p0, Lcom/roder300/kozen/MainActivity;->camera:Landroid/hardware/Camera;

    if-eqz v2, :cond_0

    invoke-virtual {v2}, Landroid/hardware/Camera;->getParameters()Landroid/hardware/Camera$Parameters;

    move-result-object v2

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    .line 1985
    .local v2, "params":Landroid/hardware/Camera$Parameters;
    :goto_0
    invoke-direct {p0, v2}, Lcom/roder300/kozen/MainActivity;->findBestPreviewSize(Landroid/hardware/Camera$Parameters;)Landroid/hardware/Camera$Size;

    move-result-object v3

    .line 1986
    .local v3, "previewSize":Landroid/hardware/Camera$Size;
    if-eqz v2, :cond_1

    iget v4, v3, Landroid/hardware/Camera$Size;->width:I

    iget v5, v3, Landroid/hardware/Camera$Size;->height:I

    invoke-virtual {v2, v4, v5}, Landroid/hardware/Camera$Parameters;->setPreviewSize(II)V

    .line 1987
    :cond_1
    if-eqz v2, :cond_2

    const/16 v4, 0x11

    invoke-virtual {v2, v4}, Landroid/hardware/Camera$Parameters;->setPreviewFormat(I)V

    .line 1990
    :cond_2
    iget v4, v3, Landroid/hardware/Camera$Size;->width:I

    iput v4, p0, Lcom/roder300/kozen/MainActivity;->previewWidth:I

    .line 1991
    iget v4, v3, Landroid/hardware/Camera$Size;->height:I

    iput v4, p0, Lcom/roder300/kozen/MainActivity;->previewHeight:I

    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->adjustCameraViewSize()V

    .line 1992
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->calculateCenterRanges()V

    .line 1994
    iget-object v4, p0, Lcom/roder300/kozen/MainActivity;->camera:Landroid/hardware/Camera;

    if-eqz v4, :cond_3

    invoke-virtual {v4, v2}, Landroid/hardware/Camera;->setParameters(Landroid/hardware/Camera$Parameters;)V

    .line 1995
    :cond_3
    iget-object v4, p0, Lcom/roder300/kozen/MainActivity;->camera:Landroid/hardware/Camera;

    if-eqz v4, :cond_4

    move-object v5, p0

    check-cast v5, Landroid/hardware/Camera$FaceDetectionListener;

    invoke-virtual {v4, v5}, Landroid/hardware/Camera;->setFaceDetectionListener(Landroid/hardware/Camera$FaceDetectionListener;)V

    .line 1996
    :cond_4
    iget-object v4, p0, Lcom/roder300/kozen/MainActivity;->camera:Landroid/hardware/Camera;

    if-eqz v4, :cond_5

    invoke-virtual {v4}, Landroid/hardware/Camera;->startPreview()V

    .line 1997
    :cond_5
    iget-object v4, p0, Lcom/roder300/kozen/MainActivity;->camera:Landroid/hardware/Camera;

    if-eqz v4, :cond_6

    invoke-virtual {v4}, Landroid/hardware/Camera;->startFaceDetection()V

    .line 1999
    :cond_6
    iget v4, v3, Landroid/hardware/Camera$Size;->width:I

    iget v5, v3, Landroid/hardware/Camera$Size;->height:I

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Preview \u0437\u0430\u043f\u0443\u0449\u0435\u043d ("

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, "x"

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ")"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v4}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 2000
    iget v4, p0, Lcom/roder300/kozen/MainActivity;->centerRangeStartX:I

    iget v5, p0, Lcom/roder300/kozen/MainActivity;->centerRangeEndX:I

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "\u0426\u0435\u043d\u0442\u0440\u0430\u043b\u044c\u043d\u0430\u044f \u043e\u0431\u043b\u0430\u0441\u0442\u044c X: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v4}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 2001
    iget v4, p0, Lcom/roder300/kozen/MainActivity;->centerRangeStartY:I

    iget v5, p0, Lcom/roder300/kozen/MainActivity;->centerRangeEndY:I

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "\u0426\u0435\u043d\u0442\u0440\u0430\u043b\u044c\u043d\u0430\u044f \u043e\u0431\u043b\u0430\u0441\u0442\u044c Y: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 2002
    const-string v0, "\u041e\u0431\u043d\u0430\u0440\u0443\u0436\u0435\u043d\u0438\u0435 \u043b\u0438\u0446 \u0430\u043a\u0442\u0438\u0432\u0438\u0440\u043e\u0432\u0430\u043d\u043e"

    invoke-direct {p0, v0}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 2003
    const-string v0, "\u041f\u043e\u0441\u043c\u043e\u0442\u0440\u0438\u0442\u0435 \u0432 \u043a\u0430\u043c\u0435\u0440\u0443"

    invoke-virtual {p0, v0}, Lcom/roder300/kozen/MainActivity;->setTextDesc(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v2    # "params":Landroid/hardware/Camera$Parameters;
    .end local v3    # "previewSize":Landroid/hardware/Camera$Size;
    goto :goto_1

    .line 2005
    :catch_0
    move-exception v0

    .line 2006
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u041e\u0448\u0438\u0431\u043a\u0430 \u0437\u0430\u043f\u0443\u0441\u043a\u0430 preview: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 2008
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_1
    return-void
.end method

.method private final startProximityPolling()V
    .locals 5

    .line 515
    iget-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isProximitySensorActive:Z

    if-eqz v0, :cond_0

    return-void

    .line 517
    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isProximitySensorActive:Z

    .line 518
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isNearDetected:Z

    .line 519
    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lcom/roder300/kozen/MainActivity;->proximityStartTime:J

    .line 520
    iput v0, p0, Lcom/roder300/kozen/MainActivity;->detectionCount:I

    .line 523
    const-string v1, "sensor"

    invoke-virtual {p0, v1}, Lcom/roder300/kozen/MainActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    const-string v2, "null cannot be cast to non-null type android.hardware.SensorManager"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v1, Landroid/hardware/SensorManager;

    iput-object v1, p0, Lcom/roder300/kozen/MainActivity;->sensorManager:Landroid/hardware/SensorManager;

    .line 524
    iget-object v1, p0, Lcom/roder300/kozen/MainActivity;->sensorManager:Landroid/hardware/SensorManager;

    const/4 v2, 0x0

    if-eqz v1, :cond_1

    const/16 v3, 0x8

    invoke-virtual {v1, v3}, Landroid/hardware/SensorManager;->getDefaultSensor(I)Landroid/hardware/Sensor;

    move-result-object v1

    goto :goto_0

    :cond_1
    move-object v1, v2

    :goto_0
    iput-object v1, p0, Lcom/roder300/kozen/MainActivity;->proximitySensor:Landroid/hardware/Sensor;

    .line 526
    iget-object v1, p0, Lcom/roder300/kozen/MainActivity;->proximitySensor:Landroid/hardware/Sensor;

    if-nez v1, :cond_2

    .line 527
    move-object v1, p0

    check-cast v1, Landroid/content/Context;

    const-string v2, "\u0414\u0430\u0442\u0447\u0438\u043a \u043f\u0440\u0438\u0431\u043b\u0438\u0436\u0435\u043d\u0438\u044f \u043d\u0435 \u043d\u0430\u0439\u0434\u0435\u043d"

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v1, v2, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/Toast;->show()V

    .line 528
    iput-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isProximitySensorActive:Z

    .line 529
    return-void

    .line 531
    :cond_2
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->checkSensorType()V

    .line 532
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->checkSensorReportingMode()V

    .line 535
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->sensorManager:Landroid/hardware/SensorManager;

    if-eqz v0, :cond_3

    .line 536
    iget-object v1, p0, Lcom/roder300/kozen/MainActivity;->proximitySensorListener:Lcom/roder300/kozen/MainActivity$proximitySensorListener$1;

    check-cast v1, Landroid/hardware/SensorEventListener;

    .line 537
    iget-object v3, p0, Lcom/roder300/kozen/MainActivity;->proximitySensor:Landroid/hardware/Sensor;

    .line 538
    nop

    .line 539
    nop

    .line 535
    const v4, 0xc350

    invoke-virtual {v0, v1, v3, v4, v4}, Landroid/hardware/SensorManager;->registerListener(Landroid/hardware/SensorEventListener;Landroid/hardware/Sensor;II)Z

    .line 543
    :cond_3
    new-instance v0, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda5;

    invoke-direct {v0, p0}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda5;-><init>(Lcom/roder300/kozen/MainActivity;)V

    iput-object v0, p0, Lcom/roder300/kozen/MainActivity;->proximityCheckRunnable:Ljava/lang/Runnable;

    .line 557
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->handler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/roder300/kozen/MainActivity;->proximityCheckRunnable:Ljava/lang/Runnable;

    if-nez v1, :cond_4

    const-string v1, "proximityCheckRunnable"

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_1

    :cond_4
    move-object v2, v1

    :goto_1
    invoke-virtual {v0, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 558
    return-void
.end method

.method private static final startProximityPolling$lambda$6(Lcom/roder300/kozen/MainActivity;)V
    .locals 9
    .param p0, "this$0"    # Lcom/roder300/kozen/MainActivity;

    .line 544
    const/4 v0, 0x0

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-static {p0, v0, v1, v2}, Lcom/roder300/kozen/MainActivity;->checkProximityState$default(Lcom/roder300/kozen/MainActivity;ZILjava/lang/Object;)V

    .line 545
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    .line 548
    .local v3, "currentTime":J
    iget-wide v5, p0, Lcom/roder300/kozen/MainActivity;->lastUpdateTime:J

    sub-long v5, v3, v5

    const-wide/16 v7, 0x64

    cmp-long v0, v5, v7

    if-lez v0, :cond_0

    .line 549
    iget v0, p0, Lcom/roder300/kozen/MainActivity;->lastKnownValue:F

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "No update, using last value: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v5, " cm"

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v5, "Proximity"

    invoke-static {v5, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 550
    invoke-direct {p0, v1}, Lcom/roder300/kozen/MainActivity;->checkProximityState(Z)V

    .line 552
    :cond_0
    iget-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isProximitySensorActive:Z

    if-eqz v0, :cond_2

    .line 553
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->handler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/roder300/kozen/MainActivity;->proximityCheckRunnable:Ljava/lang/Runnable;

    if-nez v1, :cond_1

    const-string v1, "proximityCheckRunnable"

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    move-object v2, v1

    :goto_0
    invoke-virtual {v0, v2, v7, v8}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 555
    :cond_2
    return-void
.end method

.method private final startSensorCard()V
    .locals 3

    .line 464
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->checkProximitySensor()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 465
    const-string v0, "Sensor"

    const-string v1, "\u0418\u0441\u043f\u043e\u043b\u044c\u0437\u0443\u0435\u0442\u0441\u044f \u0434\u0430\u0442\u0447\u0438\u043a \u043f\u0440\u0438\u0431\u043b\u0438\u0436\u0435\u043d\u0438\u044f"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 466
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->startProximityPolling()V

    goto :goto_0

    .line 471
    :cond_0
    move-object v0, p0

    check-cast v0, Landroid/content/Context;

    const-string v1, "\u0414\u0430\u0442\u0447\u0438\u043a\u0438 \u043f\u0440\u0438\u0431\u043b\u0438\u0436\u0435\u043d\u0438\u044f \u043d\u0435 \u0434\u043e\u0441\u0442\u0443\u043f\u043d\u044b"

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 473
    :goto_0
    return-void
.end method

.method private final startSensorCardOld()V
    .locals 3

    .line 452
    const-string v0, "sensor"

    invoke-virtual {p0, v0}, Lcom/roder300/kozen/MainActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    const-string v1, "null cannot be cast to non-null type android.hardware.SensorManager"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Landroid/hardware/SensorManager;

    iput-object v0, p0, Lcom/roder300/kozen/MainActivity;->sensorManager:Landroid/hardware/SensorManager;

    .line 453
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->sensorManager:Landroid/hardware/SensorManager;

    if-eqz v0, :cond_0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/hardware/SensorManager;->getDefaultSensor(I)Landroid/hardware/Sensor;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iput-object v0, p0, Lcom/roder300/kozen/MainActivity;->proximitySensor:Landroid/hardware/Sensor;

    .line 455
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->proximitySensor:Landroid/hardware/Sensor;

    if-nez v0, :cond_1

    .line 456
    move-object v0, p0

    check-cast v0, Landroid/content/Context;

    const-string v1, "\u0414\u0430\u0442\u0447\u0438\u043a \u043f\u0440\u0438\u0431\u043b\u0438\u0436\u0435\u043d\u0438\u044f \u043d\u0435 \u043d\u0430\u0439\u0434\u0435\u043d"

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 457
    return-void

    .line 460
    :cond_1
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->startProximityPolling()V

    .line 461
    return-void
.end method

.method private final startSmoothEaseOutAnimation(Landroid/widget/ImageView;)V
    .locals 12
    .param p1, "textImageView"    # Landroid/widget/ImageView;

    .line 1459
    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 1462
    new-instance v1, Landroid/view/animation/PathInterpolator;

    const v2, 0x3f147ae1    # 0.58f

    const/high16 v3, 0x3f800000    # 1.0f

    const/4 v4, 0x0

    invoke-direct {v1, v4, v4, v2, v3}, Landroid/view/animation/PathInterpolator;-><init>(FFFF)V

    .line 1465
    .local v1, "easeOutInterpolator":Landroid/view/animation/PathInterpolator;
    const/4 v2, 0x2

    new-array v3, v2, [F

    fill-array-data v3, :array_0

    const-string v4, "alpha"

    invoke-static {p1, v4, v3}, Landroid/animation/ObjectAnimator;->ofFloat(Ljava/lang/Object;Ljava/lang/String;[F)Landroid/animation/ObjectAnimator;

    move-result-object v3

    .line 1466
    .local v3, "alphaAnimator":Landroid/animation/ObjectAnimator;
    const-wide/16 v4, 0x3e8

    invoke-virtual {v3, v4, v5}, Landroid/animation/ObjectAnimator;->setDuration(J)Landroid/animation/ObjectAnimator;

    .line 1467
    move-object v6, v1

    check-cast v6, Landroid/animation/TimeInterpolator;

    invoke-virtual {v3, v6}, Landroid/animation/ObjectAnimator;->setInterpolator(Landroid/animation/TimeInterpolator;)V

    .line 1469
    nop

    .line 1470
    const/high16 v6, 0x42a00000    # 80.0f

    invoke-direct {p0, v6}, Lcom/roder300/kozen/MainActivity;->dpToPx(F)F

    move-result v6

    const/high16 v7, 0x41700000    # 15.0f

    invoke-direct {p0, v7}, Lcom/roder300/kozen/MainActivity;->dpToPx(F)F

    move-result v7

    new-array v8, v2, [F

    aput v6, v8, v0

    const/4 v6, 0x1

    aput v7, v8, v6

    .line 1469
    const-string v7, "translationY"

    invoke-static {p1, v7, v8}, Landroid/animation/ObjectAnimator;->ofFloat(Ljava/lang/Object;Ljava/lang/String;[F)Landroid/animation/ObjectAnimator;

    move-result-object v7

    .line 1471
    .local v7, "translationAnimator":Landroid/animation/ObjectAnimator;
    const-wide/16 v8, 0x2ee

    invoke-virtual {v7, v8, v9}, Landroid/animation/ObjectAnimator;->setDuration(J)Landroid/animation/ObjectAnimator;

    .line 1472
    move-object v8, v1

    check-cast v8, Landroid/animation/TimeInterpolator;

    invoke-virtual {v7, v8}, Landroid/animation/ObjectAnimator;->setInterpolator(Landroid/animation/TimeInterpolator;)V

    .line 1474
    new-array v8, v2, [F

    fill-array-data v8, :array_1

    const-string v9, "scaleX"

    invoke-static {p1, v9, v8}, Landroid/animation/ObjectAnimator;->ofFloat(Ljava/lang/Object;Ljava/lang/String;[F)Landroid/animation/ObjectAnimator;

    move-result-object v8

    .line 1475
    .local v8, "scaleXAnimator":Landroid/animation/ObjectAnimator;
    const-wide/16 v9, 0x28a

    invoke-virtual {v8, v9, v10}, Landroid/animation/ObjectAnimator;->setDuration(J)Landroid/animation/ObjectAnimator;

    .line 1476
    move-object v9, v1

    check-cast v9, Landroid/animation/TimeInterpolator;

    invoke-virtual {v8, v9}, Landroid/animation/ObjectAnimator;->setInterpolator(Landroid/animation/TimeInterpolator;)V

    .line 1478
    new-array v9, v2, [F

    fill-array-data v9, :array_2

    const-string v10, "scaleY"

    invoke-static {p1, v10, v9}, Landroid/animation/ObjectAnimator;->ofFloat(Ljava/lang/Object;Ljava/lang/String;[F)Landroid/animation/ObjectAnimator;

    move-result-object v9

    .line 1479
    .local v9, "scaleYAnimator":Landroid/animation/ObjectAnimator;
    const-wide/16 v10, 0x1c2

    invoke-virtual {v9, v10, v11}, Landroid/animation/ObjectAnimator;->setDuration(J)Landroid/animation/ObjectAnimator;

    .line 1480
    move-object v10, v1

    check-cast v10, Landroid/animation/TimeInterpolator;

    invoke-virtual {v9, v10}, Landroid/animation/ObjectAnimator;->setInterpolator(Landroid/animation/TimeInterpolator;)V

    .line 1483
    new-instance v10, Landroid/animation/AnimatorSet;

    invoke-direct {v10}, Landroid/animation/AnimatorSet;-><init>()V

    .line 1484
    .local v10, "animatorSet":Landroid/animation/AnimatorSet;
    const/4 v11, 0x4

    new-array v11, v11, [Landroid/animation/Animator;

    aput-object v3, v11, v0

    aput-object v7, v11, v6

    aput-object v8, v11, v2

    const/4 v0, 0x3

    aput-object v9, v11, v0

    invoke-virtual {v10, v11}, Landroid/animation/AnimatorSet;->playTogether([Landroid/animation/Animator;)V

    .line 1485
    invoke-virtual {v10}, Landroid/animation/AnimatorSet;->start()V

    .line 1488
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v2

    invoke-direct {v0, v2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v2, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda2;

    invoke-direct {v2, p1, p0}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda2;-><init>(Landroid/widget/ImageView;Lcom/roder300/kozen/MainActivity;)V

    .line 1492
    nop

    .line 1488
    invoke-virtual {v0, v2, v4, v5}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 1493
    return-void

    nop

    :array_0
    .array-data 4
        0x0
        0x3f800000    # 1.0f
    .end array-data

    :array_1
    .array-data 4
        0x3f733333    # 0.95f
        0x3f800000    # 1.0f
    .end array-data

    :array_2
    .array-data 4
        0x3f733333    # 0.95f
        0x3f800000    # 1.0f
    .end array-data
.end method

.method private static final startSmoothEaseOutAnimation$lambda$36(Landroid/widget/ImageView;Lcom/roder300/kozen/MainActivity;)V
    .locals 2
    .param p0, "$textImageView"    # Landroid/widget/ImageView;
    .param p1, "this$0"    # Lcom/roder300/kozen/MainActivity;

    .line 1489
    invoke-virtual {p0}, Landroid/widget/ImageView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    const-string v1, "null cannot be cast to non-null type androidx.constraintlayout.widget.ConstraintLayout.LayoutParams"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;

    .line 1490
    .local v0, "params":Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;
    const/16 v1, 0xf

    invoke-direct {p1, v1}, Lcom/roder300/kozen/MainActivity;->dpToPx(I)I

    move-result v1

    iput v1, v0, Landroidx/constraintlayout/widget/ConstraintLayout$LayoutParams;->bottomMargin:I

    .line 1491
    move-object v1, v0

    check-cast v1, Landroid/view/ViewGroup$LayoutParams;

    invoke-virtual {p0, v1}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 1492
    return-void
.end method

.method private final startVideoPlayback()V
    .locals 4

    .line 1648
    iget-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isVideoPrepared:Z

    if-eqz v0, :cond_1

    .line 1649
    nop

    .line 1650
    :try_start_0
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->videoBackground:Landroid/widget/VideoView;

    if-nez v0, :cond_0

    const-string v0, "videoBackground"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v0, 0x0

    :cond_0
    invoke-virtual {v0}, Landroid/widget/VideoView;->start()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 1651
    :catch_0
    move-exception v0

    .line 1652
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u041e\u0448\u0438\u0431\u043a\u0430 \u0432\u043e\u0441\u043f\u0440\u043e\u0438\u0437\u0432\u0435\u0434\u0435\u043d\u0438\u044f \u0432\u0438\u0434\u0435\u043e: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "VideoPlayback"

    invoke-static {v2, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1655
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_1
    :goto_0
    return-void
.end method

.method private final stopFaceDetection()V
    .locals 4

    .line 1844
    nop

    .line 1845
    :try_start_0
    iget-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isFaceUploading:Z

    if-nez v0, :cond_1

    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->releaseCamera()V

    .line 1847
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->cameraContainer:Landroid/widget/FrameLayout;

    if-nez v0, :cond_0

    const-string v0, "cameraContainer"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v0, 0x0

    :cond_0
    invoke-virtual {v0}, Landroid/widget/FrameLayout;->removeAllViews()V

    .line 1846
    :cond_1
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isDetecting:Z

    .line 1848
    iget v0, p0, Lcom/roder300/kozen/MainActivity;->faceDetectionCount:I

    iget v1, p0, Lcom/roder300/kozen/MainActivity;->requiredDetections:I

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u0420\u0430\u0441\u043f\u043e\u0437\u043d\u0430\u0432\u0430\u043d\u0438\u0435 \u043e\u0441\u0442\u0430\u043d\u043e\u0432\u043b\u0435\u043d\u043e. \u041e\u0431\u043d\u0430\u0440\u0443\u0436\u0435\u043d\u043e: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "/"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 1849
    :catch_0
    move-exception v0

    .line 1850
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u041e\u0448\u0438\u0431\u043a\u0430 \u043f\u0440\u0438 \u043e\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0435: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 1852
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method private final stopNfcListening()V
    .locals 5

    .line 710
    const-string v0, "NFC"

    iget-boolean v1, p0, Lcom/roder300/kozen/MainActivity;->isNfcListening:Z

    if-nez v1, :cond_0

    return-void

    .line 712
    :cond_0
    nop

    .line 713
    :try_start_0
    iget-object v1, p0, Lcom/roder300/kozen/MainActivity;->nfcAdapter:Landroid/nfc/NfcAdapter;

    if-eqz v1, :cond_1

    move-object v2, p0

    check-cast v2, Landroid/app/Activity;

    invoke-virtual {v1, v2}, Landroid/nfc/NfcAdapter;->disableForegroundDispatch(Landroid/app/Activity;)V

    .line 714
    :cond_1
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/roder300/kozen/MainActivity;->isNfcListening:Z

    .line 715
    const-string v1, "NFC \u0441\u043b\u0443\u0448\u0430\u0442\u0435\u043b\u044c \u043e\u0441\u0442\u0430\u043d\u043e\u0432\u043b\u0435\u043d"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 716
    :catch_0
    move-exception v1

    .line 717
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "\u041e\u0448\u0438\u0431\u043a\u0430 \u043e\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0438 NFC: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 719
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method private final stopPayloadChecking()V
    .locals 2

    .line 785
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isCheckingPayload:Z

    .line 786
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->handler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/roder300/kozen/MainActivity;->payloadCheckRunnable:Lcom/roder300/kozen/MainActivity$payloadCheckRunnable$1;

    check-cast v1, Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 787
    return-void
.end method

.method private final stopPreview()V
    .locals 4

    .line 2049
    nop

    .line 2050
    :try_start_0
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->camera:Landroid/hardware/Camera;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/hardware/Camera;->stopFaceDetection()V

    .line 2051
    :cond_0
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->camera:Landroid/hardware/Camera;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/hardware/Camera;->stopPreview()V

    .line 2052
    :cond_1
    const-string v0, "Preview \u043e\u0441\u0442\u0430\u043d\u043e\u0432\u043b\u0435\u043d"

    invoke-direct {p0, v0}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 2053
    :catch_0
    move-exception v0

    .line 2054
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u041e\u0448\u0438\u0431\u043a\u0430 \u043e\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0438 preview: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 2056
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method private final stopSensorCard()V
    .locals 2

    .line 561
    iget-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isProximitySensorActive:Z

    if-eqz v0, :cond_2

    .line 562
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isProximitySensorActive:Z

    .line 563
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->handler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/roder300/kozen/MainActivity;->proximityCheckRunnable:Ljava/lang/Runnable;

    if-nez v1, :cond_0

    const-string v1, "proximityCheckRunnable"

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v1, 0x0

    :cond_0
    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 564
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->sensorManager:Landroid/hardware/SensorManager;

    if-eqz v0, :cond_1

    iget-object v1, p0, Lcom/roder300/kozen/MainActivity;->proximitySensorListener:Lcom/roder300/kozen/MainActivity$proximitySensorListener$1;

    check-cast v1, Landroid/hardware/SensorEventListener;

    invoke-virtual {v0, v1}, Landroid/hardware/SensorManager;->unregisterListener(Landroid/hardware/SensorEventListener;)V

    .line 565
    :cond_1
    const-string v0, "Proximity"

    const-string v1, "Sensor polling stopped"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 567
    :cond_2
    return-void
.end method

.method private final stopVideoPlayback()V
    .locals 3

    .line 1658
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->videoBackground:Landroid/widget/VideoView;

    const/4 v1, 0x0

    const-string v2, "videoBackground"

    if-nez v0, :cond_0

    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v0, v1

    :cond_0
    invoke-virtual {v0}, Landroid/widget/VideoView;->isPlaying()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 1659
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->videoBackground:Landroid/widget/VideoView;

    if-nez v0, :cond_1

    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v0, v1

    :cond_1
    invoke-virtual {v0}, Landroid/widget/VideoView;->pause()V

    .line 1660
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->videoBackground:Landroid/widget/VideoView;

    if-nez v0, :cond_2

    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    move-object v1, v0

    :goto_0
    const/4 v0, 0x0

    invoke-virtual {v1, v0}, Landroid/widget/VideoView;->seekTo(I)V

    .line 1662
    :cond_3
    return-void
.end method

.method private final waitForAnimationCompletion(Lcom/airbnb/lottie/LottieAnimationView;Lkotlin/jvm/functions/Function0;)V
    .locals 1
    .param p1, "animationView"    # Lcom/airbnb/lottie/LottieAnimationView;
    .param p2, "callback"    # Lkotlin/jvm/functions/Function0;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/airbnb/lottie/LottieAnimationView;",
            "Lkotlin/jvm/functions/Function0<",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    .line 1122
    new-instance v0, Lcom/roder300/kozen/MainActivity$waitForAnimationCompletion$1;

    invoke-direct {v0, p1, p2}, Lcom/roder300/kozen/MainActivity$waitForAnimationCompletion$1;-><init>(Lcom/airbnb/lottie/LottieAnimationView;Lkotlin/jvm/functions/Function0;)V

    check-cast v0, Landroid/animation/ValueAnimator$AnimatorUpdateListener;

    invoke-virtual {p1, v0}, Lcom/airbnb/lottie/LottieAnimationView;->addAnimatorUpdateListener(Landroid/animation/ValueAnimator$AnimatorUpdateListener;)V

    .line 1133
    return-void
.end method


# virtual methods
.method public dispatchTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 8

    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->dispatchTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v0

    return v0
.end method

.method public final doNotBlockScreen(Z)V
    .locals 2
    .param p1, "enable"    # Z

    .line 294
    iput-boolean p1, p0, Lcom/roder300/kozen/MainActivity;->keepScreenOn:Z

    .line 296
    const/16 v0, 0x80

    if-eqz p1, :cond_0

    .line 298
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/view/Window;->addFlags(I)V

    .line 299
    const-string v0, "\u042d\u043a\u0440\u0430\u043d \u043d\u0435 \u0431\u0443\u0434\u0435\u0442 \u0431\u043b\u043e\u043a\u0438\u0440\u043e\u0432\u0430\u0442\u044c\u0441\u044f"

    invoke-direct {p0, v0}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    goto :goto_0

    .line 302
    :cond_0
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/view/Window;->clearFlags(I)V

    .line 303
    const-string v0, "\u041d\u043e\u0440\u043c\u0430\u043b\u044c\u043d\u044b\u0439 \u0440\u0435\u0436\u0438\u043c \u0431\u043b\u043e\u043a\u0438\u0440\u043e\u0432\u043a\u0438 \u044d\u043a\u0440\u0430\u043d\u0430"

    invoke-direct {p0, v0}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 307
    :goto_0
    invoke-direct {p0, p1}, Lcom/roder300/kozen/MainActivity;->adjustScreenTimeout(Z)V

    .line 308
    return-void
.end method

.method public final formatAmount(Ljava/lang/String;)Ljava/lang/String;
    .locals 20
    .param p1, "amount"    # Ljava/lang/String;

    move-object/from16 v1, p1

    const-string v7, " \u20bd"

    const-string v0, "amount"

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1112
    nop

    .line 1113
    :try_start_0
    const-string v2, ","

    const-string v3, "."

    const/4 v5, 0x4

    const/4 v6, 0x0

    const/4 v4, 0x0

    invoke-static/range {v1 .. v6}, Lkotlin/text/StringsKt;->replace$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D

    move-result-wide v2

    .line 1114
    .local v2, "parsedAmount":D
    new-instance v0, Ljava/text/DecimalFormat;

    const-string v4, "#,##0.##"

    new-instance v5, Ljava/text/DecimalFormatSymbols;

    sget-object v6, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-direct {v5, v6}, Ljava/text/DecimalFormatSymbols;-><init>(Ljava/util/Locale;)V

    invoke-direct {v0, v4, v5}, Ljava/text/DecimalFormat;-><init>(Ljava/lang/String;Ljava/text/DecimalFormatSymbols;)V

    .line 1115
    .local v0, "formatter":Ljava/text/DecimalFormat;
    invoke-virtual {v0, v2, v3}, Ljava/text/DecimalFormat;->format(D)Ljava/lang/String;

    move-result-object v8

    const-string v4, "format(...)"

    invoke-static {v8, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v9, ","

    const-string v10, " "

    const/4 v12, 0x4

    const/4 v13, 0x0

    const/4 v11, 0x0

    invoke-static/range {v8 .. v13}, Lkotlin/text/StringsKt;->replace$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v14

    const-string v15, "."

    const-string v16, ","

    const/16 v18, 0x4

    const/16 v19, 0x0

    const/16 v17, 0x0

    invoke-static/range {v14 .. v19}, Lkotlin/text/StringsKt;->replace$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "formatter":Ljava/text/DecimalFormat;
    .end local v2    # "parsedAmount":D
    goto :goto_0

    .line 1116
    :catch_0
    move-exception v0

    .line 1117
    .local v0, "e":Ljava/lang/NumberFormatException;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 1112
    .end local v0    # "e":Ljava/lang/NumberFormatException;
    :goto_0
    return-object v4
.end method

.method public final generateQRCodeWithRoundedCorners(Ljava/lang/String;Landroid/widget/ImageView;IIIF)V
    .locals 12
    .param p1, "text"    # Ljava/lang/String;
    .param p2, "imageView"    # Landroid/widget/ImageView;
    .param p3, "size"    # I
    .param p4, "color"    # I
    .param p5, "backgroundColor"    # I
    .param p6, "cornerRadius"    # F

    const-string v0, "text"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "imageView"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 398
    nop

    .line 399
    :try_start_0
    new-instance v0, Ljava/util/EnumMap;

    const-class v1, Lcom/google/zxing/EncodeHintType;

    invoke-direct {v0, v1}, Ljava/util/EnumMap;-><init>(Ljava/lang/Class;)V

    .line 400
    .local v0, "hints":Ljava/util/EnumMap;
    move-object v1, v0

    check-cast v1, Ljava/util/Map;

    sget-object v2, Lcom/google/zxing/EncodeHintType;->MARGIN:Lcom/google/zxing/EncodeHintType;

    const/4 v3, 0x1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 401
    move-object v1, v0

    check-cast v1, Ljava/util/Map;

    sget-object v2, Lcom/google/zxing/EncodeHintType;->CHARACTER_SET:Lcom/google/zxing/EncodeHintType;

    const-string v3, "UTF-8"

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 403
    new-instance v4, Lcom/google/zxing/MultiFormatWriter;

    invoke-direct {v4}, Lcom/google/zxing/MultiFormatWriter;-><init>()V

    .line 404
    nop

    .line 405
    sget-object v6, Lcom/google/zxing/BarcodeFormat;->QR_CODE:Lcom/google/zxing/BarcodeFormat;

    .line 406
    nop

    .line 407
    nop

    .line 408
    move-object v9, v0

    check-cast v9, Ljava/util/Map;

    .line 403
    move v8, p3

    move-object v5, p1

    move v7, p3

    invoke-virtual/range {v4 .. v9}, Lcom/google/zxing/MultiFormatWriter;->encode(Ljava/lang/String;Lcom/google/zxing/BarcodeFormat;IILjava/util/Map;)Lcom/google/zxing/common/BitMatrix;

    move-result-object v1

    const-string v2, "encode(...)"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 411
    .local v1, "bitMatrix":Lcom/google/zxing/common/BitMatrix;
    sget-object v2, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {p3, p3, v2}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v2

    const-string v3, "createBitmap(...)"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 412
    .local v2, "bitmap":Landroid/graphics/Bitmap;
    new-instance v3, Landroid/graphics/Canvas;

    invoke-direct {v3, v2}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    .line 413
    .local v3, "canvas":Landroid/graphics/Canvas;
    new-instance v4, Landroid/graphics/Paint;

    invoke-direct {v4}, Landroid/graphics/Paint;-><init>()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_2

    .line 416
    .local v4, "paint":Landroid/graphics/Paint;
    move/from16 v5, p5

    :try_start_1
    invoke-virtual {v3, v5}, Landroid/graphics/Canvas;->drawColor(I)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 419
    move/from16 v6, p4

    :try_start_2
    invoke-virtual {v4, v6}, Landroid/graphics/Paint;->setColor(I)V

    .line 420
    const/4 v8, 0x0

    .local v8, "x":I
    :goto_0
    if-ge v8, p3, :cond_2

    .line 421
    const/4 v9, 0x0

    .local v9, "y":I
    :goto_1
    if-ge v9, p3, :cond_1

    .line 422
    invoke-virtual {v1, v8, v9}, Lcom/google/zxing/common/BitMatrix;->get(II)Z

    move-result v10

    if-eqz v10, :cond_0

    .line 423
    int-to-float v10, v8

    int-to-float v11, v9

    invoke-virtual {v3, v10, v11, v4}, Landroid/graphics/Canvas;->drawPoint(FFLandroid/graphics/Paint;)V

    .line 421
    :cond_0
    add-int/lit8 v9, v9, 0x1

    goto :goto_1

    .line 420
    .end local v9    # "y":I
    :cond_1
    add-int/lit8 v8, v8, 0x1

    goto :goto_0

    .line 428
    .end local v8    # "x":I
    :cond_2
    invoke-virtual {p2, v2}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    .end local v0    # "hints":Ljava/util/EnumMap;
    .end local v1    # "bitMatrix":Lcom/google/zxing/common/BitMatrix;
    .end local v2    # "bitmap":Landroid/graphics/Bitmap;
    .end local v3    # "canvas":Landroid/graphics/Canvas;
    .end local v4    # "paint":Landroid/graphics/Paint;
    goto :goto_3

    .line 430
    :catch_0
    move-exception v0

    goto :goto_2

    :catch_1
    move-exception v0

    move/from16 v6, p4

    goto :goto_2

    :catch_2
    move-exception v0

    move/from16 v6, p4

    move/from16 v5, p5

    .line 431
    .local v0, "e":Ljava/lang/Exception;
    :goto_2
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 433
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_3
    return-void
.end method

.method public final getLastKnownValue()F
    .locals 1

    .line 511
    iget v0, p0, Lcom/roder300/kozen/MainActivity;->lastKnownValue:F

    return v0
.end method

.method public final getLastUpdateTime()J
    .locals 2

    .line 512
    iget-wide v0, p0, Lcom/roder300/kozen/MainActivity;->lastUpdateTime:J

    return-wide v0
.end method

.method public final getMaxRange()F
    .locals 1

    .line 513
    iget v0, p0, Lcom/roder300/kozen/MainActivity;->maxRange:F

    return v0
.end method

.method public getServerUrl()Ljava/lang/String;
    .locals 2

    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->sharedPreferences:Landroid/content/SharedPreferences;

    const-string v1, "server_url"

    const-string p0, "https://sberpos-api.onrender.com"

    invoke-interface {v0, v1, p0}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getSharedPreferences()Landroid/content/SharedPreferences;
    .locals 1

    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->sharedPreferences:Landroid/content/SharedPreferences;

    return-object v0
.end method

.method public onBackPressed()V
    .locals 0

    .line 1693
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 7
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 192
    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->onCreate(Landroid/os/Bundle;)V

    .line 193
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->setFullScreenMode()V

    .line 194
    sget v0, Lcom/roder300/kozen/R$layout;->activity_main:I

    invoke-virtual {p0, v0}, Lcom/roder300/kozen/MainActivity;->setContentView(I)V

    .line 196
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->initViewsCam()V

    .line 197
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/roder300/kozen/MainActivity;->doNotBlockScreen(Z)V

    .line 198
    sget-object v1, Landroid/os/Build;->PRODUCT:Ljava/lang/String;

    const-string v2, "CPH2477RU"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    sget-object v1, Landroid/os/Build;->PRODUCT:Ljava/lang/String;

    const-string v2, "4047D"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 199
    :cond_0
    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->rotateToUpsideDown()V

    .line 203
    :cond_1
    move-object v1, p0

    check-cast v1, Landroid/content/Context;

    sget v2, Lcom/roder300/kozen/R$anim;->slide_up_fade_in:I

    invoke-static {v1, v2}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v1

    iput-object v1, p0, Lcom/roder300/kozen/MainActivity;->slideUpFadeIn:Landroid/view/animation/Animation;

    .line 204
    move-object v1, p0

    check-cast v1, Landroid/content/Context;

    sget v2, Lcom/roder300/kozen/R$anim;->fade_out:I

    invoke-static {v1, v2}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v1

    iput-object v1, p0, Lcom/roder300/kozen/MainActivity;->fadeOut:Landroid/view/animation/Animation;

    .line 207
    sget v1, Lcom/roder300/kozen/R$id;->videoBackground:I

    invoke-virtual {p0, v1}, Lcom/roder300/kozen/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/VideoView;

    iput-object v1, p0, Lcom/roder300/kozen/MainActivity;->videoBackground:Landroid/widget/VideoView;

    .line 208
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->setupVideoPlayer()V

    .line 209
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->setupPaymentButtons()V

    .line 212
    nop

    .line 213
    const/4 v1, 0x0

    :try_start_0
    move-object v2, p0

    check-cast v2, Landroid/content/Context;

    invoke-static {v2}, Landroid/nfc/NfcAdapter;->getDefaultAdapter(Landroid/content/Context;)Landroid/nfc/NfcAdapter;

    move-result-object v2

    iput-object v2, p0, Lcom/roder300/kozen/MainActivity;->nfcAdapter:Landroid/nfc/NfcAdapter;

    .line 214
    iget-object v2, p0, Lcom/roder300/kozen/MainActivity;->nfcAdapter:Landroid/nfc/NfcAdapter;

    if-eqz v2, :cond_2

    invoke-virtual {v2}, Landroid/nfc/NfcAdapter;->isEnabled()Z

    move-result v2

    if-ne v2, v0, :cond_2

    const/4 v2, 0x1

    goto :goto_0

    :cond_2
    const/4 v2, 0x0

    :goto_0
    iput-boolean v2, p0, Lcom/roder300/kozen/MainActivity;->isNfcEnabled:Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 215
    :catch_0
    move-exception v2

    .line 216
    .local v2, "e":Ljava/lang/Exception;
    invoke-virtual {v2}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "\u041e\u0448\u0438\u0431\u043a\u0430 \u0438\u043d\u0438\u0446\u0438\u0430\u043b\u0438\u0437\u0430\u0446\u0438\u0438 NFC: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const-string v4, "NFC"

    invoke-static {v4, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 217
    move-object v3, p0

    check-cast v3, Landroid/content/Context;

    invoke-virtual {v2}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v4

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    check-cast v4, Ljava/lang/CharSequence;

    invoke-static {v3, v4, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v3

    invoke-virtual {v3}, Landroid/widget/Toast;->show()V

    .line 218
    const/4 v3, 0x0

    iput-object v3, p0, Lcom/roder300/kozen/MainActivity;->nfcAdapter:Landroid/nfc/NfcAdapter;

    .line 221
    .end local v2    # "e":Ljava/lang/Exception;
    :goto_1
    nop

    .line 224
    :try_start_1
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->setupSoundPool()V

    .line 225
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->loadAllSounds()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_2

    .line 226
    :catch_1
    move-exception v2

    .line 227
    .restart local v2    # "e":Ljava/lang/Exception;
    invoke-virtual {v2}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "\u041e\u0448\u0438\u0431\u043a\u0430 \u0418\u043d\u0438\u0446\u0438\u0430\u043b\u0438\u0437\u0430\u0446\u0438\u044f SoundPool: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const-string v4, "App"

    invoke-static {v4, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 232
    .end local v2    # "e":Ljava/lang/Exception;
    :goto_2
    const-string v2, "AppPrefs"

    invoke-virtual {p0, v2, v1}, Lcom/roder300/kozen/MainActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    iput-object v1, p0, Lcom/roder300/kozen/MainActivity;->sharedPreferences:Landroid/content/SharedPreferences;

    .line 235
    sget v1, Lcom/roder300/kozen/R$id;->textTerminalId:I

    invoke-virtual {p0, v1}, Lcom/roder300/kozen/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/roder300/kozen/MainActivity;->textTerminalId:Landroid/widget/TextView;

    .line 236
    sget v1, Lcom/roder300/kozen/R$id;->mainContainer:I

    invoke-virtual {p0, v1}, Lcom/roder300/kozen/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroidx/constraintlayout/widget/ConstraintLayout;

    iput-object v1, p0, Lcom/roder300/kozen/MainActivity;->mainContainer:Landroidx/constraintlayout/widget/ConstraintLayout;

    .line 237
    sget v1, Lcom/roder300/kozen/R$id;->payContainer:I

    invoke-virtual {p0, v1}, Lcom/roder300/kozen/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/FrameLayout;

    iput-object v1, p0, Lcom/roder300/kozen/MainActivity;->payContainer:Landroid/widget/FrameLayout;

    .line 238
    sget v1, Lcom/roder300/kozen/R$id;->payContainerPending:I

    invoke-virtual {p0, v1}, Lcom/roder300/kozen/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/FrameLayout;

    iput-object v1, p0, Lcom/roder300/kozen/MainActivity;->payPendingContainer:Landroid/widget/FrameLayout;

    .line 239
    sget v1, Lcom/roder300/kozen/R$id;->payContainerSucc:I

    invoke-virtual {p0, v1}, Lcom/roder300/kozen/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/FrameLayout;

    iput-object v1, p0, Lcom/roder300/kozen/MainActivity;->paySuccContainer:Landroid/widget/FrameLayout;

    .line 240
    sget v1, Lcom/roder300/kozen/R$id;->textContainer:I

    invoke-virtual {p0, v1}, Lcom/roder300/kozen/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/LinearLayout;

    iput-object v1, p0, Lcom/roder300/kozen/MainActivity;->textContainer:Landroid/widget/LinearLayout;

    .line 241
    sget v1, Lcom/roder300/kozen/R$id;->faceRecognition:I

    invoke-virtual {p0, v1}, Lcom/roder300/kozen/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/FrameLayout;

    iput-object v1, p0, Lcom/roder300/kozen/MainActivity;->faceRecognition:Landroid/widget/FrameLayout;

    .line 242
    sget v1, Lcom/roder300/kozen/R$id;->buttonsContainer:I

    invoke-virtual {p0, v1}, Lcom/roder300/kozen/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/LinearLayout;

    iput-object v1, p0, Lcom/roder300/kozen/MainActivity;->buttonsContainer:Landroid/widget/LinearLayout;

    .line 243
    sget v1, Lcom/roder300/kozen/R$id;->textAmount:I

    invoke-virtual {p0, v1}, Lcom/roder300/kozen/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/roder300/kozen/MainActivity;->textAmount:Landroid/widget/TextView;

    .line 244
    sget v1, Lcom/roder300/kozen/R$id;->labelL5:I

    invoke-virtual {p0, v1}, Lcom/roder300/kozen/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/roder300/kozen/MainActivity;->textAmountSucc:Landroid/widget/TextView;

    .line 245
    sget v1, Lcom/roder300/kozen/R$id;->textContent:I

    invoke-virtual {p0, v1}, Lcom/roder300/kozen/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/roder300/kozen/MainActivity;->textContent:Landroid/widget/TextView;

    .line 246
    sget v1, Lcom/roder300/kozen/R$id;->faceRecognitionPrepare:I

    invoke-virtual {p0, v1}, Lcom/roder300/kozen/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/FrameLayout;

    iput-object v1, p0, Lcom/roder300/kozen/MainActivity;->faceRecognitionPrepare:Landroid/widget/FrameLayout;

    .line 247
    sget v1, Lcom/roder300/kozen/R$id;->faceRecognitionInView:I

    invoke-virtual {p0, v1}, Lcom/roder300/kozen/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/FrameLayout;

    iput-object v1, p0, Lcom/roder300/kozen/MainActivity;->faceRecognitionInView:Landroid/widget/FrameLayout;

    .line 248
    sget v1, Lcom/roder300/kozen/R$id;->labelL4:I

    invoke-virtual {p0, v1}, Lcom/roder300/kozen/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/roder300/kozen/MainActivity;->textStatusPending:Landroid/widget/TextView;

    .line 249
    sget v1, Lcom/roder300/kozen/R$id;->lottieAnimationLoader:I

    invoke-virtual {p0, v1}, Lcom/roder300/kozen/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lcom/airbnb/lottie/LottieAnimationView;

    iput-object v1, p0, Lcom/roder300/kozen/MainActivity;->lottieAnimationLoader:Lcom/airbnb/lottie/LottieAnimationView;

    .line 250
    sget v1, Lcom/roder300/kozen/R$id;->lottieAnimationLoaderSucc:I

    invoke-virtual {p0, v1}, Lcom/roder300/kozen/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lcom/airbnb/lottie/LottieAnimationView;

    iput-object v1, p0, Lcom/roder300/kozen/MainActivity;->lottieAnimationLoaderSucc:Lcom/airbnb/lottie/LottieAnimationView;

    .line 252
    sget v1, Lcom/roder300/kozen/R$id;->logoImageView:I

    invoke-virtual {p0, v1}, Lcom/roder300/kozen/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    .line 253
    .local v1, "logoImageView":Landroid/widget/ImageView;
    sget v2, Lcom/roder300/kozen/R$id;->textImageView:I

    invoke-virtual {p0, v2}, Lcom/roder300/kozen/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/ImageView;

    .line 256
    .local v2, "textImageView":Landroid/widget/ImageView;
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->isDeviceRegistered()Z

    move-result v3

    if-nez v3, :cond_4

    .line 257
    move-object v3, p0

    check-cast v3, Landroid/content/Context;

    const-string v4, "\u0421\u043f\u0430\u0441\u0438\u0431\u043e \u0437\u0430 \u0441\u043a\u0430\u0447\u0438\u0432\u0430\u043d\u0438\u0435!\n\u0410\u0432\u0442\u043e\u0440 \u043f\u0440\u0438\u043b\u043e\u0436\u0435\u043d\u0438\u044f: @roder300\n\nTG: https://t.me/roder300\n\n\u0420\u0435\u0433\u0438\u0441\u0442\u0440\u0438\u0440\u0443\u0435\u043c \u0432\u0430\u0448\u0435 \u0443\u0441\u0442\u0440\u043e\u0439\u0441\u0442\u0432\u043e..."

    check-cast v4, Ljava/lang/CharSequence;

    invoke-static {v3, v4, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 258
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->isNetworkAvailable()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 259
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->registerDevice()V

    goto :goto_3

    .line 261
    :cond_3
    const-string v0, "\u041d\u0435\u0442 \u0438\u043d\u0442\u0435\u0440\u043d\u0435\u0442-\u0441\u043e\u0435\u0434\u0438\u043d\u0435\u043d\u0438\u044f"

    invoke-direct {p0, v0}, Lcom/roder300/kozen/MainActivity;->showRegistrationErrorDialog(Ljava/lang/String;)V

    goto :goto_3

    .line 264
    :cond_4
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->showTerminalId()V

    .line 266
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v3

    invoke-direct {v0, v3}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v3, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda29;

    invoke-direct {v3, p0}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda29;-><init>(Lcom/roder300/kozen/MainActivity;)V

    .line 269
    nop

    .line 266
    const-wide/16 v4, 0x3e8

    invoke-virtual {v0, v3, v4, v5}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 271
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->startPayloadChecking()V

    .line 275
    :goto_3
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v3

    invoke-direct {v0, v3}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v3, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda30;

    invoke-direct {v3, p0, v2}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda30;-><init>(Lcom/roder300/kozen/MainActivity;Landroid/widget/ImageView;)V

    .line 277
    nop

    .line 275
    const-wide/16 v4, 0x12c

    invoke-virtual {v0, v3, v4, v5}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 279
    new-instance v0, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda31;

    invoke-direct {v0, p0}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda31;-><init>(Lcom/roder300/kozen/MainActivity;)V

    invoke-virtual {v1, v0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 287
    return-void
.end method

.method protected onDestroy()V
    .locals 1

    .line 376
    invoke-super {p0}, Landroidx/appcompat/app/AppCompatActivity;->onDestroy()V

    .line 378
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->soundPool:Landroid/media/SoundPool;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/media/SoundPool;->release()V

    .line 379
    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/roder300/kozen/MainActivity;->soundPool:Landroid/media/SoundPool;

    .line 380
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->soundMap:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    .line 381
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->stopPayloadChecking()V

    .line 382
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/roder300/kozen/MainActivity;->doNotBlockScreen(Z)V

    .line 383
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->stopNfcListening()V

    .line 384
    iget-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isProximitySensorActive:Z

    if-eqz v0, :cond_1

    .line 385
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->stopSensorCard()V

    .line 387
    :cond_1
    return-void
.end method

.method public onFaceDetection([Landroid/hardware/Camera$Face;Landroid/hardware/Camera;)V
    .locals 1
    .param p1, "faces"    # [Landroid/hardware/Camera$Face;
    .param p2, "camera"    # Landroid/hardware/Camera;

    .line 2071
    new-instance v0, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda3;

    invoke-direct {v0, p0, p1}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda3;-><init>(Lcom/roder300/kozen/MainActivity;[Landroid/hardware/Camera$Face;)V

    invoke-virtual {p0, v0}, Lcom/roder300/kozen/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 2205
    return-void
.end method

.method protected onNewIntent(Landroid/content/Intent;)V
    .locals 5
    .param p1, "intent"    # Landroid/content/Intent;

    const-string v0, "intent"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 722
    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->onNewIntent(Landroid/content/Intent;)V

    .line 723
    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onNewIntent \u0432\u044b\u0437\u0432\u0430\u043d \u0441 action: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "NFC"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 725
    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_2

    .line 2285
    .local v0, "it\\1":Ljava/lang/String;
    const/4 v2, 0x0

    .line 725
    .local v2, "$i$a$-let-MainActivity$onNewIntent$1\\1\\725\\0":I
    const-string v3, "android.nfc.action.NDEF_DISCOVERED"

    invoke-static {v0, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    const/4 v4, 0x1

    if-nez v3, :cond_1

    .line 726
    const-string v3, "android.nfc.action.TAG_DISCOVERED"

    invoke-static {v0, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1

    .line 727
    const-string v3, "android.nfc.action.TECH_DISCOVERED"

    invoke-static {v0, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    .line 725
    .end local v0    # "it\\1":Ljava/lang/String;
    .end local v2    # "$i$a$-let-MainActivity$onNewIntent$1\\1\\725\\0":I
    :goto_1
    nop

    .line 727
    nop

    .line 725
    if-ne v0, v4, :cond_2

    const/4 v1, 0x1

    :cond_2
    if-eqz v1, :cond_3

    .line 729
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->currentScreen:Ljava/lang/String;

    const-string v1, "pay"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 730
    invoke-direct {p0, p1}, Lcom/roder300/kozen/MainActivity;->handleNfcIntent(Landroid/content/Intent;)V

    .line 733
    :cond_3
    return-void
.end method

.method protected onPause()V
    .locals 1

    .line 363
    invoke-super {p0}, Landroidx/appcompat/app/AppCompatActivity;->onPause()V

    .line 365
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->stopPayloadChecking()V

    .line 366
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->stopVideoPlayback()V

    .line 367
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/roder300/kozen/MainActivity;->doNotBlockScreen(Z)V

    .line 368
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->stopNfcListening()V

    .line 369
    iget-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isProximitySensorActive:Z

    if-eqz v0, :cond_0

    .line 370
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->stopSensorCard()V

    .line 373
    :cond_0
    return-void
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 3
    .param p1, "requestCode"    # I
    .param p2, "permissions"    # [Ljava/lang/String;
    .param p3, "grantResults"    # [I

    const-string v0, "permissions"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "grantResults"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1795
    invoke-super {p0, p1, p2, p3}, Landroidx/appcompat/app/AppCompatActivity;->onRequestPermissionsResult(I[Ljava/lang/String;[I)V

    .line 1797
    iget v0, p0, Lcom/roder300/kozen/MainActivity;->cameraPermissionCode:I

    if-ne p1, v0, :cond_2

    .line 1798
    array-length v0, p3

    const/4 v1, 0x0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    if-nez v0, :cond_1

    aget v0, p3, v1

    if-nez v0, :cond_1

    .line 1799
    const-string v0, "\u0420\u0430\u0437\u0440\u0435\u0448\u0435\u043d\u0438\u0435 \u043d\u0430 \u043a\u0430\u043c\u0435\u0440\u0443 \u043f\u043e\u043b\u0443\u0447\u0435\u043d\u043e"

    invoke-direct {p0, v0}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    iput-boolean v1, p0, Lcom/roder300/kozen/MainActivity;->isFaceUploading:Z

    iput v1, p0, Lcom/roder300/kozen/MainActivity;->faceDetectionCount:I

    .line 1800
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->startFaceDetection()V

    goto :goto_1

    .line 1802
    :cond_1
    const-string v0, "\u0420\u0430\u0437\u0440\u0435\u0448\u0435\u043d\u0438\u0435 \u043d\u0430 \u043a\u0430\u043c\u0435\u0440\u0443 \u043e\u0442\u043a\u043b\u043e\u043d\u0435\u043d\u043e"

    invoke-direct {p0, v0}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 1803
    move-object v0, p0

    check-cast v0, Landroid/content/Context;

    const-string v2, "\u041d\u0435\u043e\u0431\u0445\u043e\u0434\u0438\u043c\u043e \u0440\u0430\u0437\u0440\u0435\u0448\u0435\u043d\u0438\u0435 \u0434\u043b\u044f \u0440\u0430\u0431\u043e\u0442\u044b \u043a\u0430\u043c\u0435\u0440\u044b"

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v0, v2, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 1806
    :cond_2
    :goto_1
    return-void
.end method

.method protected onResume()V
    .locals 4

    .line 347
    invoke-super {p0}, Landroidx/appcompat/app/AppCompatActivity;->onResume()V

    .line 348
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->setFullScreenMode()V

    .line 349
    const/4 v0, 0x1

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-static {p0, v2, v0, v1}, Lcom/roder300/kozen/MainActivity;->doNotBlockScreen$default(Lcom/roder300/kozen/MainActivity;ZILjava/lang/Object;)V

    .line 351
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->isDeviceRegistered()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 352
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->startPayloadChecking()V

    .line 354
    :cond_0
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->currentScreen:Ljava/lang/String;

    const-string v1, "pay"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 355
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->startVideoPlayback()V

    .line 356
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v1, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda20;

    invoke-direct {v1, p0}, Lcom/roder300/kozen/MainActivity$$ExternalSyntheticLambda20;-><init>(Lcom/roder300/kozen/MainActivity;)V

    .line 358
    nop

    .line 356
    const-wide/16 v2, 0x1f4

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 360
    :cond_1
    return-void
.end method

.method public onWindowFocusChanged(Z)V
    .locals 0
    .param p1, "hasFocus"    # Z

    .line 1572
    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->onWindowFocusChanged(Z)V

    .line 1573
    if-eqz p1, :cond_0

    .line 1574
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->setFullScreenMode()V

    .line 1576
    :cond_0
    return-void
.end method

.method public final releaseCamera()V
    .locals 4

    .line 2059
    nop

    .line 2060
    :try_start_0
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->camera:Landroid/hardware/Camera;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/hardware/Camera;->stopFaceDetection()V

    .line 2061
    :cond_0
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->camera:Landroid/hardware/Camera;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/hardware/Camera;->stopPreview()V

    .line 2062
    :cond_1
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->camera:Landroid/hardware/Camera;

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Landroid/hardware/Camera;->release()V

    .line 2063
    :cond_2
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/roder300/kozen/MainActivity;->camera:Landroid/hardware/Camera;

    .line 2064
    const-string v0, "\u041a\u0430\u043c\u0435\u0440\u0430 \u043e\u0441\u0432\u043e\u0431\u043e\u0436\u0434\u0435\u043d\u0430"

    invoke-direct {p0, v0}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 2065
    :catch_0
    move-exception v0

    .line 2066
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u041e\u0448\u0438\u0431\u043a\u0430 \u043e\u0441\u0432\u043e\u0431\u043e\u0436\u0434\u0435\u043d\u0438\u044f \u043a\u0430\u043c\u0435\u0440\u044b: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 2068
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method public final rotateToUpsideDown()V
    .locals 1

    .line 290
    const/16 v0, 0x9

    invoke-virtual {p0, v0}, Lcom/roder300/kozen/MainActivity;->setRequestedOrientation(I)V

    .line 291
    return-void
.end method

.method public final setLastKnownValue(F)V
    .locals 0
    .param p1, "<set-?>"    # F

    .line 511
    iput p1, p0, Lcom/roder300/kozen/MainActivity;->lastKnownValue:F

    return-void
.end method

.method public final setLastUpdateTime(J)V
    .locals 0
    .param p1, "<set-?>"    # J

    .line 512
    iput-wide p1, p0, Lcom/roder300/kozen/MainActivity;->lastUpdateTime:J

    return-void
.end method

.method public final setMaxRange(F)V
    .locals 0
    .param p1, "<set-?>"    # F

    .line 513
    iput p1, p0, Lcom/roder300/kozen/MainActivity;->maxRange:F

    return-void
.end method

.method public setPendingStatusText(Ljava/lang/String;)V
    .locals 2
    .param p1, "text"    # Ljava/lang/String;

    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->textStatusPending:Landroid/widget/TextView;

    if-nez v0, :cond_0

    const-string v0, "textStatusPending"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v0, 0x0

    :cond_0
    move-object v1, p1

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public final setTextDesc(Ljava/lang/String;)V
    .locals 2
    .param p1, "text"    # Ljava/lang/String;

    const-string v0, "text"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 2011
    sget v0, Lcom/roder300/kozen/R$id;->labelL7:I

    invoke-virtual {p0, v0}, Lcom/roder300/kozen/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 2012
    .local v0, "textView":Landroid/widget/TextView;
    if-eqz v0, :cond_0

    move-object v1, p1

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 2013
    :cond_0
    return-void
.end method

.method public showFacePaymentFailed()V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isCardPolling:Z

    iput-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isFacePolling:Z

    const-string v0, "\u041e\u043f\u043b\u0430\u0442\u0430 \u043d\u0435 \u043f\u0440\u043e\u0448\u043b\u0430. \u041f\u043e\u043f\u0440\u043e\u0431\u0443\u0439\u0442\u0435 \u0435\u0449\u0451 \u0440\u0430\u0437."

    invoke-direct {p0, v0}, Lcom/roder300/kozen/MainActivity;->showTextScreen(Ljava/lang/String;)V

    return-void
.end method

.method public showFacePaymentSuccess()V
    .locals 10

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isFacePolling:Z

    const-string v1, "paySuccContainer"

    const/4 v2, 0x2

    invoke-static {p0, v1, v0, v2, v0}, Lcom/roder300/kozen/MainActivity;->showScreen$default(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;Ljava/lang/Boolean;ILjava/lang/Object;)V

    const-string v1, "success_face"

    const/4 v2, 0x0

    const/4 v3, 0x2

    const/4 v0, 0x0

    invoke-static {p0, v1, v2, v3, v0}, Lcom/roder300/kozen/MainActivity;->playSound$default(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;FILjava/lang/Object;)V

    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->lottieAnimationLoaderSucc:Lcom/airbnb/lottie/LottieAnimationView;

    if-eqz v0, :cond_0

    move-object v4, v0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/16 v8, 0x8

    const/4 v9, 0x0

    move-object v3, p0

    invoke-static/range {v3 .. v9}, Lcom/roder300/kozen/MainActivity;->startLottieAnimation$default(Lcom/roder300/kozen/MainActivity;Lcom/airbnb/lottie/LottieAnimationView;ZIFILjava/lang/Object;)V

    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->lottieAnimationLoaderSucc:Lcom/airbnb/lottie/LottieAnimationView;

    if-eqz v0, :cond_0

    const/high16 v1, 0x3f800000    # 1.0f

    invoke-virtual {v0, v1}, Lcom/airbnb/lottie/LottieAnimationView;->setAlpha(F)V

    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->lottieAnimationLoaderSucc:Lcom/airbnb/lottie/LottieAnimationView;

    if-eqz v0, :cond_0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/airbnb/lottie/LottieAnimationView;->setTranslationY(F)V

    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->lottieAnimationLoaderSucc:Lcom/airbnb/lottie/LottieAnimationView;

    if-eqz v0, :cond_0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/airbnb/lottie/LottieAnimationView;->setVisibility(I)V

    :cond_0
    return-void
.end method

.method public final showImgDesc(Ljava/lang/String;Landroid/widget/ImageView;)V
    .locals 1
    .param p1, "imageKey"    # Ljava/lang/String;
    .param p2, "imageSet"    # Landroid/widget/ImageView;

    const-string v0, "imageKey"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "imageSet"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 332
    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    move-result v0

    sparse-switch v0, :sswitch_data_0

    :goto_0
    goto :goto_1

    :sswitch_0
    const-string v0, "face_right"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 335
    :cond_0
    sget v0, Lcom/roder300/kozen/R$drawable;->face_right:I

    goto :goto_2

    .line 332
    :sswitch_1
    const-string v0, "face_close"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    goto :goto_0

    .line 333
    :cond_1
    sget v0, Lcom/roder300/kozen/R$drawable;->face_close:I

    goto :goto_2

    .line 332
    :sswitch_2
    const-string v0, "face_two"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    goto :goto_0

    .line 338
    :cond_2
    sget v0, Lcom/roder300/kozen/R$drawable;->face_two:I

    goto :goto_2

    .line 332
    :sswitch_3
    const-string v0, "face_far"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    goto :goto_0

    .line 334
    :cond_3
    sget v0, Lcom/roder300/kozen/R$drawable;->face_far:I

    goto :goto_2

    .line 332
    :sswitch_4
    const-string v0, "face_normal"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_4

    goto :goto_0

    .line 337
    :cond_4
    sget v0, Lcom/roder300/kozen/R$drawable;->face_normal:I

    goto :goto_2

    .line 332
    :sswitch_5
    const-string v0, "face_left"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_5

    goto :goto_0

    .line 336
    :cond_5
    sget v0, Lcom/roder300/kozen/R$drawable;->face_left:I

    goto :goto_2

    .line 339
    :goto_1
    sget v0, Lcom/roder300/kozen/R$drawable;->face_normal:I

    .line 332
    :goto_2
    nop

    .line 341
    .local v0, "resourceId":I
    invoke-virtual {p2, v0}, Landroid/widget/ImageView;->setImageResource(I)V

    .line 342
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        -0x699a0b57 -> :sswitch_5
        -0x67488ef7 -> :sswitch_4
        0x1da01a35 -> :sswitch_3
        0x1da0516a -> :sswitch_2
        0x35dd1d96 -> :sswitch_1
        0x36af01ba -> :sswitch_0
    .end sparse-switch
.end method

.method public showPayScreenSuccess()V
    .locals 10

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isCardPolling:Z

    const-string v1, "paySuccContainer"

    const/4 v2, 0x2

    invoke-static {p0, v1, v0, v2, v0}, Lcom/roder300/kozen/MainActivity;->showScreen$default(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;Ljava/lang/Boolean;ILjava/lang/Object;)V

    const-string v1, "success_pay"

    const/4 v2, 0x0

    const/4 v3, 0x2

    const/4 v0, 0x0

    invoke-static {p0, v1, v2, v3, v0}, Lcom/roder300/kozen/MainActivity;->playSound$default(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;FILjava/lang/Object;)V

    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->lottieAnimationLoaderSucc:Lcom/airbnb/lottie/LottieAnimationView;

    if-eqz v0, :cond_0

    move-object v4, v0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/16 v8, 0x8

    const/4 v9, 0x0

    move-object v3, p0

    invoke-static/range {v3 .. v9}, Lcom/roder300/kozen/MainActivity;->startLottieAnimation$default(Lcom/roder300/kozen/MainActivity;Lcom/airbnb/lottie/LottieAnimationView;ZIFILjava/lang/Object;)V

    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->lottieAnimationLoaderSucc:Lcom/airbnb/lottie/LottieAnimationView;

    if-eqz v0, :cond_0

    const/high16 v1, 0x3f800000    # 1.0f

    invoke-virtual {v0, v1}, Lcom/airbnb/lottie/LottieAnimationView;->setAlpha(F)V

    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->lottieAnimationLoaderSucc:Lcom/airbnb/lottie/LottieAnimationView;

    if-eqz v0, :cond_0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/airbnb/lottie/LottieAnimationView;->setTranslationY(F)V

    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->lottieAnimationLoaderSucc:Lcom/airbnb/lottie/LottieAnimationView;

    if-eqz v0, :cond_0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/airbnb/lottie/LottieAnimationView;->setVisibility(I)V

    :cond_0
    return-void
.end method

.method public startFaceConfirmPolling()V
    .locals 5

    iget-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isFacePolling:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isFacePolling:Z

    iput-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isPaymentLocked:Z

    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->getServerUrl()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/roder300/kozen/MainActivity;->sharedPreferences:Landroid/content/SharedPreferences;

    const-string v2, "terminal_id"

    const-string v3, ""

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "uuid"

    const-string v4, ""

    invoke-interface {v1, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Lcom/roder300/kozen/FaceConfirmPoller;

    invoke-direct {v4, p0, v0, v2, v3}, Lcom/roder300/kozen/FaceConfirmPoller;-><init>(Lcom/roder300/kozen/MainActivity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v4}, Lcom/roder300/kozen/FaceConfirmPoller;->start()V

    return-void
.end method

.method public final startLottieAnimation(Lcom/airbnb/lottie/LottieAnimationView;ZIF)V
    .locals 3
    .param p1, "lottieView"    # Lcom/airbnb/lottie/LottieAnimationView;
    .param p2, "loop"    # Z
    .param p3, "loopCount"    # I
    .param p4, "speed"    # F

    const-string v0, "lottieView"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1141
    move-object v0, p1

    .local v0, "$this$startLottieAnimation_u24lambda_u2423\\1":Lcom/airbnb/lottie/LottieAnimationView;
    const/4 v1, 0x0

    .line 1142
    .local v1, "$i$a$-with-MainActivity$startLottieAnimation$1\\1\\1141\\0":I
    if-eqz p2, :cond_0

    const/4 v2, 0x1

    goto :goto_0

    :cond_0
    const/4 v2, 0x2

    :goto_0
    invoke-virtual {v0, v2}, Lcom/airbnb/lottie/LottieAnimationView;->setRepeatMode(I)V

    .line 1143
    if-eqz p2, :cond_1

    const/4 v2, -0x1

    goto :goto_1

    :cond_1
    move v2, p3

    :goto_1
    invoke-virtual {v0, v2}, Lcom/airbnb/lottie/LottieAnimationView;->setRepeatCount(I)V

    .line 1144
    invoke-virtual {v0, p4}, Lcom/airbnb/lottie/LottieAnimationView;->setSpeed(F)V

    .line 1145
    invoke-virtual {v0}, Lcom/airbnb/lottie/LottieAnimationView;->playAnimation()V

    .line 1146
    nop

    .line 1141
    .end local v0    # "$this$startLottieAnimation_u24lambda_u2423\\1":Lcom/airbnb/lottie/LottieAnimationView;
    .end local v1    # "$i$a$-with-MainActivity$startLottieAnimation$1\\1\\1141\\0":I
    nop

    .line 1147
    return-void
.end method

.method public surfaceChanged(Landroid/view/SurfaceHolder;III)V
    .locals 4
    .param p1, "holder"    # Landroid/view/SurfaceHolder;
    .param p2, "format"    # I
    .param p3, "width"    # I
    .param p4, "height"    # I

    const-string v0, "holder"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1961
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Surface \u0438\u0437\u043c\u0435\u043d\u0435\u043d: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " x "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 1962
    invoke-interface {p1}, Landroid/view/SurfaceHolder;->getSurface()Landroid/view/Surface;

    move-result-object v0

    if-nez v0, :cond_0

    .line 1963
    const-string v0, "Surface is null"

    invoke-direct {p0, v0}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 1964
    return-void

    .line 1967
    :cond_0
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->stopPreview()V

    .line 1968
    nop

    .line 1969
    :try_start_0
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->camera:Landroid/hardware/Camera;

    if-eqz v0, :cond_1

    invoke-virtual {v0, p1}, Landroid/hardware/Camera;->setPreviewDisplay(Landroid/view/SurfaceHolder;)V

    .line 1970
    :cond_1
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->startPreview()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 1971
    :catch_0
    move-exception v0

    .line 1972
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u041e\u0448\u0438\u0431\u043a\u0430 \u043f\u0435\u0440\u0435\u0437\u0430\u043f\u0443\u0441\u043a\u0430 preview: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 1974
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method public surfaceCreated(Landroid/view/SurfaceHolder;)V
    .locals 4
    .param p1, "holder"    # Landroid/view/SurfaceHolder;

    const-string v0, "holder"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1951
    const-string v0, "Surface \u0441\u043e\u0437\u0434\u0430\u043d"

    invoke-direct {p0, v0}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 1952
    nop

    .line 1953
    :try_start_0
    iget-object v0, p0, Lcom/roder300/kozen/MainActivity;->camera:Landroid/hardware/Camera;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Landroid/hardware/Camera;->setPreviewDisplay(Landroid/view/SurfaceHolder;)V

    .line 1954
    :cond_0
    invoke-direct {p0}, Lcom/roder300/kozen/MainActivity;->startPreview()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 1955
    :catch_0
    move-exception v0

    .line 1956
    .local v0, "e":Ljava/io/IOException;
    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u041e\u0448\u0438\u0431\u043a\u0430 \u0443\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0438 preview: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 1958
    .end local v0    # "e":Ljava/io/IOException;
    :goto_0
    return-void
.end method

.method public surfaceDestroyed(Landroid/view/SurfaceHolder;)V
    .locals 2
    .param p1, "holder"    # Landroid/view/SurfaceHolder;

    const-string v0, "holder"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1977
    const-string v0, "Surface \u0443\u043d\u0438\u0447\u0442\u043e\u0436\u0435\u043d"

    invoke-direct {p0, v0}, Lcom/roder300/kozen/MainActivity;->addLog(Ljava/lang/String;)V

    .line 1978
    iget-boolean v0, p0, Lcom/roder300/kozen/MainActivity;->isFaceUploading:Z

    if-nez v0, :cond_0

    const-string v0, "FaceDebug"

    const-string v1, "surfaceDestroyed: releaseCamera called"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/roder300/kozen/MainActivity;->releaseCamera()V

    goto :goto_0

    :cond_0
    const-string v0, "FaceDebug"

    const-string v1, "surfaceDestroyed: isFaceUploading=true, skipped releaseCamera"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1979
    :goto_0
    return-void
.end method
