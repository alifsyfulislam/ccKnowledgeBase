[33mcommit ae3a5f8fa459149f8001acc64a607246a542dfcd[m[33m ([m[1;36mHEAD -> [m[1;32mmaster[m[33m, [m[1;31morigin/master[m[33m)[m
Author: zia <ziaur@genusys.us>
Date:   Sun Nov 8 01:20:25 2020 -0500

    custom acl with code refactor

[1mdiff --git a/.editorconfig b/.editorconfig[m
[1mnew file mode 100755[m
[1mindex 0000000..6f313c6[m
[1m--- /dev/null[m
[1m+++ b/.editorconfig[m
[36m@@ -0,0 +1,15 @@[m
[32m+[m[32mroot = true[m
[32m+[m
[32m+[m[32m[*][m
[32m+[m[32mcharset = utf-8[m
[32m+[m[32mend_of_line = lf[m
[32m+[m[32minsert_final_newline = true[m
[32m+[m[32mindent_style = space[m
[32m+[m[32mindent_size = 4[m
[32m+[m[32mtrim_trailing_whitespace = true[m
[32m+[m
[32m+[m[32m[*.md][m
[32m+[m[32mtrim_trailing_whitespace = false[m
[32m+[m
[32m+[m[32m[*.yml][m
[32m+[m[32mindent_size = 2[m
[1mdiff --git a/.env.example b/.env.example[m
[1mnew file mode 100755[m
[1mindex 0000000..604b401[m
[1m--- /dev/null[m
[1m+++ b/.env.example[m
[36m@@ -0,0 +1,44 @@[m
[32m+[m[32mAPP_NAME=Laravel[m
[32m+[m[32mAPP_ENV=local[m
[32m+[m[32mAPP_KEY=[m
[32m+[m[32mAPP_DEBUG=true[m
[32m+[m[32mAPP_URL=http://localhost[m
[32m+[m
[32m+[m[32mLOG_CHANNEL=stack[m
[32m+[m
[32m+[m[32mDB_CONNECTION=mysql[m
[32m+[m[32mDB_HOST=127.0.0.1[m
[32m+[m[32mDB_PORT=3306[m
[32m+[m[32mDB_DATABASE=laravel[m
[32m+[m[32mDB_USERNAME=root[m
[32m+[m[32mDB_PASSWORD=[m
[32m+[m
[32m+[m[32mBROADCAST_DRIVER=log[m
[32m+[m[32mCACHE_DRIVER=file[m
[32m+[m[32mQUEUE_CONNECTION=sync[m
[32m+[m[32mSESSION_DRIVER=file[m
[32m+[m[32mSESSION_LIFETIME=120[m
[32m+[m
[32m+[m[32mREDIS_HOST=127.0.0.1[m
[32m+[m[32mREDIS_PASSWORD=null[m
[32m+[m[32mREDIS_PORT=6379[m
[32m+[m
[32m+[m[32mMAIL_DRIVER=smtp[m
[32m+[m[32mMAIL_HOST=smtp.mailtrap.io[m
[32m+[m[32mMAIL_PORT=2525[m
[32m+[m[32mMAIL_USERNAME=null[m
[32m+[m[32mMAIL_PASSWORD=null[m
[32m+[m[32mMAIL_ENCRYPTION=null[m
[32m+[m
[32m+[m[32mAWS_ACCESS_KEY_ID=[m
[32m+[m[32mAWS_SECRET_ACCESS_KEY=[m
[32m+[m[32mAWS_DEFAULT_REGION=us-east-1[m
[32m+[m[32mAWS_BUCKET=[m
[32m+[m
[32m+[m[32mPUSHER_APP_ID=[m
[32m+[m[32mPUSHER_APP_KEY=[m
[32m+[m[32mPUSHER_APP_SECRET=[m
[32m+[m[32mPUSHER_APP_CLUSTER=mt1[m
[32m+[m
[32m+[m[32mMIX_PUSHER_APP_KEY="${PUSHER_APP_KEY}"[m
[32m+[m[32mMIX_PUSHER_APP_CLUSTER="${PUSHER_APP_CLUSTER}"[m
[1mdiff --git a/.gitattributes b/.gitattributes[m
[1mnew file mode 100755[m
[1mindex 0000000..967315d[m
[1m--- /dev/null[m
[1m+++ b/.gitattributes[m
[36m@@ -0,0 +1,5 @@[m
[32m+[m[32m* text=auto[m
[32m+[m[32m*.css linguist-vendored[m
[32m+[m[32m*.scss linguist-vendored[m
[32m+[m[32m*.js linguist-vendored[m
[32m+[m[32mCHANGELOG.md export-ignore[m
[1mdiff --git a/.gitignore b/.gitignore[m
[1mnew file mode 100755[m
[1mindex 0000000..d508254[m
[1m--- /dev/null[m
[1m+++ b/.gitignore[m
[36m@@ -0,0 +1,13 @@[m
[32m+[m[32m/.idea[m
[32m+[m[32m/node_modules[m
[32m+[m[32m/public/hot[m
[32m+[m[32m/public/storage[m
[32m+[m[32m/storage/*.key[m
[32m+[m[32m/vendor[m
[32m+[m[32m.env[m
[32m+[m[32m.env.backup[m
[32m+[m[32m.phpunit.result.cache[m
[32m+[m[32mHomestead.json[m
[32m+[m[32mHomestead.yaml[m
[32m+[m[32mnpm-debug.log[m
[32m+[m[32myarn-error.log[m
[1mdiff --git a/.styleci.yml b/.styleci.yml[m
[1mnew file mode 100755[m
[1mindex 0000000..1db61d9[m
[1m--- /dev/null[m
[1m+++ b/.styleci.yml[m
[36m@@ -0,0 +1,13 @@[m
[32m+[m[32mphp:[m
[32m+[m[32m  preset: laravel[m
[32m+[m[32m  disabled:[m
[32m+[m[32m    - unused_use[m
[32m+[m[32m  finder:[m
[32m+[m[32m    not-name:[m
[32m+[m[32m      - index.php[m
[32m+[m[32m      - server.php[m
[32m+[m[32mjs:[m
[32m+[m[32m  finder:[m
[32m+[m[32m    not-name:[m
[32m+[m[32m      - webpack.mix.js[m
[32m+[m[32mcss: true[m
[1mdiff --git a/app/Console/Kernel.php b/app/Console/Kernel.php[m
[1mnew file mode 100755[m
[1mindex 0000000..a8c5158[m
[1m--- /dev/null[m
[1m+++ b/app/Console/Kernel.php[m
[36m@@ -0,0 +1,42 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Console;[m
[32m+[m
[32m+[m[32muse Illuminate\Console\Scheduling\Schedule;[m
[32m+[m[32muse Illuminate\Foundation\Console\Kernel as ConsoleKernel;[m
[32m+[m
[32m+[m[32mclass Kernel extends ConsoleKernel[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * The Artisan commands provided by your application.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @var array[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $commands = [[m
[32m+[m[32m        //[m
[32m+[m[32m    ];[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Define the application's command schedule.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \Illuminate\Console\Scheduling\Schedule  $schedule[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    protected function schedule(Schedule $schedule)[m
[32m+[m[32m    {[m
[32m+[m[32m        // $schedule->command('inspire')[m
[32m+[m[32m        //          ->hourly();[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Register the commands for the application.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    protected function commands()[m
[32m+[m[32m    {[m
[32m+[m[32m        $this->load(__DIR__.'/Commands');[m
[32m+[m
[32m+[m[32m        require base_path('routes/console.php');[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Exceptions/Handler.php b/app/Exceptions/Handler.php[m
[1mnew file mode 100755[m
[1mindex 0000000..043cad6[m
[1m--- /dev/null[m
[1m+++ b/app/Exceptions/Handler.php[m
[36m@@ -0,0 +1,51 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Exceptions;[m
[32m+[m
[32m+[m[32muse Exception;[m
[32m+[m[32muse Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;[m
[32m+[m
[32m+[m[32mclass Handler extends ExceptionHandler[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * A list of the exception types that are not reported.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @var array[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $dontReport = [[m
[32m+[m[32m        //[m
[32m+[m[32m    ];[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * A list of the inputs that are never flashed for validation exceptions.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @var array[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $dontFlash = [[m
[32m+[m[32m        'password',[m
[32m+[m[32m        'password_confirmation',[m
[32m+[m[32m    ];[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Report or log an exception.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \Exception  $exception[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function report(Exception $exception)[m
[32m+[m[32m    {[m
[32m+[m[32m        parent::report($exception);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Render an exception into an HTTP response.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \Illuminate\Http\Request  $request[m
[32m+[m[32m     * @param  \Exception  $exception[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function render($request, Exception $exception)[m
[32m+[m[32m    {[m
[32m+[m[32m        return parent::render($request, $exception);[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Helpers/Helper.php b/app/Helpers/Helper.php[m
[1mnew file mode 100755[m
[1mindex 0000000..31d9cb0[m
[1m--- /dev/null[m
[1m+++ b/app/Helpers/Helper.php[m
[36m@@ -0,0 +1,76 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m
[32m+[m[32mnamespace App\Helpers;[m
[32m+[m
[32m+[m[32muse Auth;[m
[32m+[m[32muse Image;[m
[32m+[m
[32m+[m[32mclass Helper[m
[32m+[m[32m{[m
[32m+[m
[32m+[m[32m    public static function slugify($value)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return strtolower(str_replace(' ','-',$value));[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $url[m
[32m+[m[32m     * @param $image[m
[32m+[m[32m     * @return string[m
[32m+[m[32m     */[m
[32m+[m[32m    public static function base64ProfileImageThumbUpload($url, $image)[m
[32m+[m[32m    {[m
[32m+[m[32m        $fileName = time () .".jpg";[m
[32m+[m[32m        $dir = "media/".$url."/".Auth::user()->id."/thumbs/";[m
[32m+[m
[32m+[m[32m        if (!file_exists(public_path ($dir))) {[m
[32m+[m
[32m+[m[32m            mkdir(public_path ($dir), 0755, true);[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        $small_image = Image::make($image);[m
[32m+[m[32m        $thumbImage = $small_image->resize(null, 250, function ($e) {[m
[32m+[m
[32m+[m[32m            $e->aspectRatio();[m
[32m+[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m        $thumbImage->save(public_path($dir. $fileName ));[m
[32m+[m
[32m+[m[32m        return url('/').'/'.$dir.$fileName;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $url[m
[32m+[m[32m     * @param $image[m
[32m+[m[32m     * @return string[m
[32m+[m[32m     */[m
[32m+[m[32m    public static function base64ImageUpload($url, $image)[m
[32m+[m[32m    {[m
[32m+[m[32m        $fileName = uniqid().".jpg";[m
[32m+[m[32m        $dir = "media/".$url."/";[m
[32m+[m
[32m+[m[32m        if (!file_exists(public_path ($dir))) {[m
[32m+[m
[32m+[m[32m            mkdir(public_path ($dir), 0755, true);[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        $small_image = Image::make($image);[m
[32m+[m[32m        $thumbImage = $small_image->resize(null, 500, function ($e) {[m
[32m+[m
[32m+[m[32m            $e->aspectRatio();[m
[32m+[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m        $thumbImage->save(public_path($dir. $fileName ));[m
[32m+[m
[32m+[m[32m        return url('/').'/'.$dir.$fileName;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Controllers/Api/ArticleController.php b/app/Http/Controllers/Api/ArticleController.php[m
[1mnew file mode 100644[m
[1mindex 0000000..fc43db4[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Controllers/Api/ArticleController.php[m
[36m@@ -0,0 +1,104 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Controllers\Api;[m
[32m+[m
[32m+[m[32muse App\Models\Article;[m
[32m+[m[32muse App\Http\Controllers\Controller;[m
[32m+[m[32muse App\Services\ArticleService;[m
[32m+[m[32muse Illuminate\Http\JsonResponse;[m
[32m+[m[32muse Illuminate\Http\Request;[m
[32m+[m
[32m+[m[32mclass ArticleController extends Controller[m
[32m+[m[32m{[m
[32m+[m
[32m+[m[32m    protected $articleService;[m
[32m+[m
[32m+[m[32m    public function __construct(ArticleService $articleService)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        $this->middleware('permission:article-list');[m
[32m+[m[32m        $this->middleware('permission:article-create', ['only' => ['create','store']]);[m
[32m+[m[32m        $this->middleware('permission:article-edit', ['only' => ['edit','update']]);[m
[32m+[m[32m        $this->middleware('permission:article-delete', ['only' => ['destroy']]);[m
[32m+[m[32m        $this->articleService = $articleService;[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Display a listing of the resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function index()[m
[32m+[m[32m    {[m
[32m+[m[32m        return $this->articleService->paginateData();[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Show the form for creating a new resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function create()[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Store a newly created resource in storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param Request $request[m
[32m+[m[32m     * @return JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function store(Request $request)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return $this->articleService->createItem($request);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Display the specified resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param Article $article[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function show(Article $article)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Show the form for editing the specified resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param Article $article[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function edit(Article $article)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Update the specified resource in storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param Request $request[m
[32m+[m[32m     * @param Article $article[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function update(Request $request, Article $article)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Remove the specified resource from storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param Article $article[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function destroy(Article $article)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Controllers/Api/AuthController.php b/app/Http/Controllers/Api/AuthController.php[m
[1mnew file mode 100755[m
[1mindex 0000000..1f1dde8[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Controllers/Api/AuthController.php[m
[36m@@ -0,0 +1,78 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m
[32m+[m[32mnamespace App\Http\Controllers\Api;[m
[32m+[m
[32m+[m[32muse App\Repositories\UserRepository;[m
[32m+[m[32muse Illuminate\Http\Request;[m
[32m+[m[32muse Illuminate\Support\Facades\Validator;[m
[32m+[m[32muse Auth;[m
[32m+[m
[32m+[m[32mclass AuthController[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @var UserRepository[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $userRepository;[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * AuthController constructor.[m
[32m+[m[32m     * @param UserRepository $userRepository[m
[32m+[m[32m     */[m
[32m+[m[32m    public function __construct(UserRepository $userRepository)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        $this->userRepository = $userRepository;[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param Request $request[m
[32m+[m[32m     * @return \Illuminate\Http\JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function __invoke(Request $request)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m
[32m+[m[32m        $input = $request->all();[m
[32m+[m
[32m+[m[32m        $validator = Validator::make($request->all(), [[m
[32m+[m
[32m+[m[32m            'username'=>'required',[m
[32m+[m[32m            'password' => 'required'[m
[32m+[m
[32m+[m[32m        ]);[m
[32m+[m
[32m+[m[32m        if ($validator->fails()) {[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => 400, 'messages'=>config('status.status_code.400'), 'error'=>$validator->messages()->first()]);[m
[32m+[m
[32m+[m[32m        } else {[m
[32m+[m
[32m+[m[32m            $fieldType = filter_var($request->username, FILTER_VALIDATE_EMAIL) ? 'email' : 'username';[m
[32m+[m
[32m+[m[32m            if(Auth::attempt(array($fieldType => $input['username'], 'password' => $input['password'])) )[m
[32m+[m[32m            {[m
[32m+[m[32m                $user = Auth::user();[m
[32m+[m
[32m+[m[32m                $userInfo = $this->userRepository->get($user->id);[m
[32m+[m
[32m+[m[32m                $success['status_code']= 200;[m
[32m+[m[32m                $success['messages']= config('status.status_code.200');[m
[32m+[m[32m                $success['token'] = $user->createToken('Knowledge Base')->accessToken;[m
[32m+[m[32m                $success['user_info']=$userInfo;[m
[32m+[m
[32m+[m
[32m+[m[32m                return response()->json($success);[m
[32m+[m
[32m+[m[32m            } else {[m
[32m+[m
[32m+[m[32m                return response()->json(['status_code' => 401, 'messages'=>config('status.status_code.401')]);[m
[32m+[m[32m            }[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Controllers/Api/CategoryController.php b/app/Http/Controllers/Api/CategoryController.php[m
[1mnew file mode 100644[m
[1mindex 0000000..b175981[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Controllers/Api/CategoryController.php[m
[36m@@ -0,0 +1,162 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Controllers\Api;[m
[32m+[m
[32m+[m
[32m+[m[32muse App\Http\Controllers\Controller;[m
[32m+[m[32muse App\Services\CategoryService;[m
[32m+[m[32muse Illuminate\Http\JsonResponse;[m
[32m+[m[32muse Illuminate\Http\Request;[m
[32m+[m
[32m+[m[32mclass CategoryController extends Controller[m
[32m+[m[32m{[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @var CategoryService[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $categoryService;[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * CategoryController constructor.[m
[32m+[m[32m     * @param CategoryService $categoryService[m
[32m+[m[32m     *[m
[32m+[m[32m     */[m
[32m+[m[32m    public function __construct(CategoryService $categoryService)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        $this->middleware('auth');[m
[32m+[m[32m        $this->categoryService = $categoryService;[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function index()[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        if(Auth::user()->can('category-list')) {[m
[32m+[m
[32m+[m[32m            return $this->categoryService->getAll();[m
[32m+[m
[32m+[m[32m        } else {[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function create()[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        /*return view('categorys.create',compact('permissions'));*/[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param Request $request[m
[32m+[m[32m     * @return JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function store(Request $request)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        if(Auth::user()->can('category-create')) {[m
[32m+[m
[32m+[m[32m            return $this->categoryService->createItem($request);[m
[32m+[m
[32m+[m[32m        } else {[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function edit($id)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        /*$categorys = $this->categoryService->getById($id);[m
[32m+[m
[32m+[m[32m        $permissions = $this->permissionService->getAll();[m
[32m+[m[32m        $categoryPermissions = DB::table("category_has_permissions")->where("category_has_permissions.category_id",$id)[m
[32m+[m[32m            ->pluck('category_has_permissions.permission_id','category_has_permissions.permission_id')[m
[32m+[m[32m            ->all();[m
[32m+[m
[32m+[m
[32m+[m[32m        return view('categorys.edit',compact('categorys','permissions','categoryPermissions'));*/[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function show($id)[m
[32m+[m[32m    {[m
[32m+[m[32m        if(Auth::user()->can('category-list')) {[m
[32m+[m
[32m+[m[32m            return $this->categoryService->getById($id);[m
[32m+[m
[32m+[m[32m        } else {[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param Request $request[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     *[m
[32m+[m[32m     */[m
[32m+[m[32m    public function update(Request $request)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        if(Auth::user()->can('category-edit')) {[m
[32m+[m
[32m+[m[32m            return $this->categoryService->updateItem($request);[m
[32m+[m
[32m+[m[32m        } else {[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param Request $request[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function destroy(Request $request)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        if(Auth::user()->can('category-delete')) {[m
[32m+[m
[32m+[m[32m            return  $this->categoryService->deleteItem($request->id);[m
[32m+[m
[32m+[m[32m        } else {[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Controllers/Api/CommentController.php b/app/Http/Controllers/Api/CommentController.php[m
[1mnew file mode 100644[m
[1mindex 0000000..0a76f47[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Controllers/Api/CommentController.php[m
[36m@@ -0,0 +1,86 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Controllers\Api;[m
[32m+[m
[32m+[m[32muse App\Http\Controllers\Controller;[m
[32m+[m[32muse App\Models\Comment;[m
[32m+[m[32muse Illuminate\Http\Request;[m
[32m+[m
[32m+[m[32mclass CommentController extends Controller[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Display a listing of the resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function index()[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Show the form for creating a new resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function create()[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Store a newly created resource in storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \Illuminate\Http\Request  $request[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function store(Request $request)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Display the specified resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \App\Models\Comment  $comment[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function show(Comment $comment)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Show the form for editing the specified resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \App\Models\Comment  $comment[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function edit(Comment $comment)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Update the specified resource in storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \Illuminate\Http\Request  $request[m
[32m+[m[32m     * @param  \App\Models\Comment  $comment[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function update(Request $request, Comment $comment)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Remove the specified resource from storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \App\Models\Comment  $comment[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function destroy(Comment $comment)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Controllers/Api/MediaController.php b/app/Http/Controllers/Api/MediaController.php[m
[1mnew file mode 100644[m
[1mindex 0000000..f4c5e80[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Controllers/Api/MediaController.php[m
[36m@@ -0,0 +1,86 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Controllers\Api;[m
[32m+[m
[32m+[m[32muse App\Http\Controllers\Controller;[m
[32m+[m[32muse App\Models\Media;[m
[32m+[m[32muse Illuminate\Http\Request;[m
[32m+[m
[32m+[m[32mclass MediaController extends Controller[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Display a listing of the resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function index()[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Show the form for creating a new resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function create()[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Store a newly created resource in storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \Illuminate\Http\Request  $request[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function store(Request $request)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Display the specified resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \App\Media  $media[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function show(Media $media)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Show the form for editing the specified resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \App\Media  $media[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function edit(Media $media)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Update the specified resource in storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \Illuminate\Http\Request  $request[m
[32m+[m[32m     * @param  \App\Media  $media[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function update(Request $request, Media $media)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Remove the specified resource from storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \App\Media  $media[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function destroy(Media $media)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Controllers/Api/PageController.php b/app/Http/Controllers/Api/PageController.php[m
[1mnew file mode 100644[m
[1mindex 0000000..b4b9847[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Controllers/Api/PageController.php[m
[36m@@ -0,0 +1,86 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Controllers\Api;[m
[32m+[m
[32m+[m[32muse App\Http\Controllers\Controller;[m
[32m+[m[32muse App\Models\Page;[m
[32m+[m[32muse Illuminate\Http\Request;[m
[32m+[m
[32m+[m[32mclass PageController extends Controller[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Display a listing of the resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function index()[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Show the form for creating a new resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function create()[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Store a newly created resource in storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \Illuminate\Http\Request  $request[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function store(Request $request)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Display the specified resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \App\Models\Page  $page[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function show(Page $page)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Show the form for editing the specified resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \App\Models\Page  $page[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function edit(Page $page)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Update the specified resource in storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \Illuminate\Http\Request  $request[m
[32m+[m[32m     * @param  \App\Models\Page  $page[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function update(Request $request, Page $page)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Remove the specified resource from storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \App\Models\Page  $page[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function destroy(Page $page)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Controllers/Api/PermissionController.php b/app/Http/Controllers/Api/PermissionController.php[m
[1mnew file mode 100755[m
[1mindex 0000000..0f0b5de[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Controllers/Api/PermissionController.php[m
[36m@@ -0,0 +1,155 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Controllers\Api;[m
[32m+[m
[32m+[m[32muse App\Http\Controllers\Controller;[m
[32m+[m[32muse App\Services\PermissionService;[m
[32m+[m[32muse Illuminate\Http\JsonResponse;[m
[32m+[m[32muse Illuminate\Http\Request;[m
[32m+[m[32muse Auth;[m
[32m+[m
[32m+[m[32mclass PermissionController extends Controller[m
[32m+[m[32m{[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @var PermissionService[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $permissionService;[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * PermissionController constructor.[m
[32m+[m[32m     * @param PermissionService $permissionService[m
[32m+[m[32m     */[m
[32m+[m[32m    public function __construct(PermissionService $permissionService)[m
[32m+[m[32m    {[m
[32m+[m[32m        $this->middleware('auth');[m
[32m+[m[32m        $this->permissionService = $permissionService;[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function index()[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        if(Auth::user()->can('permission-list')) {[m
[32m+[m
[32m+[m[32m            return $this->permissionService->paginateData();[m
[32m+[m
[32m+[m[32m        } else {[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     *[m
[32m+[m[32m     */[m
[32m+[m[32m    public function create()[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        /*$permissions = $this->permissionService->getAll();[m
[32m+[m[32m        return view('permissions.create',compact('permissions'));*/[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param Request $request[m
[32m+[m[32m     * @return JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function store(Request $request)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        if(Auth::user()->can('permission-create')) {[m
[32m+[m
[32m+[m[32m            return $this->permissionService->createItem($request);[m
[32m+[m
[32m+[m[32m        } else {[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function edit($id)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        /*$permissions = $this->permissionService->getById($id);[m
[32m+[m
[32m+[m[32m        return view('permissions.edit',compact('permissions'));*/[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function show($id)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        if(Auth::user()->can('permission-list')) {[m
[32m+[m
[32m+[m[32m            return $this->permissionService->getById($id);[m
[32m+[m
[32m+[m[32m        } else {[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param Request $request[m
[32m+[m[32m     * @return JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function update(Request $request)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        if(Auth::user()->can('permission-edit')) {[m
[32m+[m
[32m+[m[32m            return $this->permissionService->updateItem($request);[m
[32m+[m
[32m+[m[32m        } else {[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param Request $request[m
[32m+[m[32m     * @return JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function destroy(Request $request)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        if(Auth::user()->can('permission-delete')) {[m
[32m+[m
[32m+[m[32m            return $this->permissionService->deleteItem($request->id);[m
[32m+[m
[32m+[m[32m        } else {[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Controllers/Api/QuizController.php b/app/Http/Controllers/Api/QuizController.php[m
[1mnew file mode 100644[m
[1mindex 0000000..5b7c02c[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Controllers/Api/QuizController.php[m
[36m@@ -0,0 +1,86 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Controllers\Api;[m
[32m+[m
[32m+[m[32muse App\Http\Controllers\Controller;[m
[32m+[m[32muse App\Models\Quiz;[m
[32m+[m[32muse Illuminate\Http\Request;[m
[32m+[m
[32m+[m[32mclass QuizController extends Controller[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Display a listing of the resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function index()[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Show the form for creating a new resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function create()[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Store a newly created resource in storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \Illuminate\Http\Request  $request[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function store(Request $request)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Display the specified resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \App\Models\Quiz  $quiz[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function show(Quiz $quiz)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Show the form for editing the specified resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \App\Models\Quiz  $quiz[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function edit(Quiz $quiz)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Update the specified resource in storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \Illuminate\Http\Request  $request[m
[32m+[m[32m     * @param  \App\Models\Quiz  $quiz[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function update(Request $request, Quiz $quiz)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Remove the specified resource from storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \App\Models\Quiz  $quiz[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function destroy(Quiz $quiz)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Controllers/Api/QuizFormController.php b/app/Http/Controllers/Api/QuizFormController.php[m
[1mnew file mode 100644[m
[1mindex 0000000..6a67a3a[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Controllers/Api/QuizFormController.php[m
[36m@@ -0,0 +1,86 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Controllers\Api;[m
[32m+[m
[32m+[m[32muse App\Http\Controllers\Controller;[m
[32m+[m[32muse App\Models\QuizForm;[m
[32m+[m[32muse Illuminate\Http\Request;[m
[32m+[m
[32m+[m[32mclass QuizFormController extends Controller[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Display a listing of the resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function index()[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Show the form for creating a new resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function create()[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Store a newly created resource in storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \Illuminate\Http\Request  $request[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function store(Request $request)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Display the specified resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \App\Models\QuizForm  $quizForm[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function show(QuizForm $quizForm)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Show the form for editing the specified resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \App\Models\QuizForm  $quizForm[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function edit(QuizForm $quizForm)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Update the specified resource in storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \Illuminate\Http\Request  $request[m
[32m+[m[32m     * @param  \App\Models\QuizForm  $quizForm[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function update(Request $request, QuizForm $quizForm)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Remove the specified resource from storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \App\Models\QuizForm  $quizForm[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function destroy(QuizForm $quizForm)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Controllers/Api/QuizFormFieldController.php b/app/Http/Controllers/Api/QuizFormFieldController.php[m
[1mnew file mode 100644[m
[1mindex 0000000..f7556e2[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Controllers/Api/QuizFormFieldController.php[m
[36m@@ -0,0 +1,86 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Controllers\Api;[m
[32m+[m
[32m+[m[32muse App\Http\Controllers\Controller;[m
[32m+[m[32muse App\Models\QuizFormField;[m
[32m+[m[32muse Illuminate\Http\Request;[m
[32m+[m
[32m+[m[32mclass QuizFormFieldController extends Controller[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Display a listing of the resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function index()[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Show the form for creating a new resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function create()[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Store a newly created resource in storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \Illuminate\Http\Request  $request[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function store(Request $request)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Display the specified resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \App\Models\QuizFormField  $quizFormField[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function show(QuizFormField $quizFormField)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Show the form for editing the specified resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \App\Models\QuizFormField  $quizFormField[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function edit(QuizFormField $quizFormField)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Update the specified resource in storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \Illuminate\Http\Request  $request[m
[32m+[m[32m     * @param  \App\Models\QuizFormField  $quizFormField[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function update(Request $request, QuizFormField $quizFormField)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Remove the specified resource from storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \App\Models\QuizFormField  $quizFormField[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function destroy(QuizFormField $quizFormField)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Controllers/Api/RoleController.php b/app/Http/Controllers/Api/RoleController.php[m
[1mnew file mode 100755[m
[1mindex 0000000..6793327[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Controllers/Api/RoleController.php[m
[36m@@ -0,0 +1,171 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Controllers\Api;[m
[32m+[m
[32m+[m
[32m+[m[32muse App\Http\Controllers\Controller;[m
[32m+[m[32muse App\Services\PermissionService;[m
[32m+[m[32muse App\Services\RoleService;[m
[32m+[m[32muse Illuminate\Http\JsonResponse;[m
[32m+[m[32muse Illuminate\Http\Request;[m
[32m+[m[32muse Auth;[m
[32m+[m
[32m+[m[32mclass RoleController extends Controller[m
[32m+[m[32m{[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @var RoleService[m
[32m+[m[32m     * @var permissionService[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $roleService;[m
[32m+[m[32m    protected $permissionService;[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * RoleController constructor.[m
[32m+[m[32m     * @param RoleService $roleService[m
[32m+[m[32m     * @param PermissionService $permissionService[m
[32m+[m[32m     */[m
[32m+[m[32m    public function __construct(RoleService $roleService, PermissionService $permissionService)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        $this->middleware('auth');[m
[32m+[m[32m        $this->roleService = $roleService;[m
[32m+[m[32m        $this->permissionService = $permissionService;[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function index()[m
[32m+[m[32m    {[m
[32m+[m[32m        if(Auth::user()->can('role-list')) {[m
[32m+[m
[32m+[m[32m            return $this->roleService->paginateData();[m
[32m+[m
[32m+[m[32m        } else {[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function create()[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        /*$permissions = $this->permissionService->getAll();[m
[32m+[m
[32m+[m[32m        return view('roles.create',compact('permissions'));*/[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param Request $request[m
[32m+[m[32m     * @return JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function store(Request $request)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        if(Auth::user()->can('role-create')) {[m
[32m+[m
[32m+[m[32m            return $this->roleService->createItem($request);[m
[32m+[m
[32m+[m[32m        } else {[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function edit($id)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        /*$roles = $this->roleService->getById($id);[m
[32m+[m
[32m+[m[32m        $permissions = $this->permissionService->getAll();[m
[32m+[m[32m        $rolePermissions = DB::table("role_has_permissions")->where("role_has_permissions.role_id",$id)[m
[32m+[m[32m            ->pluck('role_has_permissions.permission_id','role_has_permissions.permission_id')[m
[32m+[m[32m            ->all();[m
[32m+[m
[32m+[m
[32m+[m[32m        return view('roles.edit',compact('roles','permissions','rolePermissions'));*/[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function show($id)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        if(Auth::user()->can('role-list')) {[m
[32m+[m
[32m+[m[32m            return $this->roleService->getById($id);[m
[32m+[m
[32m+[m[32m        } else {[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param Request $request[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     *[m
[32m+[m[32m     */[m
[32m+[m[32m    public function update(Request $request)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        if(Auth::user()->can('role-edit')) {[m
[32m+[m
[32m+[m[32m            return $this->roleService->updateItem($request);[m
[32m+[m
[32m+[m[32m        } else {[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param Request $request[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function destroy(Request $request)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        if(Auth::user()->can('role-delete')) {[m
[32m+[m
[32m+[m[32m            return  $this->roleService->deleteItem($request->id);[m
[32m+[m
[32m+[m[32m        } else {[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Controllers/Api/TagController.php b/app/Http/Controllers/Api/TagController.php[m
[1mnew file mode 100644[m
[1mindex 0000000..fb0d161[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Controllers/Api/TagController.php[m
[36m@@ -0,0 +1,86 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Controllers\Api;[m
[32m+[m
[32m+[m[32muse App\Http\Controllers\Controller;[m
[32m+[m[32muse App\Models\Tag;[m
[32m+[m[32muse Illuminate\Http\Request;[m
[32m+[m
[32m+[m[32mclass TagController extends Controller[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Display a listing of the resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function index()[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Show the form for creating a new resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function create()[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Store a newly created resource in storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \Illuminate\Http\Request  $request[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function store(Request $request)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Display the specified resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \App\Tag  $tag[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function show(Tag $tag)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Show the form for editing the specified resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \App\Tag  $tag[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function edit(Tag $tag)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Update the specified resource in storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \Illuminate\Http\Request  $request[m
[32m+[m[32m     * @param  \App\Tag  $tag[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function update(Request $request, Tag $tag)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Remove the specified resource from storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \App\Tag  $tag[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function destroy(Tag $tag)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Controllers/Api/TeamController.php b/app/Http/Controllers/Api/TeamController.php[m
[1mnew file mode 100644[m
[1mindex 0000000..f024d99[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Controllers/Api/TeamController.php[m
[36m@@ -0,0 +1,86 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Controllers\Api;[m
[32m+[m
[32m+[m[32muse App\Http\Controllers\Controller;[m
[32m+[m[32muse App\Models\Team;[m
[32m+[m[32muse Illuminate\Http\Request;[m
[32m+[m
[32m+[m[32mclass TeamController extends Controller[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Display a listing of the resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function index()[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Show the form for creating a new resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function create()[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Store a newly created resource in storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \Illuminate\Http\Request  $request[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function store(Request $request)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Display the specified resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \App\Models\Team  $team[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function show(Team $team)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Show the form for editing the specified resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \App\Models\Team  $team[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function edit(Team $team)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Update the specified resource in storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \Illuminate\Http\Request  $request[m
[32m+[m[32m     * @param  \App\Models\Team  $team[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function update(Request $request, Team $team)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Remove the specified resource from storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \App\Models\Team  $team[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function destroy(Team $team)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Controllers/Api/UserController.php b/app/Http/Controllers/Api/UserController.php[m
[1mnew file mode 100755[m
[1mindex 0000000..e747b14[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Controllers/Api/UserController.php[m
[36m@@ -0,0 +1,116 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Controllers\Api;[m
[32m+[m
[32m+[m[32muse App\Http\Controllers\Controller;[m
[32m+[m[32muse App\Services\UserService;[m
[32m+[m[32muse Illuminate\Http\JsonResponse;[m
[32m+[m[32muse Illuminate\Http\Request;[m
[32m+[m
[32m+[m[32mclass UserController extends Controller[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @var UserService[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $userService;[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * UserController constructor.[m
[32m+[m[32m     * @param UserService $userService[m
[32m+[m[32m     */[m
[32m+[m[32m    public function __construct(UserService $userService)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        $this->middleware('acl:super-admin');[m
[32m+[m[32m        $this->userService = $userService;[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function index()[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return $this->userService->paginateData();[m
[32m+[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function create()[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        /*$roles = Role::pluck('name', 'name')->all();[m
[32m+[m
[32m+[m[32m        return view('users.create', compact('roles'));*/[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param Request $request[m
[32m+[m[32m     * @return JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function store(Request $request)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return $this->userService->createItem($request);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function show($id)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return $this->userService->getById($id);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function edit($id)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        /*$users = $this->userService->getById($id);[m
[32m+[m[32m        $roles = Role::pluck('name','name')->all();[m
[32m+[m[32m        $userRole = $users->roles->pluck('name','name')->all();[m
[32m+[m
[32m+[m[32m        return view('users.edit',compact('users','roles','userRole'));*/[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param Request $request[m
[32m+[m[32m     * @return JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function update(Request $request)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return $this->userService->updateItem($request);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param Request $request[m
[32m+[m[32m     * @return JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function destroy(Request $request)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return  $this->userService->deleteItem($request->id);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Controllers/Api/UserTeamController.php b/app/Http/Controllers/Api/UserTeamController.php[m
[1mnew file mode 100644[m
[1mindex 0000000..1c27f12[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Controllers/Api/UserTeamController.php[m
[36m@@ -0,0 +1,86 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Controllers\Api;[m
[32m+[m
[32m+[m[32muse App\Http\Controllers\Controller;[m
[32m+[m[32muse App\Models\UserTeam;[m
[32m+[m[32muse Illuminate\Http\Request;[m
[32m+[m
[32m+[m[32mclass UserTeamController extends Controller[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Display a listing of the resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function index()[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Show the form for creating a new resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function create()[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Store a newly created resource in storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \Illuminate\Http\Request  $request[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function store(Request $request)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Display the specified resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \App\UserTeam  $userTeam[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function show(UserTeam $userTeam)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Show the form for editing the specified resource.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \App\UserTeam  $userTeam[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function edit(UserTeam $userTeam)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Update the specified resource in storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \Illuminate\Http\Request  $request[m
[32m+[m[32m     * @param  \App\UserTeam  $userTeam[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function update(Request $request, UserTeam $userTeam)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Remove the specified resource from storage.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \App\UserTeam  $userTeam[m
[32m+[m[32m     * @return \Illuminate\Http\Response[m
[32m+[m[32m     */[m
[32m+[m[32m    public function destroy(UserTeam $userTeam)[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Controllers/Auth/ForgotPasswordController.php b/app/Http/Controllers/Auth/ForgotPasswordController.php[m
[1mnew file mode 100755[m
[1mindex 0000000..6a247fe[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Controllers/Auth/ForgotPasswordController.php[m
[36m@@ -0,0 +1,32 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Controllers\Auth;[m
[32m+[m
[32m+[m[32muse App\Http\Controllers\Controller;[m
[32m+[m[32muse Illuminate\Foundation\Auth\SendsPasswordResetEmails;[m
[32m+[m
[32m+[m[32mclass ForgotPasswordController extends Controller[m
[32m+[m[32m{[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Password Reset Controller[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | This controller is responsible for handling password reset emails and[m
[32m+[m[32m    | includes a trait which assists in sending these notifications from[m
[32m+[m[32m    | your application to your users. Feel free to explore this trait.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    use SendsPasswordResetEmails;[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Create a new controller instance.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function __construct()[m
[32m+[m[32m    {[m
[32m+[m[32m        $this->middleware('guest');[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Controllers/Auth/LoginController.php b/app/Http/Controllers/Auth/LoginController.php[m
[1mnew file mode 100755[m
[1mindex 0000000..b2ea669[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Controllers/Auth/LoginController.php[m
[36m@@ -0,0 +1,39 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Controllers\Auth;[m
[32m+[m
[32m+[m[32muse App\Http\Controllers\Controller;[m
[32m+[m[32muse Illuminate\Foundation\Auth\AuthenticatesUsers;[m
[32m+[m
[32m+[m[32mclass LoginController extends Controller[m
[32m+[m[32m{[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Login Controller[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | This controller handles authenticating users for the application and[m
[32m+[m[32m    | redirecting them to your home screen. The controller uses a trait[m
[32m+[m[32m    | to conveniently provide its functionality to your applications.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    use AuthenticatesUsers;[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Where to redirect users after login.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @var string[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $redirectTo = '/home';[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Create a new controller instance.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function __construct()[m
[32m+[m[32m    {[m
[32m+[m[32m        $this->middleware('guest')->except('logout');[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Controllers/Auth/RegisterController.php b/app/Http/Controllers/Auth/RegisterController.php[m
[1mnew file mode 100755[m
[1mindex 0000000..85b9057[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Controllers/Auth/RegisterController.php[m
[36m@@ -0,0 +1,72 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Controllers\Auth;[m
[32m+[m
[32m+[m[32muse App\User;[m
[32m+[m[32muse App\Http\Controllers\Controller;[m
[32m+[m[32muse Illuminate\Support\Facades\Hash;[m
[32m+[m[32muse Illuminate\Support\Facades\Validator;[m
[32m+[m[32muse Illuminate\Foundation\Auth\RegistersUsers;[m
[32m+[m
[32m+[m[32mclass RegisterController extends Controller[m
[32m+[m[32m{[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Register Controller[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | This controller handles the registration of new users as well as their[m
[32m+[m[32m    | validation and creation. By default this controller uses a trait to[m
[32m+[m[32m    | provide this functionality without requiring any additional code.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    use RegistersUsers;[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Where to redirect users after registration.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @var string[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $redirectTo = '/home';[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Create a new controller instance.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function __construct()[m
[32m+[m[32m    {[m
[32m+[m[32m        $this->middleware('guest');[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Get a validator for an incoming registration request.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  array  $data[m
[32m+[m[32m     * @return \Illuminate\Contracts\Validation\Validator[m
[32m+[m[32m     */[m
[32m+[m[32m    protected function validator(array $data)[m
[32m+[m[32m    {[m
[32m+[m[32m        return Validator::make($data, [[m
[32m+[m[32m            'name' => ['required', 'string', 'max:255'],[m
[32m+[m[32m            'email' => ['required', 'string', 'email', 'max:255', 'unique:users'],[m
[32m+[m[32m            'password' => ['required', 'string', 'min:8', 'confirmed'],[m
[32m+[m[32m        ]);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Create a new user instance after a valid registration.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  array  $data[m
[32m+[m[32m     * @return \App\User[m
[32m+[m[32m     */[m
[32m+[m[32m    protected function create(array $data)[m
[32m+[m[32m    {[m
[32m+[m[32m        return User::create([[m
[32m+[m[32m            'name' => $data['name'],[m
[32m+[m[32m            'email' => $data['email'],[m
[32m+[m[32m            'password' => Hash::make($data['password']),[m
[32m+[m[32m        ]);[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Controllers/Auth/ResetPasswordController.php b/app/Http/Controllers/Auth/ResetPasswordController.php[m
[1mnew file mode 100755[m
[1mindex 0000000..cf726ee[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Controllers/Auth/ResetPasswordController.php[m
[36m@@ -0,0 +1,39 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Controllers\Auth;[m
[32m+[m
[32m+[m[32muse App\Http\Controllers\Controller;[m
[32m+[m[32muse Illuminate\Foundation\Auth\ResetsPasswords;[m
[32m+[m
[32m+[m[32mclass ResetPasswordController extends Controller[m
[32m+[m[32m{[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Password Reset Controller[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | This controller is responsible for handling password reset requests[m
[32m+[m[32m    | and uses a simple trait to include this behavior. You're free to[m
[32m+[m[32m    | explore this trait and override any methods you wish to tweak.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    use ResetsPasswords;[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Where to redirect users after resetting their password.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @var string[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $redirectTo = '/home';[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Create a new controller instance.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function __construct()[m
[32m+[m[32m    {[m
[32m+[m[32m        $this->middleware('guest');[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Controllers/Auth/VerificationController.php b/app/Http/Controllers/Auth/VerificationController.php[m
[1mnew file mode 100755[m
[1mindex 0000000..23a43a8[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Controllers/Auth/VerificationController.php[m
[36m@@ -0,0 +1,41 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Controllers\Auth;[m
[32m+[m
[32m+[m[32muse App\Http\Controllers\Controller;[m
[32m+[m[32muse Illuminate\Foundation\Auth\VerifiesEmails;[m
[32m+[m
[32m+[m[32mclass VerificationController extends Controller[m
[32m+[m[32m{[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Email Verification Controller[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | This controller is responsible for handling email verification for any[m
[32m+[m[32m    | user that recently registered with the application. Emails may also[m
[32m+[m[32m    | be re-sent if the user didn't receive the original email message.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    use VerifiesEmails;[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Where to redirect users after verification.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @var string[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $redirectTo = '/home';[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Create a new controller instance.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function __construct()[m
[32m+[m[32m    {[m
[32m+[m[32m        $this->middleware('auth');[m
[32m+[m[32m        $this->middleware('signed')->only('verify');[m
[32m+[m[32m        $this->middleware('throttle:6,1')->only('verify', 'resend');[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Controllers/Controller.php b/app/Http/Controllers/Controller.php[m
[1mnew file mode 100755[m
[1mindex 0000000..03e02a2[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Controllers/Controller.php[m
[36m@@ -0,0 +1,13 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Controllers;[m
[32m+[m
[32m+[m[32muse Illuminate\Foundation\Bus\DispatchesJobs;[m
[32m+[m[32muse Illuminate\Routing\Controller as BaseController;[m
[32m+[m[32muse Illuminate\Foundation\Validation\ValidatesRequests;[m
[32m+[m[32muse Illuminate\Foundation\Auth\Access\AuthorizesRequests;[m
[32m+[m
[32m+[m[32mclass Controller extends BaseController[m
[32m+[m[32m{[m
[32m+[m[32m    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Controllers/HomeController.php b/app/Http/Controllers/HomeController.php[m
[1mnew file mode 100755[m
[1mindex 0000000..f593d1c[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Controllers/HomeController.php[m
[36m@@ -0,0 +1,33 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Controllers;[m
[32m+[m
[32m+[m[32muse Illuminate\Http\Request;[m
[32m+[m[32muse Auth;[m
[32m+[m
[32m+[m[32mclass HomeController extends Controller[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Create a new controller instance.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function __construct()[m
[32m+[m[32m    {[m
[32m+[m[32m        $this->middleware('acl:super-admin');[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Show the application dashboard.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return \Illuminate\Contracts\Support\Renderable[m
[32m+[m[32m     */[m
[32m+[m[32m    public function index(Request $request)[m
[32m+[m[32m    {[m
[32m+[m[32m        $user = Auth::user(); //getting the current logged in user[m
[32m+[m
[32m+[m[32m        dd($user->can('team-list')); // and so on[m
[32m+[m
[32m+[m[32m        return view('home');[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Kernel.php b/app/Http/Kernel.php[m
[1mnew file mode 100755[m
[1mindex 0000000..730f840[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Kernel.php[m
[36m@@ -0,0 +1,81 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http;[m
[32m+[m
[32m+[m[32muse Illuminate\Foundation\Http\Kernel as HttpKernel;[m
[32m+[m
[32m+[m[32mclass Kernel extends HttpKernel[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * The application's global HTTP middleware stack.[m
[32m+[m[32m     *[m
[32m+[m[32m     * These middleware are run during every request to your application.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @var array[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $middleware = [[m
[32m+[m[32m        \App\Http\Middleware\TrustProxies::class,[m
[32m+[m[32m        \App\Http\Middleware\CheckForMaintenanceMode::class,[m
[32m+[m[32m        \Illuminate\Foundation\Http\Middleware\ValidatePostSize::class,[m
[32m+[m[32m        \App\Http\Middleware\TrimStrings::class,[m
[32m+[m[32m        \Illuminate\Foundation\Http\Middleware\ConvertEmptyStringsToNull::class,[m
[32m+[m[32m    ];[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * The application's route middleware groups.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @var array[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $middlewareGroups = [[m
[32m+[m[32m        'web' => [[m
[32m+[m[32m            \App\Http\Middleware\EncryptCookies::class,[m
[32m+[m[32m            \Illuminate\Cookie\Middleware\AddQueuedCookiesToResponse::class,[m
[32m+[m[32m            \Illuminate\Session\Middleware\StartSession::class,[m
[32m+[m[32m            // \Illuminate\Session\Middleware\AuthenticateSession::class,[m
[32m+[m[32m            \Illuminate\View\Middleware\ShareErrorsFromSession::class,[m
[32m+[m[32m            \App\Http\Middleware\VerifyCsrfToken::class,[m
[32m+[m[32m            \Illuminate\Routing\Middleware\SubstituteBindings::class,[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        'api' => [[m
[32m+[m[32m            'throttle:60,1',[m
[32m+[m[32m            'bindings',[m
[32m+[m[32m        ],[m
[32m+[m[32m    ];[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * The application's route middleware.[m
[32m+[m[32m     *[m
[32m+[m[32m     * These middleware may be assigned to groups or used individually.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @var array[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $routeMiddleware = [[m
[32m+[m[32m        'auth' => \App\Http\Middleware\Authenticate::class,[m
[32m+[m[32m        'auth.basic' => \Illuminate\Auth\Middleware\AuthenticateWithBasicAuth::class,[m
[32m+[m[32m        'bindings' => \Illuminate\Routing\Middleware\SubstituteBindings::class,[m
[32m+[m[32m        'cache.headers' => \Illuminate\Http\Middleware\SetCacheHeaders::class,[m
[32m+[m[32m        'can' => \Illuminate\Auth\Middleware\Authorize::class,[m
[32m+[m[32m        'guest' => \App\Http\Middleware\RedirectIfAuthenticated::class,[m
[32m+[m[32m        'signed' => \Illuminate\Routing\Middleware\ValidateSignature::class,[m
[32m+[m[32m        'throttle' => \Illuminate\Routing\Middleware\ThrottleRequests::class,[m
[32m+[m[32m        'verified' => \Illuminate\Auth\Middleware\EnsureEmailIsVerified::class,[m
[32m+[m[32m        'acl' => \App\Http\Middleware\AclMiddleware::class,[m
[32m+[m[32m    ];[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * The priority-sorted list of middleware.[m
[32m+[m[32m     *[m
[32m+[m[32m     * This forces non-global middleware to always be in the given order.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @var array[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $middlewarePriority = [[m
[32m+[m[32m        \Illuminate\Session\Middleware\StartSession::class,[m
[32m+[m[32m        \Illuminate\View\Middleware\ShareErrorsFromSession::class,[m
[32m+[m[32m        \App\Http\Middleware\Authenticate::class,[m
[32m+[m[32m        \Illuminate\Session\Middleware\AuthenticateSession::class,[m
[32m+[m[32m        \Illuminate\Routing\Middleware\SubstituteBindings::class,[m
[32m+[m[32m        \Illuminate\Auth\Middleware\Authorize::class,[m
[32m+[m[32m    ];[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Middleware/AclMiddleware.php b/app/Http/Middleware/AclMiddleware.php[m
[1mnew file mode 100755[m
[1mindex 0000000..fd472a6[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Middleware/AclMiddleware.php[m
[36m@@ -0,0 +1,33 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Middleware;[m
[32m+[m
[32m+[m[32muse Closure;[m
[32m+[m
[32m+[m[32mclass AclMiddleware[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Handle an incoming request.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \Illuminate\Http\Request  $request[m
[32m+[m[32m     * @param  \Closure  $next[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function handle($request, Closure $next, $role, $permission = null)[m
[32m+[m[32m    {[m
[32m+[m[32m        if(!$request->user()->hasRole($role)) {[m
[32m+[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        if($permission !== null && !$request->user()->can($permission)) {[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        return $next($request);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Middleware/Authenticate.php b/app/Http/Middleware/Authenticate.php[m
[1mnew file mode 100755[m
[1mindex 0000000..a4be5c5[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Middleware/Authenticate.php[m
[36m@@ -0,0 +1,21 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Middleware;[m
[32m+[m
[32m+[m[32muse Illuminate\Auth\Middleware\Authenticate as Middleware;[m
[32m+[m
[32m+[m[32mclass Authenticate extends Middleware[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Get the path the user should be redirected to when they are not authenticated.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \Illuminate\Http\Request  $request[m
[32m+[m[32m     * @return string[m
[32m+[m[32m     */[m
[32m+[m[32m    protected function redirectTo($request)[m
[32m+[m[32m    {[m
[32m+[m[32m        if (! $request->expectsJson()) {[m
[32m+[m[32m            return route('login');[m
[32m+[m[32m        }[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Middleware/CheckForMaintenanceMode.php b/app/Http/Middleware/CheckForMaintenanceMode.php[m
[1mnew file mode 100755[m
[1mindex 0000000..35b9824[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Middleware/CheckForMaintenanceMode.php[m
[36m@@ -0,0 +1,17 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Middleware;[m
[32m+[m
[32m+[m[32muse Illuminate\Foundation\Http\Middleware\CheckForMaintenanceMode as Middleware;[m
[32m+[m
[32m+[m[32mclass CheckForMaintenanceMode extends Middleware[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * The URIs that should be reachable while maintenance mode is enabled.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @var array[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $except = [[m
[32m+[m[32m        //[m
[32m+[m[32m    ];[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Middleware/EncryptCookies.php b/app/Http/Middleware/EncryptCookies.php[m
[1mnew file mode 100755[m
[1mindex 0000000..033136a[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Middleware/EncryptCookies.php[m
[36m@@ -0,0 +1,17 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Middleware;[m
[32m+[m
[32m+[m[32muse Illuminate\Cookie\Middleware\EncryptCookies as Middleware;[m
[32m+[m
[32m+[m[32mclass EncryptCookies extends Middleware[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * The names of the cookies that should not be encrypted.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @var array[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $except = [[m
[32m+[m[32m        //[m
[32m+[m[32m    ];[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Middleware/RedirectIfAuthenticated.php b/app/Http/Middleware/RedirectIfAuthenticated.php[m
[1mnew file mode 100755[m
[1mindex 0000000..e4cec9c[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Middleware/RedirectIfAuthenticated.php[m
[36m@@ -0,0 +1,26 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Middleware;[m
[32m+[m
[32m+[m[32muse Closure;[m
[32m+[m[32muse Illuminate\Support\Facades\Auth;[m
[32m+[m
[32m+[m[32mclass RedirectIfAuthenticated[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Handle an incoming request.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  \Illuminate\Http\Request  $request[m
[32m+[m[32m     * @param  \Closure  $next[m
[32m+[m[32m     * @param  string|null  $guard[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function handle($request, Closure $next, $guard = null)[m
[32m+[m[32m    {[m
[32m+[m[32m        if (Auth::guard($guard)->check()) {[m
[32m+[m[32m            return redirect('/home');[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        return $next($request);[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Middleware/TrimStrings.php b/app/Http/Middleware/TrimStrings.php[m
[1mnew file mode 100755[m
[1mindex 0000000..5a50e7b[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Middleware/TrimStrings.php[m
[36m@@ -0,0 +1,18 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Middleware;[m
[32m+[m
[32m+[m[32muse Illuminate\Foundation\Http\Middleware\TrimStrings as Middleware;[m
[32m+[m
[32m+[m[32mclass TrimStrings extends Middleware[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * The names of the attributes that should not be trimmed.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @var array[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $except = [[m
[32m+[m[32m        'password',[m
[32m+[m[32m        'password_confirmation',[m
[32m+[m[32m    ];[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Middleware/TrustProxies.php b/app/Http/Middleware/TrustProxies.php[m
[1mnew file mode 100755[m
[1mindex 0000000..12fdf8b[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Middleware/TrustProxies.php[m
[36m@@ -0,0 +1,23 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Middleware;[m
[32m+[m
[32m+[m[32muse Illuminate\Http\Request;[m
[32m+[m[32muse Fideloper\Proxy\TrustProxies as Middleware;[m
[32m+[m
[32m+[m[32mclass TrustProxies extends Middleware[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * The trusted proxies for this application.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @var array|string[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $proxies;[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * The headers that should be used to detect proxies.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @var int[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $headers = Request::HEADER_X_FORWARDED_ALL;[m
[32m+[m[32m}[m
[1mdiff --git a/app/Http/Middleware/VerifyCsrfToken.php b/app/Http/Middleware/VerifyCsrfToken.php[m
[1mnew file mode 100755[m
[1mindex 0000000..324a166[m
[1m--- /dev/null[m
[1m+++ b/app/Http/Middleware/VerifyCsrfToken.php[m
[36m@@ -0,0 +1,24 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Http\Middleware;[m
[32m+[m
[32m+[m[32muse Illuminate\Foundation\Http\Middleware\VerifyCsrfToken as Middleware;[m
[32m+[m
[32m+[m[32mclass VerifyCsrfToken extends Middleware[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Indicates whether the XSRF-TOKEN cookie should be set on the response.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @var bool[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $addHttpCookie = true;[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * The URIs that should be excluded from CSRF verification.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @var array[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $except = [[m
[32m+[m[32m        //[m
[32m+[m[32m    ];[m
[32m+[m[32m}[m
[1mdiff --git a/app/Models/Article.php b/app/Models/Article.php[m
[1mnew file mode 100644[m
[1mindex 0000000..5d76b43[m
[1m--- /dev/null[m
[1m+++ b/app/Models/Article.php[m
[36m@@ -0,0 +1,10 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Models;[m
[32m+[m
[32m+[m[32muse Illuminate\Database\Eloquent\Model;[m
[32m+[m
[32m+[m[32mclass Article extends Model[m
[32m+[m[32m{[m
[32m+[m[32m    //[m
[32m+[m[32m}[m
[1mdiff --git a/app/Models/Category.php b/app/Models/Category.php[m
[1mnew file mode 100644[m
[1mindex 0000000..efadf64[m
[1m--- /dev/null[m
[1m+++ b/app/Models/Category.php[m
[36m@@ -0,0 +1,50 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Models;[m
[32m+[m
[32m+[m[32muse Illuminate\Database\Eloquent\Model;[m
[32m+[m[32muse Illuminate\Database\Eloquent\Relations\BelongsTo;[m
[32m+[m[32muse Illuminate\Database\Eloquent\Relations\HasMany;[m
[32m+[m
[32m+[m[32mclass Category extends Model[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @var string[][m
[32m+[m[32m     */[m
[32m+[m[32m    public $fillable = ['title','parent_id', 'slug'];[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return HasMany[m
[32m+[m[32m     */[m
[32m+[m[32m    public function children()[m
[32m+[m[32m    {[m
[32m+[m[32m        return $this->hasMany('App\Models\Category', 'parent_id');[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return HasMany[m
[32m+[m[32m     */[m
[32m+[m[32m    public function childrenRecursive()[m
[32m+[m[32m    {[m
[32m+[m[32m        return $this->children()->with('childrenRecursive');[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return BelongsTo[m
[32m+[m[32m     */[m
[32m+[m[32m    public function parent()[m
[32m+[m[32m    {[m
[32m+[m[32m        return $this->belongsTo('App\Models\Parent','parent_id');[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return BelongsTo[m
[32m+[m[32m     */[m
[32m+[m[32m    public function parentRecursive()[m
[32m+[m[32m    {[m
[32m+[m[32m        return $this->parent()->with('parentRecursive');[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Models/Comment.php b/app/Models/Comment.php[m
[1mnew file mode 100644[m
[1mindex 0000000..0eb9180[m
[1m--- /dev/null[m
[1m+++ b/app/Models/Comment.php[m
[36m@@ -0,0 +1,10 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Models;[m
[32m+[m
[32m+[m[32muse Illuminate\Database\Eloquent\Model;[m
[32m+[m
[32m+[m[32mclass Comment extends Model[m
[32m+[m[32m{[m
[32m+[m[32m    //[m
[32m+[m[32m}[m
[1mdiff --git a/app/Models/Media.php b/app/Models/Media.php[m
[1mnew file mode 100644[m
[1mindex 0000000..aa558f4[m
[1m--- /dev/null[m
[1m+++ b/app/Models/Media.php[m
[36m@@ -0,0 +1,22 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Models;[m
[32m+[m
[32m+[m[32muse Illuminate\Database\Eloquent\Model;[m
[32m+[m
[32m+[m[32mclass Media extends Model[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @var string[][m
[32m+[m[32m     */[m
[32m+[m[32m    protected $fillable = ['url'];[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return MorphTo[m
[32m+[m[32m     */[m
[32m+[m[32m    public function Mediable()[m
[32m+[m[32m    {[m
[32m+[m[32m        return $this->morphTo();[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Models/Page.php b/app/Models/Page.php[m
[1mnew file mode 100644[m
[1mindex 0000000..9384d62[m
[1m--- /dev/null[m
[1m+++ b/app/Models/Page.php[m
[36m@@ -0,0 +1,10 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Models;[m
[32m+[m
[32m+[m[32muse Illuminate\Database\Eloquent\Model;[m
[32m+[m
[32m+[m[32mclass Page extends Model[m
[32m+[m[32m{[m
[32m+[m[32m    //[m
[32m+[m[32m}[m
[1mdiff --git a/app/Models/Permission.php b/app/Models/Permission.php[m
[1mnew file mode 100755[m
[1mindex 0000000..409d59e[m
[1m--- /dev/null[m
[1m+++ b/app/Models/Permission.php[m
[36m@@ -0,0 +1,25 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Models;[m
[32m+[m
[32m+[m[32muse Illuminate\Database\Eloquent\Model;[m
[32m+[m
[32m+[m[32mclass Permission extends Model[m
[32m+[m[32m{[m
[32m+[m
[32m+[m[32m    protected $fillable = ['name', 'slug'];[m
[32m+[m
[32m+[m[32m    public function roles()[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return $this->belongsToMany(Role::class,'roles_permissions');[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public function users()[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return $this->belongsToMany(User::class,'users_permissions', 'user_id');[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Models/Quiz.php b/app/Models/Quiz.php[m
[1mnew file mode 100644[m
[1mindex 0000000..14df5a0[m
[1m--- /dev/null[m
[1m+++ b/app/Models/Quiz.php[m
[36m@@ -0,0 +1,10 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Models;[m
[32m+[m
[32m+[m[32muse Illuminate\Database\Eloquent\Model;[m
[32m+[m
[32m+[m[32mclass Quiz extends Model[m
[32m+[m[32m{[m
[32m+[m[32m    //[m
[32m+[m[32m}[m
[1mdiff --git a/app/Models/QuizForm.php b/app/Models/QuizForm.php[m
[1mnew file mode 100644[m
[1mindex 0000000..9d66b4d[m
[1m--- /dev/null[m
[1m+++ b/app/Models/QuizForm.php[m
[36m@@ -0,0 +1,10 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Models;[m
[32m+[m
[32m+[m[32muse Illuminate\Database\Eloquent\Model;[m
[32m+[m
[32m+[m[32mclass QuizForm extends Model[m
[32m+[m[32m{[m
[32m+[m[32m    //[m
[32m+[m[32m}[m
[1mdiff --git a/app/Models/QuizFormField.php b/app/Models/QuizFormField.php[m
[1mnew file mode 100644[m
[1mindex 0000000..3744761[m
[1m--- /dev/null[m
[1m+++ b/app/Models/QuizFormField.php[m
[36m@@ -0,0 +1,10 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Models;[m
[32m+[m
[32m+[m[32muse Illuminate\Database\Eloquent\Model;[m
[32m+[m
[32m+[m[32mclass QuizFormField extends Model[m
[32m+[m[32m{[m
[32m+[m[32m    //[m
[32m+[m[32m}[m
[1mdiff --git a/app/Models/Role.php b/app/Models/Role.php[m
[1mnew file mode 100755[m
[1mindex 0000000..1a94351[m
[1m--- /dev/null[m
[1m+++ b/app/Models/Role.php[m
[36m@@ -0,0 +1,25 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Models;[m
[32m+[m
[32m+[m[32muse Illuminate\Database\Eloquent\Model;[m
[32m+[m
[32m+[m[32mclass Role extends Model[m
[32m+[m[32m{[m
[32m+[m
[32m+[m[32m    protected $fillable = ['name', 'slug'];[m
[32m+[m
[32m+[m[32m    public function permissions()[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return $this->belongsToMany(Permission::class,'roles_permissions');[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public function users()[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return $this->belongsToMany(User::class,'users_roles', 'user_id');[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Models/Team.php b/app/Models/Team.php[m
[1mnew file mode 100644[m
[1mindex 0000000..f77c56d[m
[1m--- /dev/null[m
[1m+++ b/app/Models/Team.php[m
[36m@@ -0,0 +1,10 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Models;[m
[32m+[m
[32m+[m[32muse Illuminate\Database\Eloquent\Model;[m
[32m+[m
[32m+[m[32mclass Team extends Model[m
[32m+[m[32m{[m
[32m+[m[32m    //[m
[32m+[m[32m}[m
[1mdiff --git a/app/Models/User.php b/app/Models/User.php[m
[1mnew file mode 100755[m
[1mindex 0000000..94cea66[m
[1m--- /dev/null[m
[1m+++ b/app/Models/User.php[m
[36m@@ -0,0 +1,46 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Models;[m
[32m+[m
[32m+[m[32muse App\Permissions\HasPermissionsTrait;[m
[32m+[m[32muse Illuminate\Notifications\Notifiable;[m
[32m+[m[32muse Illuminate\Contracts\Auth\MustVerifyEmail;[m
[32m+[m[32muse Illuminate\Foundation\Auth\User as Authenticatable;[m
[32m+[m[32muse Laravel\Passport\HasApiTokens;[m
[32m+[m
[32m+[m[32mclass User extends Authenticatable[m
[32m+[m[32m{[m
[32m+[m[32m    use HasPermissionsTrait, Notifiable, HasApiTokens;[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * The attributes that are mass assignable.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @var array[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $fillable = [[m
[32m+[m[32m        'id', 'username', 'first_name', 'last_name', 'email', 'password',[m
[32m+[m[32m    ];[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * The attributes that should be hidden for arrays.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @var array[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $hidden = [[m
[32m+[m[32m        'password', 'remember_token',[m
[32m+[m[32m    ];[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * The attributes that should be cast to native types.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @var array[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $casts = [[m
[32m+[m[32m        'email_verified_at' => 'datetime',[m
[32m+[m[32m    ];[m
[32m+[m
[32m+[m[32m    public function media()[m
[32m+[m[32m    {[m
[32m+[m[32m        return $this->morphOne(Media::class, 'mediable');[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Notifications/EmailNotification.php b/app/Notifications/EmailNotification.php[m
[1mnew file mode 100644[m
[1mindex 0000000..07fc119[m
[1m--- /dev/null[m
[1m+++ b/app/Notifications/EmailNotification.php[m
[36m@@ -0,0 +1,61 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Notifications;[m
[32m+[m
[32m+[m[32muse Illuminate\Bus\Queueable;[m
[32m+[m[32muse Illuminate\Notifications\Notification;[m
[32m+[m[32muse Illuminate\Contracts\Queue\ShouldQueue;[m
[32m+[m[32muse Illuminate\Notifications\Messages\MailMessage;[m
[32m+[m
[32m+[m[32mclass EmailNotification extends Notification[m
[32m+[m[32m{[m
[32m+[m[32m    use Queueable;[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Create a new notification instance.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function __construct()[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Get the notification's delivery channels.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  mixed  $notifiable[m
[32m+[m[32m     * @return array[m
[32m+[m[32m     */[m
[32m+[m[32m    public function via($notifiable)[m
[32m+[m[32m    {[m
[32m+[m[32m        return ['mail'];[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Get the mail representation of the notification.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  mixed  $notifiable[m
[32m+[m[32m     * @return \Illuminate\Notifications\Messages\MailMessage[m
[32m+[m[32m     */[m
[32m+[m[32m    public function toMail($notifiable)[m
[32m+[m[32m    {[m
[32m+[m[32m        return (new MailMessage)[m
[32m+[m[32m                    ->line('The introduction to the notification.')[m
[32m+[m[32m                    ->action('Notification Action', url('/'))[m
[32m+[m[32m                    ->line('Thank you for using our application!');[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Get the array representation of the notification.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @param  mixed  $notifiable[m
[32m+[m[32m     * @return array[m
[32m+[m[32m     */[m
[32m+[m[32m    public function toArray($notifiable)[m
[32m+[m[32m    {[m
[32m+[m[32m        return [[m
[32m+[m[32m            //[m
[32m+[m[32m        ];[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Permissions/HasPermissionsTrait.php b/app/Permissions/HasPermissionsTrait.php[m
[1mnew file mode 100755[m
[1mindex 0000000..71a54f7[m
[1m--- /dev/null[m
[1m+++ b/app/Permissions/HasPermissionsTrait.php[m
[36m@@ -0,0 +1,136 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m
[32m+[m[32mnamespace App\Permissions;[m
[32m+[m
[32m+[m
[32m+[m[32muse App\Models\Permission;[m
[32m+[m[32muse App\Models\Role;[m
[32m+[m
[32m+[m[32mtrait HasPermissionsTrait[m
[32m+[m[32m{[m
[32m+[m
[32m+[m[32m    public function givePermissionsTo(... $permissions)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        $permissions = $this->getAllPermissions($permissions);[m
[32m+[m
[32m+[m[32m        if($permissions === null) {[m
[32m+[m
[32m+[m[32m            return $this;[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        $this->permissions()->saveMany($permissions);[m
[32m+[m
[32m+[m[32m        return $this;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    public function withdrawPermissionsTo( ... $permissions )[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        $permissions = $this->getAllPermissions($permissions);[m
[32m+[m
[32m+[m[32m        $this->permissions()->detach($permissions);[m
[32m+[m
[32m+[m[32m        return $this;[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    public function refreshPermissions( ... $permissions )[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        $this->permissions()->detach();[m
[32m+[m
[32m+[m[32m        return $this->givePermissionsTo($permissions);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    public function hasPermissionTo($permission)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return $this->hasPermissionThroughRole($permission) || $this->hasPermission($permission);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    public function hasPermissionThroughRole($permission)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        foreach ($permission->roles as $role) {[m
[32m+[m
[32m+[m[32m            if($this->roles->contains($role)) {[m
[32m+[m
[32m+[m[32m                return true;[m
[32m+[m
[32m+[m[32m            }[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        return false;[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    public function hasRole( ... $roles )[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        foreach ($roles as $role) {[m
[32m+[m
[32m+[m[32m            if ($this->roles->contains('slug', $role)) {[m
[32m+[m
[32m+[m[32m                return true;[m
[32m+[m
[32m+[m[32m            }[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        return false;[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public function roles()[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return $this->belongsToMany(Role::class,'users_roles');[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    public function permissions()[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return $this->belongsToMany(Permission::class,'users_permissions');[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    protected function hasPermission($permission)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return (bool) $this->permissions->where('slug', $permission->slug)->count();[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m    protected function getAllPermissions(array $permissions)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return Permission::whereIn('slug',$permissions)->get();[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    protected function getAllRoles(array $roles)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return Role::whereIn('slug',$roles)->get();[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m}[m
[1mdiff --git a/app/Providers/AppServiceProvider.php b/app/Providers/AppServiceProvider.php[m
[1mnew file mode 100755[m
[1mindex 0000000..ee8ca5b[m
[1m--- /dev/null[m
[1m+++ b/app/Providers/AppServiceProvider.php[m
[36m@@ -0,0 +1,28 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Providers;[m
[32m+[m
[32m+[m[32muse Illuminate\Support\ServiceProvider;[m
[32m+[m
[32m+[m[32mclass AppServiceProvider extends ServiceProvider[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Register any application services.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function register()[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Bootstrap any application services.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function boot()[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Providers/AuthServiceProvider.php b/app/Providers/AuthServiceProvider.php[m
[1mnew file mode 100755[m
[1mindex 0000000..0acc984[m
[1m--- /dev/null[m
[1m+++ b/app/Providers/AuthServiceProvider.php[m
[36m@@ -0,0 +1,30 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Providers;[m
[32m+[m
[32m+[m[32muse Illuminate\Support\Facades\Gate;[m
[32m+[m[32muse Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;[m
[32m+[m
[32m+[m[32mclass AuthServiceProvider extends ServiceProvider[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * The policy mappings for the application.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @var array[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $policies = [[m
[32m+[m[32m        // 'App\Model' => 'App\Policies\ModelPolicy',[m
[32m+[m[32m    ];[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Register any authentication / authorization services.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function boot()[m
[32m+[m[32m    {[m
[32m+[m[32m        $this->registerPolicies();[m
[32m+[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Providers/BroadcastServiceProvider.php b/app/Providers/BroadcastServiceProvider.php[m
[1mnew file mode 100755[m
[1mindex 0000000..352cce4[m
[1m--- /dev/null[m
[1m+++ b/app/Providers/BroadcastServiceProvider.php[m
[36m@@ -0,0 +1,21 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Providers;[m
[32m+[m
[32m+[m[32muse Illuminate\Support\ServiceProvider;[m
[32m+[m[32muse Illuminate\Support\Facades\Broadcast;[m
[32m+[m
[32m+[m[32mclass BroadcastServiceProvider extends ServiceProvider[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Bootstrap any application services.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function boot()[m
[32m+[m[32m    {[m
[32m+[m[32m        Broadcast::routes();[m
[32m+[m
[32m+[m[32m        require base_path('routes/channels.php');[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Providers/EventServiceProvider.php b/app/Providers/EventServiceProvider.php[m
[1mnew file mode 100755[m
[1mindex 0000000..6c64e52[m
[1m--- /dev/null[m
[1m+++ b/app/Providers/EventServiceProvider.php[m
[36m@@ -0,0 +1,34 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Providers;[m
[32m+[m
[32m+[m[32muse Illuminate\Support\Facades\Event;[m
[32m+[m[32muse Illuminate\Auth\Events\Registered;[m
[32m+[m[32muse Illuminate\Auth\Listeners\SendEmailVerificationNotification;[m
[32m+[m[32muse Illuminate\Foundation\Support\Providers\EventServiceProvider as ServiceProvider;[m
[32m+[m
[32m+[m[32mclass EventServiceProvider extends ServiceProvider[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * The event listener mappings for the application.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @var array[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $listen = [[m
[32m+[m[32m        Registered::class => [[m
[32m+[m[32m            SendEmailVerificationNotification::class,[m
[32m+[m[32m        ],[m
[32m+[m[32m    ];[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Register any events for your application.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function boot()[m
[32m+[m[32m    {[m
[32m+[m[32m        parent::boot();[m
[32m+[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Providers/PermissionsServiceProvider.php b/app/Providers/PermissionsServiceProvider.php[m
[1mnew file mode 100755[m
[1mindex 0000000..44974f8[m
[1m--- /dev/null[m
[1m+++ b/app/Providers/PermissionsServiceProvider.php[m
[36m@@ -0,0 +1,62 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Providers;[m
[32m+[m
[32m+[m[32muse App\Models\Permission;[m
[32m+[m[32muse Illuminate\Support\Facades\Blade;[m
[32m+[m[32muse Illuminate\Support\Facades\Gate;[m
[32m+[m[32muse Illuminate\Support\ServiceProvider;[m
[32m+[m
[32m+[m[32mclass PermissionsServiceProvider extends ServiceProvider[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Register services.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function register()[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Bootstrap services.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function boot()[m
[32m+[m[32m    {[m
[32m+[m[32m        try {[m
[32m+[m
[32m+[m[32m            Permission::get()->map(function ($permission) {[m
[32m+[m
[32m+[m[32m                Gate::define($permission->slug, function ($user) use ($permission) {[m
[32m+[m
[32m+[m[32m                    return $user->hasPermissionTo($permission);[m
[32m+[m
[32m+[m[32m                });[m
[32m+[m
[32m+[m[32m            });[m
[32m+[m
[32m+[m[32m        } catch (\Exception $e) {[m
[32m+[m
[32m+[m[32m            report($e);[m
[32m+[m
[32m+[m[32m            return false;[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        //Blade directives[m
[32m+[m[32m        Blade::directive('acl', function ($role) {[m
[32m+[m
[32m+[m[32m            return "if(auth()->check() && auth()->user()->hasRole({$role})) :"; //return this if statement inside php tag[m
[32m+[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m        Blade::directive('endacl', function ($role) {[m
[32m+[m
[32m+[m[32m            return "endif;"; //return this endif statement inside php tag[m
[32m+[m
[32m+[m[32m        });[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Providers/RouteServiceProvider.php b/app/Providers/RouteServiceProvider.php[m
[1mnew file mode 100755[m
[1mindex 0000000..5ea48d3[m
[1m--- /dev/null[m
[1m+++ b/app/Providers/RouteServiceProvider.php[m
[36m@@ -0,0 +1,73 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Providers;[m
[32m+[m
[32m+[m[32muse Illuminate\Support\Facades\Route;[m
[32m+[m[32muse Illuminate\Foundation\Support\Providers\RouteServiceProvider as ServiceProvider;[m
[32m+[m
[32m+[m[32mclass RouteServiceProvider extends ServiceProvider[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * This namespace is applied to your controller routes.[m
[32m+[m[32m     *[m
[32m+[m[32m     * In addition, it is set as the URL generator's root namespace.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @var string[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $namespace = 'App\Http\Controllers';[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Define your route model bindings, pattern filters, etc.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function boot()[m
[32m+[m[32m    {[m
[32m+[m[32m        //[m
[32m+[m
[32m+[m[32m        parent::boot();[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Define the routes for the application.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function map()[m
[32m+[m[32m    {[m
[32m+[m[32m        $this->mapApiRoutes();[m
[32m+[m
[32m+[m[32m        $this->mapWebRoutes();[m
[32m+[m
[32m+[m[32m        //[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Define the "web" routes for the application.[m
[32m+[m[32m     *[m
[32m+[m[32m     * These routes all receive session state, CSRF protection, etc.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    protected function mapWebRoutes()[m
[32m+[m[32m    {[m
[32m+[m[32m        Route::middleware('web')[m
[32m+[m[32m             ->namespace($this->namespace)[m
[32m+[m[32m             ->group(base_path('routes/web.php'));[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Define the "api" routes for the application.[m
[32m+[m[32m     *[m
[32m+[m[32m     * These routes are typically stateless.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    protected function mapApiRoutes()[m
[32m+[m[32m    {[m
[32m+[m[32m        Route::prefix('api')[m
[32m+[m[32m             ->middleware('api')[m
[32m+[m[32m             ->namespace($this->namespace)[m
[32m+[m[32m             ->group(base_path('routes/api.php'));[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Repositories/ArticleRepository.php b/app/Repositories/ArticleRepository.php[m
[1mnew file mode 100755[m
[1mindex 0000000..779f0fa[m
[1m--- /dev/null[m
[1m+++ b/app/Repositories/ArticleRepository.php[m
[36m@@ -0,0 +1,88 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Repositories;[m
[32m+[m
[32m+[m[32muse App\Helpers\Helper;[m
[32m+[m[32muse App\Models\Article;[m
[32m+[m[32muse Illuminate\Contracts\Pagination\LengthAwarePaginator;[m
[32m+[m
[32m+[m[32mclass ArticleRepository implements RepositoryInterface[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function all()[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return Article::with('media')->orderBy('en_title', 'ASC')->get();[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function get($id)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return Article::with('media')->find($id);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param array $data[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function create(array $data)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        $dataObj =  new Article;[m
[32m+[m[32m        $dataObj->id = $data['id'];[m
[32m+[m[32m        $dataObj->user_id = $data['user_id'];[m
[32m+[m[32m        $dataObj->category_id = $data['category_id'];[m
[32m+[m[32m        $dataObj->en_title = $data['en_title'];[m
[32m+[m[32m        $dataObj->bn_title = $data['bn_title'];[m
[32m+[m[32m        $dataObj->slug = Helper::slugify($data['en_title']);[m
[32m+[m[32m        $dataObj->en_short_summary = $data['en_short_summary'];[m
[32m+[m[32m        $dataObj->bn_short_summary = $data['bn_short_summary'];[m
[32m+[m[32m        $dataObj->en_body = $data['en_body'];[m
[32m+[m[32m        $dataObj->bn_body = $data['bn_body'];[m
[32m+[m[32m        $dataObj->status = $data['status'];[m
[32m+[m[32m        $dataObj->publish_date = $data['publish_date'];[m
[32m+[m
[32m+[m[32m        return $dataObj->save();[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param array $data[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function update(array $data, $id)[m
[32m+[m[32m    {[m
[32m+[m[32m        return Article::find($id)->update($data);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     */[m
[32m+[m[32m    public function delete($id)[m
[32m+[m[32m    {[m
[32m+[m[32m        return Article::find($id)->delete();[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return LengthAwarePaginator[m
[32m+[m[32m     */[m
[32m+[m[32m    public function getWithPagination()[m
[32m+[m[32m    {[m
[32m+[m[32m        return Article::with('media')->orderBy('en_title', 'ASC')->paginate(10);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m}[m
[1mdiff --git a/app/Repositories/CategoryRepository.php b/app/Repositories/CategoryRepository.php[m
[1mnew file mode 100644[m
[1mindex 0000000..1b3bcf9[m
[1m--- /dev/null[m
[1m+++ b/app/Repositories/CategoryRepository.php[m
[36m@@ -0,0 +1,111 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Repositories;[m
[32m+[m
[32m+[m
[32m+[m[32muse App\Helpers\Helper;[m
[32m+[m[32muse App\Models\Category;[m
[32m+[m
[32m+[m[32mclass CategoryRepository implements RepositoryInterface[m
[32m+[m[32m{[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function all()[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return Category::with('childrenRecursive')->where('parent_id', '=', 0)->orderBy('name', 'ASC')->get();[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function get($id)[m
[32m+[m[32m    {[m
[32m+[m[32m        return Category::find($id);[m
[32m+[m
[32m+[m[32m        //return Category::with(['permissions' => function($q) {$q->select('id', 'name');}])->find($id);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param array $data[m
[32m+[m[32m     * @return bool[m
[32m+[m[32m     */[m
[32m+[m[32m    public function create(array $data)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        $dataObj =  new Category;[m
[32m+[m
[32m+[m[32m        $dataObj->id = $data['id'];[m
[32m+[m[32m        $dataObj->name = $data['name'];[m
[32m+[m[32m        $dataObj->slug = Helper::slugify($data['name']);[m
[32m+[m[32m        $dataObj->parent_id = $data['parent_id'];[m
[32m+[m
[32m+[m[32m        return $dataObj->save();[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param array $data[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function update(array $data, $id)[m
[32m+[m[32m    {[m
[32m+[m[32m        return Category::find($id)->update($data);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     */[m
[32m+[m[32m    public function delete($id)[m
[32m+[m[32m    {[m
[32m+[m[32m        self::deleteSubcategory($id);[m
[32m+[m
[32m+[m[32m        $selectedCategory = Category::where('id', $id)->get();[m
[32m+[m[32m        $child = Category::where('parent_id', $id)->get();[m
[32m+[m
[32m+[m[32m        if(count($selectedCategory) == 0):[m
[32m+[m
[32m+[m[32m            echo json_encode ($this->error("Category Not Found!", "400"));[m
[32m+[m
[32m+[m[32m        elseif(count($child) == 0 ):[m
[32m+[m[32m            echo json_encode($this->success("No Child!! Deleted..",'', 200));[m
[32m+[m[32m            return Category::find($id)->delete();[m
[32m+[m[32m        else:[m
[32m+[m[32m            echo json_encode($this->error(count($child)." subcategories Found!! You cann't delete this", 400));[m
[32m+[m
[32m+[m[32m        endif;[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m    public function deleteSubcategory($category_id){[m
[32m+[m[32m       $request = Category::where('parent_id', '=', $category_id)->pluck('id');[m
[32m+[m[32m       //print_r($request);[m
[32m+[m[32m       //echo count($request);[m
[32m+[m[32m       foreach ($request as $cat){[m
[32m+[m[32m           //echo 444;[m
[32m+[m[32m           echo('Id :'.$cat.',  ');[m
[32m+[m
[32m+[m[32m           self::deleteSubcategory($cat);[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m[32m        //echo 'hi';[m
[32m+[m[32m        echo Category::where('id', '=', $category_id)->delete();[m
[32m+[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m[32m    /*[m
[32m+[m[32m    public function getWithPagination()[m
[32m+[m[32m    {[m
[32m+[m[32m        return Category::orderBy('id', 'DESC')->paginate(10);[m
[32m+[m[32m    }[m
[32m+[m[32m    */[m
[32m+[m[32m}[m
[1mdiff --git a/app/Repositories/PermissionRepository.php b/app/Repositories/PermissionRepository.php[m
[1mnew file mode 100755[m
[1mindex 0000000..8ef2051[m
[1m--- /dev/null[m
[1m+++ b/app/Repositories/PermissionRepository.php[m
[36m@@ -0,0 +1,61 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m
[32m+[m[32mnamespace App\Repositories;[m
[32m+[m
[32m+[m
[32m+[m[32muse App\Models\Permission;[m
[32m+[m
[32m+[m[32mclass PermissionRepository implements RepositoryInterface[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function all()[m
[32m+[m[32m    {[m
[32m+[m[32m        return Permission::orderBy('id', 'DESC')->get();[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function get($id)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return Permission::findOrFail($id);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param array $data[m
[32m+[m[32m     * @return \Illuminate\Database\Eloquent\Builder|\Illuminate\Database\Eloquent\Model[m
[32m+[m[32m     */[m
[32m+[m[32m    public function create(array $data)[m
[32m+[m[32m    {[m
[32m+[m[32m        return Permission::create($data);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param array $data[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function update(array $data, $id)[m
[32m+[m[32m    {[m
[32m+[m[32m        return Permission::find($id)->update($data);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     */[m
[32m+[m[32m    public function delete($id)[m
[32m+[m[32m    {[m
[32m+[m[32m        return Permission::find($id)->delete();[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public function getWithPagination()[m
[32m+[m[32m    {[m
[32m+[m[32m        return Permission::orderBy('id', 'DESC')->paginate(10);[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Repositories/RepositoryInterface.php b/app/Repositories/RepositoryInterface.php[m
[1mnew file mode 100755[m
[1mindex 0000000..2d9f9b5[m
[1m--- /dev/null[m
[1m+++ b/app/Repositories/RepositoryInterface.php[m
[36m@@ -0,0 +1,18 @@[m
[32m+[m[32m<?php[m[41m [m
[32m+[m
[32m+[m[32mnamespace App\Repositories;[m
[32m+[m
[32m+[m[32minterface RepositoryInterface[m
[32m+[m[32m{[m
[32m+[m
[32m+[m[32m  public function all();[m
[32m+[m
[32m+[m[32m  public function get($id);[m
[32m+[m
[32m+[m[32m  public function create(array $data);[m
[32m+[m
[32m+[m[32m  public function update(array $data, $id);[m
[32m+[m
[32m+[m[32m  public function delete($id);[m
[32m+[m
[32m+[m[32m}[m
\ No newline at end of file[m
[1mdiff --git a/app/Repositories/RoleRepository.php b/app/Repositories/RoleRepository.php[m
[1mnew file mode 100755[m
[1mindex 0000000..84c359a[m
[1m--- /dev/null[m
[1m+++ b/app/Repositories/RoleRepository.php[m
[36m@@ -0,0 +1,62 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m
[32m+[m[32mnamespace App\Repositories;[m
[32m+[m
[32m+[m
[32m+[m[32muse App\Models\Role;[m
[32m+[m
[32m+[m[32mclass RoleRepository implements RepositoryInterface[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function all()[m
[32m+[m[32m    {[m
[32m+[m[32m        return Role::orderBy('id', 'DESC')->get();[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function get($id)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return Role::with(['permissions' => function($q) {$q->select('id', 'name');}])->findOrFail($id);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param array $data[m
[32m+[m[32m     * @return \Illuminate\Database\Eloquent\Builder|\Illuminate\Database\Eloquent\Model[m
[32m+[m[32m     */[m
[32m+[m[32m    public function create(array $data)[m
[32m+[m[32m    {[m
[32m+[m[32m        return Role::create($data);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param array $data[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function update(array $data, $id)[m
[32m+[m[32m    {[m
[32m+[m[32m        return Role::find($id)->update($data);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     */[m
[32m+[m[32m    public function delete($id)[m
[32m+[m[32m    {[m
[32m+[m[32m        return Role::find($id)->delete();[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    public function getWithPagination()[m
[32m+[m[32m    {[m
[32m+[m[32m        return Role::orderBy('id', 'DESC')->paginate(10);[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Repositories/UserRepository.php b/app/Repositories/UserRepository.php[m
[1mnew file mode 100755[m
[1mindex 0000000..a38a406[m
[1m--- /dev/null[m
[1m+++ b/app/Repositories/UserRepository.php[m
[36m@@ -0,0 +1,86 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Repositories;[m
[32m+[m
[32m+[m[32muse App\Helpers\Helper;[m
[32m+[m[32muse App\Models\User;[m
[32m+[m
[32m+[m[32mclass UserRepository implements RepositoryInterface[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function all()[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return User::with(['roles' => function($q) {$q->select('id', 'name');}, 'media'])->orderBy('created_at', 'DESC')->get();[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function get($id)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return User::with(['roles' => function($q) {$q->select('id', 'name');}, 'media'])->findOrFail($id);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    public function getUser($id)[m
[32m+[m[32m    {[m
[32m+[m[32m        return User::findOrFail($id);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param array $data[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function create(array $data)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        $dataObj =  new User;[m
[32m+[m[32m        $dataObj->id = $data['id'];[m
[32m+[m[32m        $dataObj->username = $data['username'];[m
[32m+[m[32m        $dataObj->first_name = $data['first_name'];[m
[32m+[m[32m        $dataObj->last_name = $data['last_name'];[m
[32m+[m[32m        $dataObj->slug = Helper::slugify($data['first_name'].$data['last_name']) ;[m
[32m+[m[32m        $dataObj->email = $data['email'];[m
[32m+[m[32m        $dataObj->password = $data['password'];[m
[32m+[m
[32m+[m[32m        return $dataObj->save();[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param array $data[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function update(array $data, $id)[m
[32m+[m[32m    {[m
[32m+[m[32m        return User::find($id)->update($data);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     */[m
[32m+[m[32m    public function delete($id)[m
[32m+[m[32m    {[m
[32m+[m[32m        return User::find($id)->delete();[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return \Illuminate\Contracts\Pagination\LengthAwarePaginator[m
[32m+[m[32m     */[m
[32m+[m[32m    public function getWithPagination()[m
[32m+[m[32m    {[m
[32m+[m[32m        return User::with(['roles' => function($q) {$q->select('id', 'name');}, 'media'])->orderBy('created_at', 'DESC')->paginate(10);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m}[m
[1mdiff --git a/app/Services/ArticleService.php b/app/Services/ArticleService.php[m
[1mnew file mode 100644[m
[1mindex 0000000..bab0c5d[m
[1m--- /dev/null[m
[1m+++ b/app/Services/ArticleService.php[m
[36m@@ -0,0 +1,132 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m
[32m+[m[32mnamespace App\Services;[m
[32m+[m
[32m+[m
[32m+[m[32muse App\Helpers\Helper;[m
[32m+[m[32muse App\Repositories\ArticleRepository;[m
[32m+[m[32muse Illuminate\Http\JsonResponse;[m
[32m+[m[32muse Illuminate\Http\Request;[m
[32m+[m[32muse Exception;[m
[32m+[m[32muse Illuminate\Support\Facades\DB;[m
[32m+[m[32muse Illuminate\Support\Facades\Log;[m
[32m+[m[32muse Illuminate\Support\Facades\Validator;[m
[32m+[m
[32m+[m[32mclass ArticleService[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @var ArticleRepository[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $articleRepository;[m
[32m+[m
[32m+[m[32m    public function __construct(ArticleRepository $articleRepository)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        $this->articleRepository = $articleRepository;[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function getAll()[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200'), 'article_list'=>$this->articleRepository->all()]);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function paginateData()[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200'), 'article_list'=>$this->articleRepository->getWithPagination()]);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param Request $request[m
[32m+[m[32m     * @return JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function createItem(Request $request)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        $thumbFile = [];[m
[32m+[m
[32m+[m[32m        $validator = Validator::make($request->all(),[[m
[32m+[m
[32m+[m[32m            'en_title' => 'required|string',[m
[32m+[m
[32m+[m
[32m+[m[32m        ]);[m
[32m+[m
[32m+[m[32m        if($validator->fails()) {[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => '400', 'messages'=>config('status.status_code.400'), 'error' =>  $validator->errors()->first()]);[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        if(isset($request->image_file)) {[m
[32m+[m
[32m+[m[32m            $thumbImageList = $request->image_file;[m
[32m+[m[32m            $countImage = count($thumbImageList);[m
[32m+[m
[32m+[m[32m            for ($i = 1; $i <= $countImage; $i++) {[m
[32m+[m
[32m+[m[32m                if($countImage > 0) {[m
[32m+[m
[32m+[m[32m                    $thumbFile[] = Helper::base64ImageUpload("article/images", $thumbImageList[$countImage-1]);[m
[32m+[m
[32m+[m[32m                }[m
[32m+[m
[32m+[m[32m            }[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        $input = $request->all();[m
[32m+[m[32m        $input['id'] = time().rand(1000,9000);[m
[32m+[m
[32m+[m
[32m+[m[32m        DB::beginTransaction();[m
[32m+[m
[32m+[m[32m        try {[m
[32m+[m
[32m+[m[32m            $this->articleRepository->create($input);[m
[32m+[m[32m            $article = $this->getItemById($input['id']);[m
[32m+[m
[32m+[m[32m            foreach ($thumbFile as $image):[m
[32m+[m
[32m+[m[32m                $article->media()->create([[m
[32m+[m
[32m+[m[32m                    'url' => $image[m
[32m+[m
[32m+[m[32m                ]);[m
[32m+[m
[32m+[m[32m            endforeach;[m
[32m+[m
[32m+[m[32m        } catch (Exception $e) {[m
[32m+[m
[32m+[m[32m            DB::rollBack();[m
[32m+[m[32m            Log::info($e->getMessage());[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => '424', 'messages'=>config('status.status_code.424'), 'error' => $e->getMessage()]);[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        DB::commit();[m
[32m+[m
[32m+[m[32m        return response()->json(['status_code' => 201, 'messages'=>config('status.status_code.201')]);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    public function getItemById($id)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return $this->articleRepository->get($id);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m}[m
[1mdiff --git a/app/Services/CategoryService.php b/app/Services/CategoryService.php[m
[1mnew file mode 100644[m
[1mindex 0000000..7032ddd[m
[1m--- /dev/null[m
[1m+++ b/app/Services/CategoryService.php[m
[36m@@ -0,0 +1,189 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m
[32m+[m[32mnamespace App\Services;[m
[32m+[m
[32m+[m
[32m+[m[32muse App\Repositories\CategoryRepository;[m
[32m+[m[32muse Exception;[m
[32m+[m[32muse Illuminate\Support\Facades\DB;[m
[32m+[m[32muse Illuminate\Support\Facades\Log;[m
[32m+[m[32muse Illuminate\Support\Facades\Validator;[m
[32m+[m
[32m+[m[32mclass CategoryService[m
[32m+[m[32m{[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @var CategoryRepository[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $categoryRepository;[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * CategoryService constructor.[m
[32m+[m[32m     * @param CategoryRepository $categoryRepository[m
[32m+[m[32m     */[m
[32m+[m[32m    public function __construct(CategoryRepository $categoryRepository)[m
[32m+[m[32m    {[m
[32m+[m[32m        $this->categoryRepository = $categoryRepository;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return \Illuminate\Http\JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function getAll()[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200'), 'category_list'=>$this->categoryRepository->all()]);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     * @return \Illuminate\Http\JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function getById($id)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        if($this->categoryRepository->get($id))[m
[32m+[m[32m            return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200'), 'category_info'=>$this->categoryRepository->get($id)]);[m
[32m+[m
[32m+[m[32m        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200'), 'category_info'=>"Data not found"]);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $request[m
[32m+[m[32m     * @return \Illuminate\Http\JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function createItem($request)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        $validator = Validator::make($request->all(),[[m
[32m+[m
[32m+[m[32m            'name' => 'required',[m
[32m+[m[32m            'parent_id' => 'required',[m
[32m+[m
[32m+[m
[32m+[m[32m        ]);[m
[32m+[m
[32m+[m[32m        if($validator->fails()) {[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => '400', 'messages'=>config('status.status_code.400'), 'error' =>  $validator->errors()->first()]);[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        $input = $request->all();[m
[32m+[m[32m        $input['id'] = time().rand(1000,9000);[m
[32m+[m
[32m+[m
[32m+[m[32m        DB::beginTransaction();[m
[32m+[m
[32m+[m[32m        try {[m
[32m+[m
[32m+[m
[32m+[m[32m            $this->categoryRepository->create($input);[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m        } catch (Exception $e) {[m
[32m+[m
[32m+[m[32m            DB::rollBack();[m
[32m+[m[32m            Log::info($e->getMessage());[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => '424', 'messages'=>config('status.status_code.424'), 'error' => $e->getMessage()]);[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        DB::commit();[m
[32m+[m
[32m+[m[32m        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200')]);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $request[m
[32m+[m[32m     * @return \Illuminate\Http\JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function updateItem($request)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        $validator = Validator::make($request->all(),[[m
[32m+[m
[32m+[m[32m            'name' => 'required',[m
[32m+[m[32m            'parent_id' => 'required',[m
[32m+[m
[32m+[m[32m        ]);[m
[32m+[m
[32m+[m[32m        if($validator->fails()) {[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => '400', 'messages'=>config('status.status_code.400'), 'error' =>  $validator->errors()->first()]);[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        DB::beginTransaction();[m
[32m+[m
[32m+[m[32m        try {[m
[32m+[m
[32m+[m[32m            $this->categoryRepository->update(['name' => $request->input('title'),[m
[32m+[m[32m                                                'parent_id' => $request->input('parent_id') ], $request->id);[m
[32m+[m[32m            $category = $this->categoryRepository->get($request->id);[m
[32m+[m[32m            // $category->syncPermissions($request->input('permission'));[m
[32m+[m
[32m+[m[32m        } catch (Exception $e) {[m
[32m+[m
[32m+[m[32m            DB::rollBack();[m
[32m+[m[32m            Log::info($e->getMessage());[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => '424', 'messages'=>config('status.status_code.424'), 'error' => $e->getMessage()]);[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        DB::commit();[m
[32m+[m
[32m+[m[32m        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200')]);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     * @return \Illuminate\Http\JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function deleteItem($id)[m
[32m+[m[32m    {[m
[32m+[m[32m        DB::beginTransaction();[m
[32m+[m
[32m+[m[32m        try {[m
[32m+[m
[32m+[m[32m            $this->categoryRepository->delete($id);[m
[32m+[m
[32m+[m[32m        } catch (\Exception $e) {[m
[32m+[m
[32m+[m[32m            DB::rollBack();[m
[32m+[m
[32m+[m[32m            Log::info($e->getMessage());[m
[32m+[m[32m            //return $this->error($e->getMessage(), $e->getCode());[m
[32m+[m[32m            return response()->json(['status_code' => '424', 'messages'=>config('status.status_code.424'), 'error' => $e->getMessage()]);[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        DB::commit();[m
[32m+[m
[32m+[m[32m        //return $this->success(config('status.status_code.200'), "Category Deleted" );[m
[32m+[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return \Illuminate\Http\JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function paginateData()[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200'), 'category_list'=>$this->categoryRepository->getWithPagination()]);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m}[m
[1mdiff --git a/app/Services/PermissionService.php b/app/Services/PermissionService.php[m
[1mnew file mode 100755[m
[1mindex 0000000..7d81fae[m
[1m--- /dev/null[m
[1m+++ b/app/Services/PermissionService.php[m
[36m@@ -0,0 +1,164 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m
[32m+[m[32mnamespace App\Services;[m
[32m+[m
[32m+[m
[32m+[m[32muse App\Helpers\Helper;[m
[32m+[m[32muse App\Repositories\PermissionRepository;[m
[32m+[m[32muse Illuminate\Support\Facades\Validator;[m
[32m+[m[32muse Illuminate\Support\Facades\DB;[m
[32m+[m[32muse Illuminate\Support\Facades\Log;[m
[32m+[m[32muse Exception;[m
[32m+[m
[32m+[m[32mclass PermissionService[m
[32m+[m[32m{[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @var PermissionRepository[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $permissionRepository;[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * PermissionService constructor.[m
[32m+[m[32m     * @param PermissionRepository $permissionRepository[m
[32m+[m[32m     */[m
[32m+[m[32m    public function __construct(PermissionRepository $permissionRepository)[m
[32m+[m[32m    {[m
[32m+[m[32m        $this->permissionRepository = $permissionRepository;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return \Illuminate\Http\JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function getAll()[m
[32m+[m[32m    {[m
[32m+[m[32m        return response()->json(['status_code' => 302, 'messages'=>config('status.status_code.302'), 'permission_list'=>$this->permissionRepository->all()]);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     * @return \Illuminate\Http\JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function getById($id)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        if($this->permissionRepository->get($id))[m
[32m+[m[32m            return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200'), 'permission_info'=>$this->permissionRepository->get($id)]);[m
[32m+[m
[32m+[m[32m        return response()->json(['status_code' => 302, 'messages'=>config('status.status_code.302'), 'permission_info'=>"Data not found"]);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $request[m
[32m+[m[32m     * @return \Illuminate\Http\JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function createItem($request)[m
[32m+[m[32m    {[m
[32m+[m[32m        $validator = Validator::make($request->all(),[[m
[32m+[m
[32m+[m[32m            'name' => 'required|unique:permissions,name',[m
[32m+[m
[32m+[m[32m        ]);[m
[32m+[m
[32m+[m[32m        if($validator->fails()) {[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => '400', 'messages'=>config('status.status_code.400'), 'error' =>  $validator->errors()->first()]);[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        $input = $request->all();[m
[32m+[m[32m        $input['slug'] = Helper::slugify($input['name']);[m
[32m+[m
[32m+[m[32m        $this->permissionRepository->create($input);[m
[32m+[m
[32m+[m[32m        return response()->json(['status_code' => 201, 'messages'=>config('status.status_code.201')]);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $request[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     * @return \Illuminate\Http\JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function updateItem($request)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        $validator = Validator::make($request->all(),[[m
[32m+[m
[32m+[m[32m            'name' => 'required',[m
[32m+[m
[32m+[m[32m        ]);[m
[32m+[m
[32m+[m[32m        if($validator->fails()) {[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => '400', 'messages'=>config('status.status_code.400'), 'error' =>  $validator->errors()->first()]);[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        DB::beginTransaction();[m
[32m+[m
[32m+[m[32m        try {[m
[32m+[m
[32m+[m[32m            $input = $request->all();[m
[32m+[m[32m            $input['slug'] = Helper::slugify($input['name']);[m
[32m+[m
[32m+[m[32m            $this->permissionRepository->update($input, $request->id);[m
[32m+[m
[32m+[m[32m        } catch (Exception $e) {[m
[32m+[m
[32m+[m[32m            DB::rollBack();[m
[32m+[m[32m            Log::info($e->getMessage());[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => '424', 'messages'=>config('status.status_code.424'), 'error' => $e->getMessage()]);[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        DB::commit();[m
[32m+[m
[32m+[m[32m        return response()->json(['status_code' => 201, 'messages'=>config('status.status_code.201')]);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     * @return \Illuminate\Http\JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function deleteItem($id)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        DB::beginTransaction();[m
[32m+[m
[32m+[m[32m        try {[m
[32m+[m
[32m+[m[32m            $this->permissionRepository->delete($id);[m
[32m+[m
[32m+[m[32m        } catch (Exception $e) {[m
[32m+[m
[32m+[m[32m            DB::rollBack();[m
[32m+[m
[32m+[m[32m            Log::info($e->getMessage());[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => '424', 'messages'=>config('status.status_code.424'), 'error' => $e->getMessage()]);[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        DB::commit();[m
[32m+[m
[32m+[m[32m        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200')]);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return \Illuminate\Http\JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function paginateData()[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200'), 'user_list'=>$this->permissionRepository->getWithPagination()]);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/app/Services/RoleService.php b/app/Services/RoleService.php[m
[1mnew file mode 100755[m
[1mindex 0000000..6e54df6[m
[1m--- /dev/null[m
[1m+++ b/app/Services/RoleService.php[m
[36m@@ -0,0 +1,183 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m
[32m+[m[32mnamespace App\Services;[m
[32m+[m
[32m+[m
[32m+[m[32muse App\Helpers\Helper;[m
[32m+[m[32muse App\Repositories\RoleRepository;[m
[32m+[m[32muse Exception;[m
[32m+[m[32muse Illuminate\Support\Facades\DB;[m
[32m+[m[32muse Illuminate\Support\Facades\Log;[m
[32m+[m[32muse Illuminate\Support\Facades\Validator;[m
[32m+[m
[32m+[m
[32m+[m[32mclass RoleService[m
[32m+[m[32m{[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @var RoleRepository[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $roleRepository;[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * RoleService constructor.[m
[32m+[m[32m     * @param RoleRepository $roleRepository[m
[32m+[m[32m     */[m
[32m+[m[32m    public function __construct(RoleRepository $roleRepository)[m
[32m+[m[32m    {[m
[32m+[m[32m        $this->roleRepository = $roleRepository;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return \Illuminate\Http\JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function getAll()[m
[32m+[m[32m    {[m
[32m+[m[32m        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200'), 'role_list'=>$this->roleRepository->all()]);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     * @return \Illuminate\Http\JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function getById($id)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        if($this->roleRepository->get($id))[m
[32m+[m[32m            return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200'), 'role_info'=>$this->roleRepository->get($id)]);[m
[32m+[m
[32m+[m[32m        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200'), 'role_info'=>"Data not found"]);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $request[m
[32m+[m[32m     * @return \Illuminate\Http\JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function createItem($request)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        $validator = Validator::make($request->all(),[[m
[32m+[m
[32m+[m[32m            'name' => 'required|unique:roles,name',[m
[32m+[m[32m            'permission' => 'required',[m
[32m+[m
[32m+[m[32m        ]);[m
[32m+[m
[32m+[m[32m        if($validator->fails()) {[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => '400', 'messages'=>config('status.status_code.400'), 'error' =>  $validator->errors()->first()]);[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        DB::beginTransaction();[m
[32m+[m
[32m+[m[32m        try {[m
[32m+[m
[32m+[m[32m            $role = $this->roleRepository->create(['name' => $request->input('name'), 'slug' => Helper::slugify($request->input('name'))]);[m
[32m+[m
[32m+[m[32m            $role->permissions()->attach($request->input('permission'));[m
[32m+[m
[32m+[m[32m        } catch (Exception $e) {[m
[32m+[m
[32m+[m[32m            DB::rollBack();[m
[32m+[m[32m            Log::info($e->getMessage());[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => '424', 'messages'=>config('status.status_code.424'), 'error' => $e->getMessage()]);[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        DB::commit();[m
[32m+[m
[32m+[m[32m        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200')]);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $request[m
[32m+[m[32m     * @return \Illuminate\Http\JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function updateItem($request)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        $validator = Validator::make($request->all(),[[m
[32m+[m
[32m+[m[32m            'name' => 'required',[m
[32m+[m[32m            'permission' => 'required',[m
[32m+[m
[32m+[m[32m        ]);[m
[32m+[m
[32m+[m[32m        if($validator->fails()) {[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => '400', 'messages'=>config('status.status_code.400'), 'error' =>  $validator->errors()->first()]);[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        DB::beginTransaction();[m
[32m+[m
[32m+[m[32m        try {[m
[32m+[m
[32m+[m[32m            $this->roleRepository->update(['name' => $request->input('name'), 'slug' => Helper::slugify($request->input('name'))], $request->id);[m
[32m+[m[32m            $role = $this->roleRepository->get($request->id);[m
[32m+[m[32m            DB::table('roles_permissions')->where('role_id', $request->id)->delete();[m
[32m+[m[32m            $role->permissions()->attach($request->input('permission'));[m
[32m+[m
[32m+[m[32m        } catch (Exception $e) {[m
[32m+[m
[32m+[m[32m            DB::rollBack();[m
[32m+[m[32m            Log::info($e->getMessage());[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => '424', 'messages'=>config('status.status_code.424'), 'error' => $e->getMessage()]);[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        DB::commit();[m
[32m+[m
[32m+[m[32m        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200')]);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     * @return \Illuminate\Http\JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function deleteItem($id)[m
[32m+[m[32m    {[m
[32m+[m[32m        DB::beginTransaction();[m
[32m+[m
[32m+[m[32m        try {[m
[32m+[m
[32m+[m[32m            $this->roleRepository->delete($id);[m
[32m+[m
[32m+[m[32m        } catch (Exception $e) {[m
[32m+[m
[32m+[m[32m            DB::rollBack();[m
[32m+[m
[32m+[m[32m            Log::info($e->getMessage());[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => '424', 'messages'=>config('status.status_code.424'), 'error' => $e->getMessage()]);[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        DB::commit();[m
[32m+[m
[32m+[m[32m        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200')]);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return \Illuminate\Http\JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function paginateData()[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200'), 'role_list'=>$this->roleRepository->getWithPagination()]);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m}[m
[1mdiff --git a/app/Services/UserService.php b/app/Services/UserService.php[m
[1mnew file mode 100755[m
[1mindex 0000000..87a5cac[m
[1m--- /dev/null[m
[1m+++ b/app/Services/UserService.php[m
[36m@@ -0,0 +1,240 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace App\Services;[m
[32m+[m
[32m+[m[32muse App\Helpers\Helper;[m
[32m+[m[32muse App\Repositories\UserRepository;[m
[32m+[m[32muse Exception;[m
[32m+[m[32muse Illuminate\Support\Arr;[m
[32m+[m[32muse Illuminate\Support\Facades\DB;[m
[32m+[m[32muse Illuminate\Support\Facades\Log;[m
[32m+[m[32muse Illuminate\Support\Facades\Hash;[m
[32m+[m[32muse Illuminate\Support\Facades\Validator;[m
[32m+[m
[32m+[m
[32m+[m[32mclass UserService[m
[32m+[m[32m{[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @var UserRepository[m
[32m+[m[32m     */[m
[32m+[m[32m    protected $userRepository;[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * UserService constructor.[m
[32m+[m[32m     * @param UserRepository $userRepository[m
[32m+[m[32m     */[m
[32m+[m[32m    public function __construct(UserRepository $userRepository)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        $this->userRepository = $userRepository;[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return \Illuminate\Http\JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function getAll()[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200'), 'user_list'=>$this->userRepository->all()]);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     * @return \Illuminate\Http\JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function getById($id)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        if($this->userRepository->get($id))[m
[32m+[m[32m            return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200'), 'user_info'=>$this->userRepository->get($id)]);[m
[32m+[m
[32m+[m[32m        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200'), 'user_info'=>"Data not found"]);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $request[m
[32m+[m[32m     * @return \Illuminate\Http\JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function createItem($request)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        $validator = Validator::make($request->all(),[[m
[32m+[m
[32m+[m[32m            'first_name' => 'required|string|max:100',[m
[32m+[m[32m            'last_name' => 'required|string|max:100',[m
[32m+[m[32m            'username' => 'required|string|max:50|unique:users',[m
[32m+[m[32m            'email' => 'required|string|email|max:60|unique:users',[m
[32m+[m[32m            'password' => 'required|same:confirm-password',[m
[32m+[m[32m            'roles' => 'required'[m
[32m+[m
[32m+[m[32m        ]);[m
[32m+[m
[32m+[m[32m        if($validator->fails()) {[m
[32m+[m
[32m+[m[32m           return response()->json(['status_code' => '400', 'messages'=>config('status.status_code.400'), 'error' =>  $validator->errors()->first()]);[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        if(isset($request->image_file)) {[m
[32m+[m
[32m+[m[32m            $thumbFile = Helper::base64ProfileImageThumbUpload("avatar", $request->image_file);[m
[32m+[m
[32m+[m[32m        } else {[m
[32m+[m
[32m+[m[32m            $thumbFile = url('/').'/media/avatar/placeholder.png';[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m
[32m+[m[32m        $input = $request->all();[m
[32m+[m[32m        $input['id'] = time().rand(1000,9000);[m
[32m+[m[32m        $input['password'] = Hash::make($request->password);[m
[32m+[m
[32m+[m[32m        DB::beginTransaction();[m
[32m+[m
[32m+[m[32m        try {[m
[32m+[m
[32m+[m[32m            $this->userRepository->create($input);[m
[32m+[m[32m            $user = $this->getItemById($input['id']);[m
[32m+[m
[32m+[m[32m            $user->roles()->attach($request->input('roles'));[m
[32m+[m
[32m+[m[32m            $user->media()->create([[m
[32m+[m
[32m+[m[32m                'url' => $thumbFile[m
[32m+[m
[32m+[m[32m            ]);[m
[32m+[m
[32m+[m[32m        } catch (Exception $e) {[m
[32m+[m
[32m+[m[32m            DB::rollBack();[m
[32m+[m[32m            Log::info($e->getMessage());[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => 424, 'messages'=>config('status.status_code.424'), 'error' => $e->getMessage()]);[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        DB::commit();[m
[32m+[m
[32m+[m[32m        return response()->json(['status_code' => 201, 'messages'=>config('status.status_code.201')]);[m
[32m+[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $request[m
[32m+[m[32m     * @return \Illuminate\Http\JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function updateItem($request)[m
[32m+[m[32m    {[m
[32m+[m[32m        $validator = Validator::make($request->all(),[[m
[32m+[m
[32m+[m[32m            'first_name' => 'required|string|max:60',[m
[32m+[m[32m            'last_name' => 'required|string|max:60',[m
[32m+[m[32m            'username' => 'required|string|max:50',[m
[32m+[m[32m            'email' => 'required|string|email|max:60',[m
[32m+[m[32m            'roles' => 'required'[m
[32m+[m
[32m+[m[32m        ]);[m
[32m+[m
[32m+[m[32m        if($validator->fails()) {[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => 400, 'messages'=>config('status.status_code.400'), 'error' =>  $validator->errors()->first()]);[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m
[32m+[m[32m        $input = $request->all();[m
[32m+[m[32m        if(!empty($input['password'])) {[m
[32m+[m
[32m+[m[32m            $input['password'] = Hash::make($input['password']);[m
[32m+[m
[32m+[m[32m        } else {[m
[32m+[m
[32m+[m[32m            $input = Arr::except($input,array('password'));[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        DB::beginTransaction();[m
[32m+[m
[32m+[m[32m        try {[m
[32m+[m
[32m+[m[32m            $this->userRepository->update($input, $input['id']);[m
[32m+[m[32m            $user = $this->getItemById($input['id']);[m
[32m+[m
[32m+[m[32m            DB::table('users_roles')->where('user_id', $input['id'])->delete();[m
[32m+[m[32m            DB::table('users_permissions')->where('user_id', $input['id'])->delete();[m
[32m+[m
[32m+[m[32m            $user->roles()->attach($request->input('roles'));[m
[32m+[m
[32m+[m
[32m+[m[32m        } catch (Exception $e) {[m
[32m+[m
[32m+[m[32m            DB::rollBack();[m
[32m+[m[32m            Log::info($e->getMessage());[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => 424, 'messages'=>config('status.status_code.424'), 'error' => $e->getMessage()]);[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        DB::commit();[m
[32m+[m
[32m+[m[32m        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200')]);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     * @return \Illuminate\Http\JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function deleteItem($id)[m
[32m+[m[32m    {[m
[32m+[m[32m        DB::beginTransaction();[m
[32m+[m
[32m+[m[32m        try {[m
[32m+[m
[32m+[m[32m            $this->userRepository->delete($id);[m
[32m+[m
[32m+[m[32m        } catch (Exception $e) {[m
[32m+[m
[32m+[m[32m            DB::rollBack();[m
[32m+[m
[32m+[m[32m            Log::info($e->getMessage());[m
[32m+[m
[32m+[m[32m            return response()->json(['status_code' => 424, 'messages'=>config('status.status_code.424'), 'error' => $e->getMessage()]);[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        DB::commit();[m
[32m+[m
[32m+[m[32m        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200')]);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @return \Illuminate\Http\JsonResponse[m
[32m+[m[32m     */[m
[32m+[m[32m    public function paginateData()[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200'), 'user_list'=>$this->userRepository->getWithPagination()]);[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * @param $id[m
[32m+[m[32m     * @return mixed[m
[32m+[m[32m     */[m
[32m+[m[32m    public function getItemById($id)[m
[32m+[m[32m    {[m
[32m+[m
[32m+[m[32m        return $this->userRepository->getUser($id);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m}[m
[1mdiff --git a/artisan b/artisan[m
[1mnew file mode 100755[m
[1mindex 0000000..5c23e2e[m
[1m--- /dev/null[m
[1m+++ b/artisan[m
[36m@@ -0,0 +1,53 @@[m
[32m+[m[32m#!/usr/bin/env php[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mdefine('LARAVEL_START', microtime(true));[m
[32m+[m
[32m+[m[32m/*[m
[32m+[m[32m|--------------------------------------------------------------------------[m
[32m+[m[32m| Register The Auto Loader[m
[32m+[m[32m|--------------------------------------------------------------------------[m
[32m+[m[32m|[m
[32m+[m[32m| Composer provides a convenient, automatically generated class loader[m
[32m+[m[32m| for our application. We just need to utilize it! We'll require it[m
[32m+[m[32m| into the script here so that we do not have to worry about the[m
[32m+[m[32m| loading of any our classes "manually". Feels great to relax.[m
[32m+[m[32m|[m
[32m+[m[32m*/[m
[32m+[m
[32m+[m[32mrequire __DIR__.'/vendor/autoload.php';[m
[32m+[m
[32m+[m[32m$app = require_once __DIR__.'/bootstrap/app.php';[m
[32m+[m
[32m+[m[32m/*[m
[32m+[m[32m|--------------------------------------------------------------------------[m
[32m+[m[32m| Run The Artisan Application[m
[32m+[m[32m|--------------------------------------------------------------------------[m
[32m+[m[32m|[m
[32m+[m[32m| When we run the console application, the current CLI command will be[m
[32m+[m[32m| executed in this console and the response sent back to a terminal[m
[32m+[m[32m| or another output device for the developers. Here goes nothing![m
[32m+[m[32m|[m
[32m+[m[32m*/[m
[32m+[m
[32m+[m[32m$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);[m
[32m+[m
[32m+[m[32m$status = $kernel->handle([m
[32m+[m[32m    $input = new Symfony\Component\Console\Input\ArgvInput,[m
[32m+[m[32m    new Symfony\Component\Console\Output\ConsoleOutput[m
[32m+[m[32m);[m
[32m+[m
[32m+[m[32m/*[m
[32m+[m[32m|--------------------------------------------------------------------------[m
[32m+[m[32m| Shutdown The Application[m
[32m+[m[32m|--------------------------------------------------------------------------[m
[32m+[m[32m|[m
[32m+[m[32m| Once Artisan has finished running, we will fire off the shutdown events[m
[32m+[m[32m| so that any final work may be done by the application before we shut[m
[32m+[m[32m| down the process. This is the last thing to happen to the request.[m
[32m+[m[32m|[m
[32m+[m[32m*/[m
[32m+[m
[32m+[m[32m$kernel->terminate($input, $status);[m
[32m+[m
[32m+[m[32mexit($status);[m
[1mdiff --git a/bootstrap/app.php b/bootstrap/app.php[m
[1mnew file mode 100755[m
[1mindex 0000000..037e17d[m
[1m--- /dev/null[m
[1m+++ b/bootstrap/app.php[m
[36m@@ -0,0 +1,55 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32m/*[m
[32m+[m[32m|--------------------------------------------------------------------------[m
[32m+[m[32m| Create The Application[m
[32m+[m[32m|--------------------------------------------------------------------------[m
[32m+[m[32m|[m
[32m+[m[32m| The first thing we will do is create a new Laravel application instance[m
[32m+[m[32m| which serves as the "glue" for all the components of Laravel, and is[m
[32m+[m[32m| the IoC container for the system binding all of the various parts.[m
[32m+[m[32m|[m
[32m+[m[32m*/[m
[32m+[m
[32m+[m[32m$app = new Illuminate\Foundation\Application([m
[32m+[m[32m    $_ENV['APP_BASE_PATH'] ?? dirname(__DIR__)[m
[32m+[m[32m);[m
[32m+[m
[32m+[m[32m/*[m
[32m+[m[32m|--------------------------------------------------------------------------[m
[32m+[m[32m| Bind Important Interfaces[m
[32m+[m[32m|--------------------------------------------------------------------------[m
[32m+[m[32m|[m
[32m+[m[32m| Next, we need to bind some important interfaces into the container so[m
[32m+[m[32m| we will be able to resolve them when needed. The kernels serve the[m
[32m+[m[32m| incoming requests to this application from both the web and CLI.[m
[32m+[m[32m|[m
[32m+[m[32m*/[m
[32m+[m
[32m+[m[32m$app->singleton([m
[32m+[m[32m    Illuminate\Contracts\Http\Kernel::class,[m
[32m+[m[32m    App\Http\Kernel::class[m
[32m+[m[32m);[m
[32m+[m
[32m+[m[32m$app->singleton([m
[32m+[m[32m    Illuminate\Contracts\Console\Kernel::class,[m
[32m+[m[32m    App\Console\Kernel::class[m
[32m+[m[32m);[m
[32m+[m
[32m+[m[32m$app->singleton([m
[32m+[m[32m    Illuminate\Contracts\Debug\ExceptionHandler::class,[m
[32m+[m[32m    App\Exceptions\Handler::class[m
[32m+[m[32m);[m
[32m+[m
[32m+[m[32m/*[m
[32m+[m[32m|--------------------------------------------------------------------------[m
[32m+[m[32m| Return The Application[m
[32m+[m[32m|--------------------------------------------------------------------------[m
[32m+[m[32m|[m
[32m+[m[32m| This script returns the application instance. The instance is given to[m
[32m+[m[32m| the calling script so we can separate the building of the instances[m
[32m+[m[32m| from the actual running of the application and sending responses.[m
[32m+[m[32m|[m
[32m+[m[32m*/[m
[32m+[m
[32m+[m[32mreturn $app;[m
[1mdiff --git a/bootstrap/cache/.gitignore b/bootstrap/cache/.gitignore[m
[1mnew file mode 100755[m
[1mindex 0000000..d6b7ef3[m
[1m--- /dev/null[m
[1m+++ b/bootstrap/cache/.gitignore[m
[36m@@ -0,0 +1,2 @@[m
[32m+[m[32m*[m
[32m+[m[32m!.gitignore[m
[1mdiff --git a/composer.json b/composer.json[m
[1mnew file mode 100755[m
[1mindex 0000000..c34269c[m
[1m--- /dev/null[m
[1m+++ b/composer.json[m
[36m@@ -0,0 +1,64 @@[m
[32m+[m[32m{[m
[32m+[m[32m    "name": "laravel/laravel",[m
[32m+[m[32m    "type": "project",[m
[32m+[m[32m    "description": "The Laravel Framework.",[m
[32m+[m[32m    "keywords": [[m
[32m+[m[32m        "framework",[m
[32m+[m[32m        "laravel"[m
[32m+[m[32m    ],[m
[32m+[m[32m    "license": "MIT",[m
[32m+[m[32m    "require": {[m
[32m+[m[32m        "php": "^7.1.3",[m
[32m+[m[32m        "fideloper/proxy": "^4.0",[m
[32m+[m[32m        "intervention/image": "2.*",[m
[32m+[m[32m        "laravel/framework": "5.8.*",[m
[32m+[m[32m        "laravel/passport": "7.*",[m
[32m+[m[32m        "laravel/tinker": "^1.0"[m
[32m+[m[32m    },[m
[32m+[m[32m    "require-dev": {[m
[32m+[m[32m        "beyondcode/laravel-dump-server": "^1.0",[m
[32m+[m[32m        "filp/whoops": "^2.0",[m
[32m+[m[32m        "fzaninotto/faker": "^1.4",[m
[32m+[m[32m        "mockery/mockery": "^1.0",[m
[32m+[m[32m        "nunomaduro/collision": "^3.0",[m
[32m+[m[32m        "phpunit/phpunit": "^7.5"[m
[32m+[m[32m    },[m
[32m+[m[32m    "config": {[m
[32m+[m[32m        "optimize-autoloader": true,[m
[32m+[m[32m        "preferred-install": "dist",[m
[32m+[m[32m        "sort-packages": true[m
[32m+[m[32m    },[m
[32m+[m[32m    "extra": {[m
[32m+[m[32m        "laravel": {[m
[32m+[m[32m            "dont-discover": [][m
[32m+[m[32m        }[m
[32m+[m[32m    },[m
[32m+[m[32m    "autoload": {[m
[32m+[m[32m        "psr-4": {[m
[32m+[m[32m            "App\\": "app/"[m
[32m+[m[32m        },[m
[32m+[m[32m        "classmap": [[m
[32m+[m[32m            "database/seeds",[m
[32m+[m[32m            "database/factories"[m
[32m+[m[32m        ][m
[32m+[m[32m    },[m
[32m+[m[32m    "autoload-dev": {[m
[32m+[m[32m        "psr-4": {[m
[32m+[m[32m            "Tests\\": "tests/"[m
[32m+[m[32m        }[m
[32m+[m[32m    },[m
[32m+[m[32m    "minimum-stability": "dev",[m
[32m+[m[32m    "prefer-stable": true,[m
[32m+[m[32m    "scripts": {[m
[32m+[m[32m        "post-autoload-dump": [[m
[32m+[m[32m            "Illuminate\\Foundation\\ComposerScripts::postAutoloadDump",[m
[32m+[m[32m            "@php artisan package:discover --ansi"[m
[32m+[m[32m        ],[m
[32m+[m[32m        "post-root-package-install": [[m
[32m+[m[32m            "@php -r \"file_exists('.env') || copy('.env.example', '.env');\""[m
[32m+[m[32m        ],[m
[32m+[m[32m        "post-create-project-cmd": [[m
[32m+[m[32m            "@php artisan key:generate --ansi"[m
[32m+[m[32m        ][m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/composer.lock b/composer.lock[m
[1mnew file mode 100755[m
[1mindex 0000000..e99783d[m
[1m--- /dev/null[m
[1m+++ b/composer.lock[m
[36m@@ -0,0 +1,6859 @@[m
[32m+[m[32m{[m
[32m+[m[32m    "_readme": [[m
[32m+[m[32m        "This file locks the dependencies of your project to a known state",[m
[32m+[m[32m        "Read more about it at https://getcomposer.org/doc/01-basic-usage.md#installing-dependencies",[m
[32m+[m[32m        "This file is @generated automatically"[m
[32m+[m[32m    ],[m
[32m+[m[32m    "content-hash": "d0b413d974b1010d1364e7421d3303e1",[m
[32m+[m[32m    "packages": [[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "defuse/php-encryption",[m
[32m+[m[32m            "version": "v2.2.1",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/defuse/php-encryption.git",[m
[32m+[m[32m                "reference": "0f407c43b953d571421e0020ba92082ed5fb7620"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/defuse/php-encryption/zipball/0f407c43b953d571421e0020ba92082ed5fb7620",[m
[32m+[m[32m                "reference": "0f407c43b953d571421e0020ba92082ed5fb7620",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "ext-openssl": "*",[m
[32m+[m[32m                "paragonie/random_compat": ">= 2",[m
[32m+[m[32m                "php": ">=5.4.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "nikic/php-parser": "^2.0|^3.0|^4.0",[m
[32m+[m[32m                "phpunit/phpunit": "^4|^5"[m
[32m+[m[32m            },[m
[32m+[m[32m            "bin": [[m
[32m+[m[32m                "bin/generate-defuse-key"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Defuse\\Crypto\\": "src"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Taylor Hornby",[m
[32m+[m[32m                    "email": "taylor@defuse.ca",[m
[32m+[m[32m                    "homepage": "https://defuse.ca/"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Scott Arciszewski",[m
[32m+[m[32m                    "email": "info@paragonie.com",[m
[32m+[m[32m                    "homepage": "https://paragonie.com"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Secure PHP Encryption Library",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "aes",[m
[32m+[m[32m                "authenticated encryption",[m
[32m+[m[32m                "cipher",[m
[32m+[m[32m                "crypto",[m
[32m+[m[32m                "cryptography",[m
[32m+[m[32m                "encrypt",[m
[32m+[m[32m                "encryption",[m
[32m+[m[32m                "openssl",[m
[32m+[m[32m                "security",[m
[32m+[m[32m                "symmetric key cryptography"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/defuse/php-encryption/issues",[m
[32m+[m[32m                "source": "https://github.com/defuse/php-encryption/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2018-07-24T23:27:56+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "dnoegel/php-xdg-base-dir",[m
[32m+[m[32m            "version": "v0.1.1",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/dnoegel/php-xdg-base-dir.git",[m
[32m+[m[32m                "reference": "8f8a6e48c5ecb0f991c2fdcf5f154a47d85f9ffd"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/dnoegel/php-xdg-base-dir/zipball/8f8a6e48c5ecb0f991c2fdcf5f154a47d85f9ffd",[m
[32m+[m[32m                "reference": "8f8a6e48c5ecb0f991c2fdcf5f154a47d85f9ffd",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=5.3.2"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "phpunit/phpunit": "~7.0|~6.0|~5.0|~4.8.35"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "XdgBaseDir\\": "src/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "implementation of xdg base directory specification for php",[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/dnoegel/php-xdg-base-dir/issues",[m
[32m+[m[32m                "source": "https://github.com/dnoegel/php-xdg-base-dir/tree/v0.1.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2019-12-04T15:06:13+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "doctrine/inflector",[m
[32m+[m[32m            "version": "1.4.3",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/doctrine/inflector.git",[m
[32m+[m[32m                "reference": "4650c8b30c753a76bf44fb2ed00117d6f367490c"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/doctrine/inflector/zipball/4650c8b30c753a76bf44fb2ed00117d6f367490c",[m
[32m+[m[32m                "reference": "4650c8b30c753a76bf44fb2ed00117d6f367490c",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^7.2 || ^8.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "doctrine/coding-standard": "^7.0",[m
[32m+[m[32m                "phpstan/phpstan": "^0.11",[m
[32m+[m[32m                "phpstan/phpstan-phpunit": "^0.11",[m
[32m+[m[32m                "phpstan/phpstan-strict-rules": "^0.11",[m
[32m+[m[32m                "phpunit/phpunit": "^7.0 || ^8.0 || ^9.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "2.0.x-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Doctrine\\Common\\Inflector\\": "lib/Doctrine/Common/Inflector",[m
[32m+[m[32m                    "Doctrine\\Inflector\\": "lib/Doctrine/Inflector"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Guilherme Blanco",[m
[32m+[m[32m                    "email": "guilhermeblanco@gmail.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Roman Borschel",[m
[32m+[m[32m                    "email": "roman@code-factory.org"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Benjamin Eberlei",[m
[32m+[m[32m                    "email": "kontakt@beberlei.de"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Jonathan Wage",[m
[32m+[m[32m                    "email": "jonwage@gmail.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Johannes Schmitt",[m
[32m+[m[32m                    "email": "schmittjoh@gmail.com"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "PHP Doctrine Inflector is a small library that can perform string manipulations with regard to upper/lowercase and singular/plural forms of words.",[m
[32m+[m[32m            "homepage": "https://www.doctrine-project.org/projects/inflector.html",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "inflection",[m
[32m+[m[32m                "inflector",[m
[32m+[m[32m                "lowercase",[m
[32m+[m[32m                "manipulation",[m
[32m+[m[32m                "php",[m
[32m+[m[32m                "plural",[m
[32m+[m[32m                "singular",[m
[32m+[m[32m                "strings",[m
[32m+[m[32m                "uppercase",[m
[32m+[m[32m                "words"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/doctrine/inflector/issues",[m
[32m+[m[32m                "source": "https://github.com/doctrine/inflector/tree/1.4.x"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://www.doctrine-project.org/sponsorship.html",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://www.patreon.com/phpdoctrine",[m
[32m+[m[32m                    "type": "patreon"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/doctrine%2Finflector",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-05-29T07:19:59+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "doctrine/lexer",[m
[32m+[m[32m            "version": "1.2.1",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/doctrine/lexer.git",[m
[32m+[m[32m                "reference": "e864bbf5904cb8f5bb334f99209b48018522f042"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/doctrine/lexer/zipball/e864bbf5904cb8f5bb334f99209b48018522f042",[m
[32m+[m[32m                "reference": "e864bbf5904cb8f5bb334f99209b48018522f042",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^7.2 || ^8.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "doctrine/coding-standard": "^6.0",[m
[32m+[m[32m                "phpstan/phpstan": "^0.11.8",[m
[32m+[m[32m                "phpunit/phpunit": "^8.2"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "1.2.x-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Doctrine\\Common\\Lexer\\": "lib/Doctrine/Common/Lexer"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Guilherme Blanco",[m
[32m+[m[32m                    "email": "guilhermeblanco@gmail.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Roman Borschel",[m
[32m+[m[32m                    "email": "roman@code-factory.org"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Johannes Schmitt",[m
[32m+[m[32m                    "email": "schmittjoh@gmail.com"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "PHP Doctrine Lexer parser library that can be used in Top-Down, Recursive Descent Parsers.",[m
[32m+[m[32m            "homepage": "https://www.doctrine-project.org/projects/lexer.html",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "annotations",[m
[32m+[m[32m                "docblock",[m
[32m+[m[32m                "lexer",[m
[32m+[m[32m                "parser",[m
[32m+[m[32m                "php"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/doctrine/lexer/issues",[m
[32m+[m[32m                "source": "https://github.com/doctrine/lexer/tree/1.2.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://www.doctrine-project.org/sponsorship.html",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://www.patreon.com/phpdoctrine",[m
[32m+[m[32m                    "type": "patreon"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/doctrine%2Flexer",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-05-25T17:44:05+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "dragonmantank/cron-expression",[m
[32m+[m[32m            "version": "v2.3.1",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/dragonmantank/cron-expression.git",[m
[32m+[m[32m                "reference": "65b2d8ee1f10915efb3b55597da3404f096acba2"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/dragonmantank/cron-expression/zipball/65b2d8ee1f10915efb3b55597da3404f096acba2",[m
[32m+[m[32m                "reference": "65b2d8ee1f10915efb3b55597da3404f096acba2",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^7.0|^8.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "phpunit/phpunit": "^6.4|^7.0|^8.0|^9.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "2.3-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Cron\\": "src/Cron/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Michael Dowling",[m
[32m+[m[32m                    "email": "mtdowling@gmail.com",[m
[32m+[m[32m                    "homepage": "https://github.com/mtdowling"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Chris Tankersley",[m
[32m+[m[32m                    "email": "chris@ctankersley.com",[m
[32m+[m[32m                    "homepage": "https://github.com/dragonmantank"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "CRON for PHP: Calculate the next or previous run date and determine if a CRON expression is due",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "cron",[m
[32m+[m[32m                "schedule"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/dragonmantank/cron-expression/issues",[m
[32m+[m[32m                "source": "https://github.com/dragonmantank/cron-expression/tree/v2.3.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/dragonmantank",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-10-13T00:52:37+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "egulias/email-validator",[m
[32m+[m[32m            "version": "2.1.23",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/egulias/EmailValidator.git",[m
[32m+[m[32m                "reference": "5fa792ad1853ae2bc60528dd3e5cbf4542d3c1df"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/egulias/EmailValidator/zipball/5fa792ad1853ae2bc60528dd3e5cbf4542d3c1df",[m
[32m+[m[32m                "reference": "5fa792ad1853ae2bc60528dd3e5cbf4542d3c1df",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "doctrine/lexer": "^1.0.1",[m
[32m+[m[32m                "php": ">=5.5",[m
[32m+[m[32m                "symfony/polyfill-intl-idn": "^1.10"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "dominicsayers/isemail": "^3.0.7",[m
[32m+[m[32m                "phpunit/phpunit": "^4.8.36|^7.5.15",[m
[32m+[m[32m                "satooshi/php-coveralls": "^1.0.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "ext-intl": "PHP Internationalization Libraries are required to use the SpoofChecking validation"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "2.1.x-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Egulias\\EmailValidator\\": "src"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Eduardo Gulias Davis"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "A library for validating emails against several RFCs",[m
[32m+[m[32m            "homepage": "https://github.com/egulias/EmailValidator",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "email",[m
[32m+[m[32m                "emailvalidation",[m
[32m+[m[32m                "emailvalidator",[m
[32m+[m[32m                "validation",[m
[32m+[m[32m                "validator"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/egulias/EmailValidator/issues",[m
[32m+[m[32m                "source": "https://github.com/egulias/EmailValidator/tree/2.1.23"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2020-10-31T20:37:35+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "erusev/parsedown",[m
[32m+[m[32m            "version": "1.7.4",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/erusev/parsedown.git",[m
[32m+[m[32m                "reference": "cb17b6477dfff935958ba01325f2e8a2bfa6dab3"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/erusev/parsedown/zipball/cb17b6477dfff935958ba01325f2e8a2bfa6dab3",[m
[32m+[m[32m                "reference": "cb17b6477dfff935958ba01325f2e8a2bfa6dab3",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "ext-mbstring": "*",[m
[32m+[m[32m                "php": ">=5.3.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "phpunit/phpunit": "^4.8.35"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-0": {[m
[32m+[m[32m                    "Parsedown": ""[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Emanuil Rusev",[m
[32m+[m[32m                    "email": "hello@erusev.com",[m
[32m+[m[32m                    "homepage": "http://erusev.com"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Parser for Markdown.",[m
[32m+[m[32m            "homepage": "http://parsedown.org",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "markdown",[m
[32m+[m[32m                "parser"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/erusev/parsedown/issues",[m
[32m+[m[32m                "source": "https://github.com/erusev/parsedown/tree/1.7.x"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2019-12-30T22:54:17+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "fideloper/proxy",[m
[32m+[m[32m            "version": "4.4.1",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/fideloper/TrustedProxy.git",[m
[32m+[m[32m                "reference": "c073b2bd04d1c90e04dc1b787662b558dd65ade0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/fideloper/TrustedProxy/zipball/c073b2bd04d1c90e04dc1b787662b558dd65ade0",[m
[32m+[m[32m                "reference": "c073b2bd04d1c90e04dc1b787662b558dd65ade0",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "illuminate/contracts": "^5.0|^6.0|^7.0|^8.0|^9.0",[m
[32m+[m[32m                "php": ">=5.4.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "illuminate/http": "^5.0|^6.0|^7.0|^8.0|^9.0",[m
[32m+[m[32m                "mockery/mockery": "^1.0",[m
[32m+[m[32m                "phpunit/phpunit": "^6.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "laravel": {[m
[32m+[m[32m                    "providers": [[m
[32m+[m[32m                        "Fideloper\\Proxy\\TrustedProxyServiceProvider"[m
[32m+[m[32m                    ][m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Fideloper\\Proxy\\": "src/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Chris Fidao",[m
[32m+[m[32m                    "email": "fideloper@gmail.com"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Set trusted proxies for Laravel",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "load balancing",[m
[32m+[m[32m                "proxy",[m
[32m+[m[32m                "trusted proxy"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/fideloper/TrustedProxy/issues",[m
[32m+[m[32m                "source": "https://github.com/fideloper/TrustedProxy/tree/4.4.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2020-10-22T13:48:01+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "firebase/php-jwt",[m
[32m+[m[32m            "version": "v5.2.0",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/firebase/php-jwt.git",[m
[32m+[m[32m                "reference": "feb0e820b8436873675fd3aca04f3728eb2185cb"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/firebase/php-jwt/zipball/feb0e820b8436873675fd3aca04f3728eb2185cb",[m
[32m+[m[32m                "reference": "feb0e820b8436873675fd3aca04f3728eb2185cb",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=5.3.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "phpunit/phpunit": ">=4.8 <=9"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Firebase\\JWT\\": "src"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-3-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Neuman Vong",[m
[32m+[m[32m                    "email": "neuman+pear@twilio.com",[m
[32m+[m[32m                    "role": "Developer"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Anant Narayanan",[m
[32m+[m[32m                    "email": "anant@php.net",[m
[32m+[m[32m                    "role": "Developer"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "A simple library to encode and decode JSON Web Tokens (JWT) in PHP. Should conform to the current spec.",[m
[32m+[m[32m            "homepage": "https://github.com/firebase/php-jwt",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "jwt",[m
[32m+[m[32m                "php"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/firebase/php-jwt/issues",[m
[32m+[m[32m                "source": "https://github.com/firebase/php-jwt/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2020-03-25T18:49:23+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "guzzlehttp/guzzle",[m
[32m+[m[32m            "version": "6.5.5",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/guzzle/guzzle.git",[m
[32m+[m[32m                "reference": "9d4290de1cfd701f38099ef7e183b64b4b7b0c5e"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/guzzle/guzzle/zipball/9d4290de1cfd701f38099ef7e183b64b4b7b0c5e",[m
[32m+[m[32m                "reference": "9d4290de1cfd701f38099ef7e183b64b4b7b0c5e",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "ext-json": "*",[m
[32m+[m[32m                "guzzlehttp/promises": "^1.0",[m
[32m+[m[32m                "guzzlehttp/psr7": "^1.6.1",[m
[32m+[m[32m                "php": ">=5.5",[m
[32m+[m[32m                "symfony/polyfill-intl-idn": "^1.17.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "ext-curl": "*",[m
[32m+[m[32m                "phpunit/phpunit": "^4.8.35 || ^5.7 || ^6.4 || ^7.0",[m
[32m+[m[32m                "psr/log": "^1.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "psr/log": "Required for using the Log middleware"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "6.5-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "GuzzleHttp\\": "src/"[m
[32m+[m[32m                },[m
[32m+[m[32m                "files": [[m
[32m+[m[32m                    "src/functions_include.php"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Michael Dowling",[m
[32m+[m[32m                    "email": "mtdowling@gmail.com",[m
[32m+[m[32m                    "homepage": "https://github.com/mtdowling"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Guzzle is a PHP HTTP client library",[m
[32m+[m[32m            "homepage": "http://guzzlephp.org/",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "client",[m
[32m+[m[32m                "curl",[m
[32m+[m[32m                "framework",[m
[32m+[m[32m                "http",[m
[32m+[m[32m                "http client",[m
[32m+[m[32m                "rest",[m
[32m+[m[32m                "web service"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/guzzle/guzzle/issues",[m
[32m+[m[32m                "source": "https://github.com/guzzle/guzzle/tree/6.5"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2020-06-16T21:01:06+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "guzzlehttp/promises",[m
[32m+[m[32m            "version": "1.4.0",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/guzzle/promises.git",[m
[32m+[m[32m                "reference": "60d379c243457e073cff02bc323a2a86cb355631"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/guzzle/promises/zipball/60d379c243457e073cff02bc323a2a86cb355631",[m
[32m+[m[32m                "reference": "60d379c243457e073cff02bc323a2a86cb355631",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=5.5"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "symfony/phpunit-bridge": "^4.4 || ^5.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "1.4-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "GuzzleHttp\\Promise\\": "src/"[m
[32m+[m[32m                },[m
[32m+[m[32m                "files": [[m
[32m+[m[32m                    "src/functions_include.php"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Michael Dowling",[m
[32m+[m[32m                    "email": "mtdowling@gmail.com",[m
[32m+[m[32m                    "homepage": "https://github.com/mtdowling"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Guzzle promises library",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "promise"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/guzzle/promises/issues",[m
[32m+[m[32m                "source": "https://github.com/guzzle/promises/tree/1.4.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2020-09-30T07:37:28+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "guzzlehttp/psr7",[m
[32m+[m[32m            "version": "1.7.0",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/guzzle/psr7.git",[m
[32m+[m[32m                "reference": "53330f47520498c0ae1f61f7e2c90f55690c06a3"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/guzzle/psr7/zipball/53330f47520498c0ae1f61f7e2c90f55690c06a3",[m
[32m+[m[32m                "reference": "53330f47520498c0ae1f61f7e2c90f55690c06a3",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=5.4.0",[m
[32m+[m[32m                "psr/http-message": "~1.0",[m
[32m+[m[32m                "ralouphie/getallheaders": "^2.0.5 || ^3.0.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "provide": {[m
[32m+[m[32m                "psr/http-message-implementation": "1.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "ext-zlib": "*",[m
[32m+[m[32m                "phpunit/phpunit": "~4.8.36 || ^5.7.27 || ^6.5.14 || ^7.5.20 || ^8.5.8 || ^9.3.10"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "laminas/laminas-httphandlerrunner": "Emit PSR-7 responses"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "1.7-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "GuzzleHttp\\Psr7\\": "src/"[m
[32m+[m[32m                },[m
[32m+[m[32m                "files": [[m
[32m+[m[32m                    "src/functions_include.php"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Michael Dowling",[m
[32m+[m[32m                    "email": "mtdowling@gmail.com",[m
[32m+[m[32m                    "homepage": "https://github.com/mtdowling"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Tobias Schultze",[m
[32m+[m[32m                    "homepage": "https://github.com/Tobion"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "PSR-7 message implementation that also provides common utility methods",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "http",[m
[32m+[m[32m                "message",[m
[32m+[m[32m                "psr-7",[m
[32m+[m[32m                "request",[m
[32m+[m[32m                "response",[m
[32m+[m[32m                "stream",[m
[32m+[m[32m                "uri",[m
[32m+[m[32m                "url"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/guzzle/psr7/issues",[m
[32m+[m[32m                "source": "https://github.com/guzzle/psr7/tree/1.7.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2020-09-30T07:37:11+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "intervention/image",[m
[32m+[m[32m            "version": "2.5.1",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/Intervention/image.git",[m
[32m+[m[32m                "reference": "abbf18d5ab8367f96b3205ca3c89fb2fa598c69e"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/Intervention/image/zipball/abbf18d5ab8367f96b3205ca3c89fb2fa598c69e",[m
[32m+[m[32m                "reference": "abbf18d5ab8367f96b3205ca3c89fb2fa598c69e",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "ext-fileinfo": "*",[m
[32m+[m[32m                "guzzlehttp/psr7": "~1.1",[m
[32m+[m[32m                "php": ">=5.4.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "mockery/mockery": "~0.9.2",[m
[32m+[m[32m                "phpunit/phpunit": "^4.8 || ^5.7"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "ext-gd": "to use GD library based image processing.",[m
[32m+[m[32m                "ext-imagick": "to use Imagick based image processing.",[m
[32m+[m[32m                "intervention/imagecache": "Caching extension for the Intervention Image library"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "2.4-dev"[m
[32m+[m[32m                },[m
[32m+[m[32m                "laravel": {[m
[32m+[m[32m                    "providers": [[m
[32m+[m[32m                        "Intervention\\Image\\ImageServiceProvider"[m
[32m+[m[32m                    ],[m
[32m+[m[32m                    "aliases": {[m
[32m+[m[32m                        "Image": "Intervention\\Image\\Facades\\Image"[m
[32m+[m[32m                    }[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Intervention\\Image\\": "src/Intervention/Image"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Oliver Vogel",[m
[32m+[m[32m                    "email": "oliver@olivervogel.com",[m
[32m+[m[32m                    "homepage": "http://olivervogel.com/"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Image handling and manipulation library with support for Laravel integration",[m
[32m+[m[32m            "homepage": "http://image.intervention.io/",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "gd",[m
[32m+[m[32m                "image",[m
[32m+[m[32m                "imagick",[m
[32m+[m[32m                "laravel",[m
[32m+[m[32m                "thumbnail",[m
[32m+[m[32m                "watermark"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/Intervention/image/issues",[m
[32m+[m[32m                "source": "https://github.com/Intervention/image/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2019-11-02T09:15:47+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "jakub-onderka/php-console-color",[m
[32m+[m[32m            "version": "v0.2",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/JakubOnderka/PHP-Console-Color.git",[m
[32m+[m[32m                "reference": "d5deaecff52a0d61ccb613bb3804088da0307191"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/JakubOnderka/PHP-Console-Color/zipball/d5deaecff52a0d61ccb613bb3804088da0307191",[m
[32m+[m[32m                "reference": "d5deaecff52a0d61ccb613bb3804088da0307191",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=5.4.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "jakub-onderka/php-code-style": "1.0",[m
[32m+[m[32m                "jakub-onderka/php-parallel-lint": "1.0",[m
[32m+[m[32m                "jakub-onderka/php-var-dump-check": "0.*",[m
[32m+[m[32m                "phpunit/phpunit": "~4.3",[m
[32m+[m[32m                "squizlabs/php_codesniffer": "1.*"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "JakubOnderka\\PhpConsoleColor\\": "src/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-2-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Jakub Onderka",[m
[32m+[m[32m                    "email": "jakub.onderka@gmail.com"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/JakubOnderka/PHP-Console-Color/issues",[m
[32m+[m[32m                "source": "https://github.com/JakubOnderka/PHP-Console-Color/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "abandoned": "php-parallel-lint/php-console-color",[m
[32m+[m[32m            "time": "2018-09-29T17:23:10+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "jakub-onderka/php-console-highlighter",[m
[32m+[m[32m            "version": "v0.4",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/JakubOnderka/PHP-Console-Highlighter.git",[m
[32m+[m[32m                "reference": "9f7a229a69d52506914b4bc61bfdb199d90c5547"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/JakubOnderka/PHP-Console-Highlighter/zipball/9f7a229a69d52506914b4bc61bfdb199d90c5547",[m
[32m+[m[32m                "reference": "9f7a229a69d52506914b4bc61bfdb199d90c5547",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "ext-tokenizer": "*",[m
[32m+[m[32m                "jakub-onderka/php-console-color": "~0.2",[m
[32m+[m[32m                "php": ">=5.4.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "jakub-onderka/php-code-style": "~1.0",[m
[32m+[m[32m                "jakub-onderka/php-parallel-lint": "~1.0",[m
[32m+[m[32m                "jakub-onderka/php-var-dump-check": "~0.1",[m
[32m+[m[32m                "phpunit/phpunit": "~4.0",[m
[32m+[m[32m                "squizlabs/php_codesniffer": "~1.5"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "JakubOnderka\\PhpConsoleHighlighter\\": "src/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Jakub Onderka",[m
[32m+[m[32m                    "email": "acci@acci.cz",[m
[32m+[m[32m                    "homepage": "http://www.acci.cz/"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Highlight PHP code in terminal",[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/JakubOnderka/PHP-Console-Highlighter/issues",[m
[32m+[m[32m                "source": "https://github.com/JakubOnderka/PHP-Console-Highlighter/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "abandoned": "php-parallel-lint/php-console-highlighter",[m
[32m+[m[32m            "time": "2018-09-29T18:48:56+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "laravel/framework",[m
[32m+[m[32m            "version": "v5.8.38",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/laravel/framework.git",[m
[32m+[m[32m                "reference": "78eb4dabcc03e189620c16f436358d41d31ae11f"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/laravel/framework/zipball/78eb4dabcc03e189620c16f436358d41d31ae11f",[m
[32m+[m[32m                "reference": "78eb4dabcc03e189620c16f436358d41d31ae11f",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "doctrine/inflector": "^1.1",[m
[32m+[m[32m                "dragonmantank/cron-expression": "^2.0",[m
[32m+[m[32m                "egulias/email-validator": "^2.0",[m
[32m+[m[32m                "erusev/parsedown": "^1.7",[m
[32m+[m[32m                "ext-json": "*",[m
[32m+[m[32m                "ext-mbstring": "*",[m
[32m+[m[32m                "ext-openssl": "*",[m
[32m+[m[32m                "league/flysystem": "^1.0.8",[m
[32m+[m[32m                "monolog/monolog": "^1.12",[m
[32m+[m[32m                "nesbot/carbon": "^1.26.3 || ^2.0",[m
[32m+[m[32m                "opis/closure": "^3.1",[m
[32m+[m[32m                "php": "^7.1.3",[m
[32m+[m[32m                "psr/container": "^1.0",[m
[32m+[m[32m                "psr/simple-cache": "^1.0",[m
[32m+[m[32m                "ramsey/uuid": "^3.7",[m
[32m+[m[32m                "swiftmailer/swiftmailer": "^6.0",[m
[32m+[m[32m                "symfony/console": "^4.2",[m
[32m+[m[32m                "symfony/debug": "^4.2",[m
[32m+[m[32m                "symfony/finder": "^4.2",[m
[32m+[m[32m                "symfony/http-foundation": "^4.2",[m
[32m+[m[32m                "symfony/http-kernel": "^4.2",[m
[32m+[m[32m                "symfony/process": "^4.2",[m
[32m+[m[32m                "symfony/routing": "^4.2",[m
[32m+[m[32m                "symfony/var-dumper": "^4.2",[m
[32m+[m[32m                "tijsverkoyen/css-to-inline-styles": "^2.2.1",[m
[32m+[m[32m                "vlucas/phpdotenv": "^3.3"[m
[32m+[m[32m            },[m
[32m+[m[32m            "conflict": {[m
[32m+[m[32m                "tightenco/collect": "<5.5.33"[m
[32m+[m[32m            },[m
[32m+[m[32m            "replace": {[m
[32m+[m[32m                "illuminate/auth": "self.version",[m
[32m+[m[32m                "illuminate/broadcasting": "self.version",[m
[32m+[m[32m                "illuminate/bus": "self.version",[m
[32m+[m[32m                "illuminate/cache": "self.version",[m
[32m+[m[32m                "illuminate/config": "self.version",[m
[32m+[m[32m                "illuminate/console": "self.version",[m
[32m+[m[32m                "illuminate/container": "self.version",[m
[32m+[m[32m                "illuminate/contracts": "self.version",[m
[32m+[m[32m                "illuminate/cookie": "self.version",[m
[32m+[m[32m                "illuminate/database": "self.version",[m
[32m+[m[32m                "illuminate/encryption": "self.version",[m
[32m+[m[32m                "illuminate/events": "self.version",[m
[32m+[m[32m                "illuminate/filesystem": "self.version",[m
[32m+[m[32m                "illuminate/hashing": "self.version",[m
[32m+[m[32m                "illuminate/http": "self.version",[m
[32m+[m[32m                "illuminate/log": "self.version",[m
[32m+[m[32m                "illuminate/mail": "self.version",[m
[32m+[m[32m                "illuminate/notifications": "self.version",[m
[32m+[m[32m                "illuminate/pagination": "self.version",[m
[32m+[m[32m                "illuminate/pipeline": "self.version",[m
[32m+[m[32m                "illuminate/queue": "self.version",[m
[32m+[m[32m                "illuminate/redis": "self.version",[m
[32m+[m[32m                "illuminate/routing": "self.version",[m
[32m+[m[32m                "illuminate/session": "self.version",[m
[32m+[m[32m                "illuminate/support": "self.version",[m
[32m+[m[32m                "illuminate/translation": "self.version",[m
[32m+[m[32m                "illuminate/validation": "self.version",[m
[32m+[m[32m                "illuminate/view": "self.version"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "aws/aws-sdk-php": "^3.0",[m
[32m+[m[32m                "doctrine/dbal": "^2.6",[m
[32m+[m[32m                "filp/whoops": "^2.1.4",[m
[32m+[m[32m                "guzzlehttp/guzzle": "^6.3",[m
[32m+[m[32m                "league/flysystem-cached-adapter": "^1.0",[m
[32m+[m[32m                "mockery/mockery": "^1.0",[m
[32m+[m[32m                "moontoast/math": "^1.1",[m
[32m+[m[32m                "orchestra/testbench-core": "3.8.*",[m
[32m+[m[32m                "pda/pheanstalk": "^4.0",[m
[32m+[m[32m                "phpunit/phpunit": "^7.5|^8.0",[m
[32m+[m[32m                "predis/predis": "^1.1.1",[m
[32m+[m[32m                "symfony/css-selector": "^4.2",[m
[32m+[m[32m                "symfony/dom-crawler": "^4.2",[m
[32m+[m[32m                "true/punycode": "^2.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "aws/aws-sdk-php": "Required to use the SQS queue driver and SES mail driver (^3.0).",[m
[32m+[m[32m                "doctrine/dbal": "Required to rename columns and drop SQLite columns (^2.6).",[m
[32m+[m[32m                "ext-gd": "Required to use Illuminate\\Http\\Testing\\FileFactory::image().",[m
[32m+[m[32m                "ext-pcntl": "Required to use all features of the queue worker.",[m
[32m+[m[32m                "ext-posix": "Required to use all features of the queue worker.",[m
[32m+[m[32m                "filp/whoops": "Required for friendly error pages in development (^2.1.4).",[m
[32m+[m[32m                "fzaninotto/faker": "Required to use the eloquent factory builder (^1.4).",[m
[32m+[m[32m                "guzzlehttp/guzzle": "Required to use the Mailgun and Mandrill mail drivers and the ping methods on schedules (^6.0).",[m
[32m+[m[32m                "laravel/tinker": "Required to use the tinker console command (^1.0).",[m
[32m+[m[32m                "league/flysystem-aws-s3-v3": "Required to use the Flysystem S3 driver (^1.0).",[m
[32m+[m[32m                "league/flysystem-cached-adapter": "Required to use the Flysystem cache (^1.0).",[m
[32m+[m[32m                "league/flysystem-rackspace": "Required to use the Flysystem Rackspace driver (^1.0).",[m
[32m+[m[32m                "league/flysystem-sftp": "Required to use the Flysystem SFTP driver (^1.0).",[m
[32m+[m[32m                "moontoast/math": "Required to use ordered UUIDs (^1.1).",[m
[32m+[m[32m                "nexmo/client": "Required to use the Nexmo transport (^1.0).",[m
[32m+[m[32m                "pda/pheanstalk": "Required to use the beanstalk queue driver (^4.0).",[m
[32m+[m[32m                "predis/predis": "Required to use the redis cache and queue drivers (^1.0).",[m
[32m+[m[32m                "pusher/pusher-php-server": "Required to use the Pusher broadcast driver (^3.0).",[m
[32m+[m[32m                "symfony/css-selector": "Required to use some of the crawler integration testing tools (^4.2).",[m
[32m+[m[32m                "symfony/dom-crawler": "Required to use most of the crawler integration testing tools (^4.2).",[m
[32m+[m[32m                "symfony/psr-http-message-bridge": "Required to use PSR-7 bridging features (^1.1).",[m
[32m+[m[32m                "wildbit/swiftmailer-postmark": "Required to use Postmark mail driver (^3.0)."[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "5.8-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "files": [[m
[32m+[m[32m                    "src/Illuminate/Foundation/helpers.php",[m
[32m+[m[32m                    "src/Illuminate/Support/helpers.php"[m
[32m+[m[32m                ],[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Illuminate\\": "src/Illuminate/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Taylor Otwell",[m
[32m+[m[32m                    "email": "taylor@laravel.com"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "The Laravel Framework.",[m
[32m+[m[32m            "homepage": "https://laravel.com",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "framework",[m
[32m+[m[32m                "laravel"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/laravel/framework/issues",[m
[32m+[m[32m                "source": "https://github.com/laravel/framework"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2020-04-14T14:14:36+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "laravel/passport",[m
[32m+[m[32m            "version": "v7.5.1",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/laravel/passport.git",[m
[32m+[m[32m                "reference": "d63cdd672c3d65b3c35b73d0ef13a9dbfcb71c08"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/laravel/passport/zipball/d63cdd672c3d65b3c35b73d0ef13a9dbfcb71c08",[m
[32m+[m[32m                "reference": "d63cdd672c3d65b3c35b73d0ef13a9dbfcb71c08",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "ext-json": "*",[m
[32m+[m[32m                "firebase/php-jwt": "~3.0|~4.0|~5.0",[m
[32m+[m[32m                "guzzlehttp/guzzle": "~6.0",[m
[32m+[m[32m                "illuminate/auth": "~5.6.0|~5.7.0|~5.8.0|^6.0|^7.0",[m
[32m+[m[32m                "illuminate/console": "~5.6.0|~5.7.0|~5.8.0|^6.0|^7.0",[m
[32m+[m[32m                "illuminate/container": "~5.6.0|~5.7.0|~5.8.0|^6.0|^7.0",[m
[32m+[m[32m                "illuminate/contracts": "~5.6.0|~5.7.0|~5.8.0|^6.0|^7.0",[m
[32m+[m[32m                "illuminate/cookie": "~5.6.0|~5.7.0|~5.8.0|^6.0|^7.0",[m
[32m+[m[32m                "illuminate/database": "~5.6.0|~5.7.0|~5.8.0|^6.0|^7.0",[m
[32m+[m[32m                "illuminate/encryption": "~5.6.0|~5.7.0|~5.8.0|^6.0|^7.0",[m
[32m+[m[32m                "illuminate/http": "~5.6.0|~5.7.0|~5.8.0|^6.0|^7.0",[m
[32m+[m[32m                "illuminate/support": "~5.6.0|~5.7.0|~5.8.0|^6.0|^7.0",[m
[32m+[m[32m                "league/oauth2-server": "^7.0",[m
[32m+[m[32m                "php": ">=7.1",[m
[32m+[m[32m                "phpseclib/phpseclib": "^2.0",[m
[32m+[m[32m                "symfony/psr-http-message-bridge": "~1.0",[m
[32m+[m[32m                "zendframework/zend-diactoros": "~1.0|~2.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "mockery/mockery": "^1.0",[m
[32m+[m[32m                "phpunit/phpunit": "^7.4|^8.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "7.0-dev"[m
[32m+[m[32m                },[m
[32m+[m[32m                "laravel": {[m
[32m+[m[32m                    "providers": [[m
[32m+[m[32m                        "Laravel\\Passport\\PassportServiceProvider"[m
[32m+[m[32m                    ][m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Laravel\\Passport\\": "src/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Taylor Otwell",[m
[32m+[m[32m                    "email": "taylor@laravel.com"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Laravel Passport provides OAuth2 server support to Laravel.",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "laravel",[m
[32m+[m[32m                "oauth",[m
[32m+[m[32m                "passport"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/laravel/passport/issues",[m
[32m+[m[32m                "source": "https://github.com/laravel/passport"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2019-10-08T16:45:24+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "laravel/tinker",[m
[32m+[m[32m            "version": "v1.0.10",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/laravel/tinker.git",[m
[32m+[m[32m                "reference": "ad571aacbac1539c30d480908f9d0c9614eaf1a7"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/laravel/tinker/zipball/ad571aacbac1539c30d480908f9d0c9614eaf1a7",[m
[32m+[m[32m                "reference": "ad571aacbac1539c30d480908f9d0c9614eaf1a7",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "illuminate/console": "~5.1|^6.0",[m
[32m+[m[32m                "illuminate/contracts": "~5.1|^6.0",[m
[32m+[m[32m                "illuminate/support": "~5.1|^6.0",[m
[32m+[m[32m                "php": ">=5.5.9",[m
[32m+[m[32m                "psy/psysh": "0.7.*|0.8.*|0.9.*",[m
[32m+[m[32m                "symfony/var-dumper": "~3.0|~4.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "phpunit/phpunit": "~4.0|~5.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "illuminate/database": "The Illuminate Database package (~5.1)."[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "1.0-dev"[m
[32m+[m[32m                },[m
[32m+[m[32m                "laravel": {[m
[32m+[m[32m                    "providers": [[m
[32m+[m[32m                        "Laravel\\Tinker\\TinkerServiceProvider"[m
[32m+[m[32m                    ][m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Laravel\\Tinker\\": "src/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Taylor Otwell",[m
[32m+[m[32m                    "email": "taylor@laravel.com"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Powerful REPL for the Laravel framework.",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "REPL",[m
[32m+[m[32m                "Tinker",[m
[32m+[m[32m                "laravel",[m
[32m+[m[32m                "psysh"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/laravel/tinker/issues",[m
[32m+[m[32m                "source": "https://github.com/laravel/tinker/tree/v1.0.10"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2019-08-07T15:10:45+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "lcobucci/jwt",[m
[32m+[m[32m            "version": "3.3.3",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/lcobucci/jwt.git",[m
[32m+[m[32m                "reference": "c1123697f6a2ec29162b82f170dd4a491f524773"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/lcobucci/jwt/zipball/c1123697f6a2ec29162b82f170dd4a491f524773",[m
[32m+[m[32m                "reference": "c1123697f6a2ec29162b82f170dd4a491f524773",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "ext-mbstring": "*",[m
[32m+[m[32m                "ext-openssl": "*",[m
[32m+[m[32m                "php": "^5.6 || ^7.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "mikey179/vfsstream": "~1.5",[m
[32m+[m[32m                "phpmd/phpmd": "~2.2",[m
[32m+[m[32m                "phpunit/php-invoker": "~1.1",[m
[32m+[m[32m                "phpunit/phpunit": "^5.7 || ^7.3",[m
[32m+[m[32m                "squizlabs/php_codesniffer": "~2.3"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "3.1-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Lcobucci\\JWT\\": "src"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-3-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Luís Otávio Cobucci Oblonczyk",[m
[32m+[m[32m                    "email": "lcobucci@gmail.com",[m
[32m+[m[32m                    "role": "Developer"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "A simple library to work with JSON Web Token and JSON Web Signature",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "JWS",[m
[32m+[m[32m                "jwt"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/lcobucci/jwt/issues",[m
[32m+[m[32m                "source": "https://github.com/lcobucci/jwt/tree/3.3.3"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/lcobucci",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://www.patreon.com/lcobucci",[m
[32m+[m[32m                    "type": "patreon"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-08-20T13:22:28+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "league/event",[m
[32m+[m[32m            "version": "2.2.0",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/thephpleague/event.git",[m
[32m+[m[32m                "reference": "d2cc124cf9a3fab2bb4ff963307f60361ce4d119"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/thephpleague/event/zipball/d2cc124cf9a3fab2bb4ff963307f60361ce4d119",[m
[32m+[m[32m                "reference": "d2cc124cf9a3fab2bb4ff963307f60361ce4d119",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=5.4.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "henrikbjorn/phpspec-code-coverage": "~1.0.1",[m
[32m+[m[32m                "phpspec/phpspec": "^2.2"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "2.2-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "League\\Event\\": "src/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Frank de Jonge",[m
[32m+[m[32m                    "email": "info@frenky.net"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Event package",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "emitter",[m
[32m+[m[32m                "event",[m
[32m+[m[32m                "listener"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/thephpleague/event/issues",[m
[32m+[m[32m                "source": "https://github.com/thephpleague/event/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2018-11-26T11:52:41+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "league/flysystem",[m
[32m+[m[32m            "version": "1.1.3",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/thephpleague/flysystem.git",[m
[32m+[m[32m                "reference": "9be3b16c877d477357c015cec057548cf9b2a14a"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/thephpleague/flysystem/zipball/9be3b16c877d477357c015cec057548cf9b2a14a",[m
[32m+[m[32m                "reference": "9be3b16c877d477357c015cec057548cf9b2a14a",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "ext-fileinfo": "*",[m
[32m+[m[32m                "league/mime-type-detection": "^1.3",[m
[32m+[m[32m                "php": "^7.2.5 || ^8.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "conflict": {[m
[32m+[m[32m                "league/flysystem-sftp": "<1.0.6"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "phpspec/prophecy": "^1.11.1",[m
[32m+[m[32m                "phpunit/phpunit": "^8.5.8"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "ext-fileinfo": "Required for MimeType",[m
[32m+[m[32m                "ext-ftp": "Allows you to use FTP server storage",[m
[32m+[m[32m                "ext-openssl": "Allows you to use FTPS server storage",[m
[32m+[m[32m                "league/flysystem-aws-s3-v2": "Allows you to use S3 storage with AWS SDK v2",[m
[32m+[m[32m                "league/flysystem-aws-s3-v3": "Allows you to use S3 storage with AWS SDK v3",[m
[32m+[m[32m                "league/flysystem-azure": "Allows you to use Windows Azure Blob storage",[m
[32m+[m[32m                "league/flysystem-cached-adapter": "Flysystem adapter decorator for metadata caching",[m
[32m+[m[32m                "league/flysystem-eventable-filesystem": "Allows you to use EventableFilesystem",[m
[32m+[m[32m                "league/flysystem-rackspace": "Allows you to use Rackspace Cloud Files",[m
[32m+[m[32m                "league/flysystem-sftp": "Allows you to use SFTP server storage via phpseclib",[m
[32m+[m[32m                "league/flysystem-webdav": "Allows you to use WebDAV storage",[m
[32m+[m[32m                "league/flysystem-ziparchive": "Allows you to use ZipArchive adapter",[m
[32m+[m[32m                "spatie/flysystem-dropbox": "Allows you to use Dropbox storage",[m
[32m+[m[32m                "srmklive/flysystem-dropbox-v2": "Allows you to use Dropbox storage for PHP 5 applications"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "1.1-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "League\\Flysystem\\": "src/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Frank de Jonge",[m
[32m+[m[32m                    "email": "info@frenky.net"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Filesystem abstraction: Many filesystems, one API.",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "Cloud Files",[m
[32m+[m[32m                "WebDAV",[m
[32m+[m[32m                "abstraction",[m
[32m+[m[32m                "aws",[m
[32m+[m[32m                "cloud",[m
[32m+[m[32m                "copy.com",[m
[32m+[m[32m                "dropbox",[m
[32m+[m[32m                "file systems",[m
[32m+[m[32m                "files",[m
[32m+[m[32m                "filesystem",[m
[32m+[m[32m                "filesystems",[m
[32m+[m[32m                "ftp",[m
[32m+[m[32m                "rackspace",[m
[32m+[m[32m                "remote",[m
[32m+[m[32m                "s3",[m
[32m+[m[32m                "sftp",[m
[32m+[m[32m                "storage"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/thephpleague/flysystem/issues",[m
[32m+[m[32m                "source": "https://github.com/thephpleague/flysystem/tree/1.x"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://offset.earth/frankdejonge",[m
[32m+[m[32m                    "type": "other"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-08-23T07:39:11+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "league/mime-type-detection",[m
[32m+[m[32m            "version": "1.5.1",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/thephpleague/mime-type-detection.git",[m
[32m+[m[32m                "reference": "353f66d7555d8a90781f6f5e7091932f9a4250aa"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/thephpleague/mime-type-detection/zipball/353f66d7555d8a90781f6f5e7091932f9a4250aa",[m
[32m+[m[32m                "reference": "353f66d7555d8a90781f6f5e7091932f9a4250aa",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "ext-fileinfo": "*",[m
[32m+[m[32m                "php": "^7.2 || ^8.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "phpstan/phpstan": "^0.12.36",[m
[32m+[m[32m                "phpunit/phpunit": "^8.5.8"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "League\\MimeTypeDetection\\": "src"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Frank de Jonge",[m
[32m+[m[32m                    "email": "info@frankdejonge.nl"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Mime-type detection for Flysystem",[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/thephpleague/mime-type-detection/issues",[m
[32m+[m[32m                "source": "https://github.com/thephpleague/mime-type-detection/tree/1.5.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/frankdejonge",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/league/flysystem",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-10-18T11:50:25+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "league/oauth2-server",[m
[32m+[m[32m            "version": "7.4.0",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/thephpleague/oauth2-server.git",[m
[32m+[m[32m                "reference": "2eb1cf79e59d807d89c256e7ac5e2bf8bdbd4acf"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/thephpleague/oauth2-server/zipball/2eb1cf79e59d807d89c256e7ac5e2bf8bdbd4acf",[m
[32m+[m[32m                "reference": "2eb1cf79e59d807d89c256e7ac5e2bf8bdbd4acf",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "defuse/php-encryption": "^2.1",[m
[32m+[m[32m                "ext-openssl": "*",[m
[32m+[m[32m                "lcobucci/jwt": "^3.2.2",[m
[32m+[m[32m                "league/event": "^2.1",[m
[32m+[m[32m                "php": ">=7.0.0",[m
[32m+[m[32m                "psr/http-message": "^1.0.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "replace": {[m
[32m+[m[32m                "league/oauth2server": "*",[m
[32m+[m[32m                "lncd/oauth2": "*"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "phpstan/phpstan": "^0.9.2",[m
[32m+[m[32m                "phpstan/phpstan-phpunit": "^0.9.4",[m
[32m+[m[32m                "phpstan/phpstan-strict-rules": "^0.9.0",[m
[32m+[m[32m                "phpunit/phpunit": "^6.3 || ^7.0",[m
[32m+[m[32m                "roave/security-advisories": "dev-master",[m
[32m+[m[32m                "zendframework/zend-diactoros": "^1.3.2"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "League\\OAuth2\\Server\\": "src/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Alex Bilbie",[m
[32m+[m[32m                    "email": "hello@alexbilbie.com",[m
[32m+[m[32m                    "homepage": "http://www.alexbilbie.com",[m
[32m+[m[32m                    "role": "Developer"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Andy Millington",[m
[32m+[m[32m                    "email": "andrew@noexceptions.io",[m
[32m+[m[32m                    "homepage": "https://www.noexceptions.io",[m
[32m+[m[32m                    "role": "Developer"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "A lightweight and powerful OAuth 2.0 authorization and resource server library with support for all the core specification grants. This library will allow you to secure your API with OAuth and allow your applications users to approve apps that want to access their data from your API.",[m
[32m+[m[32m            "homepage": "https://oauth2.thephpleague.com/",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "Authentication",[m
[32m+[m[32m                "api",[m
[32m+[m[32m                "auth",[m
[32m+[m[32m                "authorisation",[m
[32m+[m[32m                "authorization",[m
[32m+[m[32m                "oauth",[m
[32m+[m[32m                "oauth 2",[m
[32m+[m[32m                "oauth 2.0",[m
[32m+[m[32m                "oauth2",[m
[32m+[m[32m                "protect",[m
[32m+[m[32m                "resource",[m
[32m+[m[32m                "secure",[m
[32m+[m[32m                "server"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/thephpleague/oauth2-server/issues",[m
[32m+[m[32m                "source": "https://github.com/thephpleague/oauth2-server/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2019-05-05T09:22:01+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "monolog/monolog",[m
[32m+[m[32m            "version": "1.25.5",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/Seldaek/monolog.git",[m
[32m+[m[32m                "reference": "1817faadd1846cd08be9a49e905dc68823bc38c0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/Seldaek/monolog/zipball/1817faadd1846cd08be9a49e905dc68823bc38c0",[m
[32m+[m[32m                "reference": "1817faadd1846cd08be9a49e905dc68823bc38c0",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=5.3.0",[m
[32m+[m[32m                "psr/log": "~1.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "provide": {[m
[32m+[m[32m                "psr/log-implementation": "1.0.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "aws/aws-sdk-php": "^2.4.9 || ^3.0",[m
[32m+[m[32m                "doctrine/couchdb": "~1.0@dev",[m
[32m+[m[32m                "graylog2/gelf-php": "~1.0",[m
[32m+[m[32m                "php-amqplib/php-amqplib": "~2.4",[m
[32m+[m[32m                "php-console/php-console": "^3.1.3",[m
[32m+[m[32m                "php-parallel-lint/php-parallel-lint": "^1.0",[m
[32m+[m[32m                "phpunit/phpunit": "~4.5",[m
[32m+[m[32m                "ruflin/elastica": ">=0.90 <3.0",[m
[32m+[m[32m                "sentry/sentry": "^0.13",[m
[32m+[m[32m                "swiftmailer/swiftmailer": "^5.3|^6.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "aws/aws-sdk-php": "Allow sending log messages to AWS services like DynamoDB",[m
[32m+[m[32m                "doctrine/couchdb": "Allow sending log messages to a CouchDB server",[m
[32m+[m[32m                "ext-amqp": "Allow sending log messages to an AMQP server (1.0+ required)",[m
[32m+[m[32m                "ext-mongo": "Allow sending log messages to a MongoDB server",[m
[32m+[m[32m                "graylog2/gelf-php": "Allow sending log messages to a GrayLog2 server",[m
[32m+[m[32m                "mongodb/mongodb": "Allow sending log messages to a MongoDB server via PHP Driver",[m
[32m+[m[32m                "php-amqplib/php-amqplib": "Allow sending log messages to an AMQP server using php-amqplib",[m
[32m+[m[32m                "php-console/php-console": "Allow sending log messages to Google Chrome",[m
[32m+[m[32m                "rollbar/rollbar": "Allow sending log messages to Rollbar",[m
[32m+[m[32m                "ruflin/elastica": "Allow sending log messages to an Elastic Search server",[m
[32m+[m[32m                "sentry/sentry": "Allow sending log messages to a Sentry server"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "2.0.x-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Monolog\\": "src/Monolog"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Jordi Boggiano",[m
[32m+[m[32m                    "email": "j.boggiano@seld.be",[m
[32m+[m[32m                    "homepage": "http://seld.be"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Sends your logs to files, sockets, inboxes, databases and various web services",[m
[32m+[m[32m            "homepage": "http://github.com/Seldaek/monolog",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "log",[m
[32m+[m[32m                "logging",[m
[32m+[m[32m                "psr-3"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/Seldaek/monolog/issues",[m
[32m+[m[32m                "source": "https://github.com/Seldaek/monolog/tree/1.25.5"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/Seldaek",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/monolog/monolog",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-07-23T08:35:51+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "nesbot/carbon",[m
[32m+[m[32m            "version": "2.41.5",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/briannesbitt/Carbon.git",[m
[32m+[m[32m                "reference": "c4a9caf97cfc53adfc219043bcecf42bc663acee"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/briannesbitt/Carbon/zipball/c4a9caf97cfc53adfc219043bcecf42bc663acee",[m
[32m+[m[32m                "reference": "c4a9caf97cfc53adfc219043bcecf42bc663acee",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "ext-json": "*",[m
[32m+[m[32m                "php": "^7.1.8 || ^8.0",[m
[32m+[m[32m                "symfony/polyfill-mbstring": "^1.0",[m
[32m+[m[32m                "symfony/translation": "^3.4 || ^4.0 || ^5.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "doctrine/orm": "^2.7",[m
[32m+[m[32m                "friendsofphp/php-cs-fixer": "^2.14 || ^3.0",[m
[32m+[m[32m                "kylekatarnls/multi-tester": "^2.0",[m
[32m+[m[32m                "phpmd/phpmd": "^2.9",[m
[32m+[m[32m                "phpstan/extension-installer": "^1.0",[m
[32m+[m[32m                "phpstan/phpstan": "^0.12.35",[m
[32m+[m[32m                "phpunit/phpunit": "^7.5 || ^8.0",[m
[32m+[m[32m                "squizlabs/php_codesniffer": "^3.4"[m
[32m+[m[32m            },[m
[32m+[m[32m            "bin": [[m
[32m+[m[32m                "bin/carbon"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "2.x-dev",[m
[32m+[m[32m                    "dev-3.x": "3.x-dev"[m
[32m+[m[32m                },[m
[32m+[m[32m                "laravel": {[m
[32m+[m[32m                    "providers": [[m
[32m+[m[32m                        "Carbon\\Laravel\\ServiceProvider"[m
[32m+[m[32m                    ][m
[32m+[m[32m                },[m
[32m+[m[32m                "phpstan": {[m
[32m+[m[32m                    "includes": [[m
[32m+[m[32m                        "extension.neon"[m
[32m+[m[32m                    ][m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Carbon\\": "src/Carbon/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Brian Nesbitt",[m
[32m+[m[32m                    "email": "brian@nesbot.com",[m
[32m+[m[32m                    "homepage": "http://nesbot.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "kylekatarnls",[m
[32m+[m[32m                    "homepage": "http://github.com/kylekatarnls"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "An API extension for DateTime that supports 281 different languages.",[m
[32m+[m[32m            "homepage": "http://carbon.nesbot.com",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "date",[m
[32m+[m[32m                "datetime",[m
[32m+[m[32m                "time"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/briannesbitt/Carbon/issues",[m
[32m+[m[32m                "source": "https://github.com/briannesbitt/Carbon"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://opencollective.com/Carbon",[m
[32m+[m[32m                    "type": "open_collective"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/nesbot/carbon",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-10-23T06:02:30+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "nikic/php-parser",[m
[32m+[m[32m            "version": "v4.10.2",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/nikic/PHP-Parser.git",[m
[32m+[m[32m                "reference": "658f1be311a230e0907f5dfe0213742aff0596de"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/nikic/PHP-Parser/zipball/658f1be311a230e0907f5dfe0213742aff0596de",[m
[32m+[m[32m                "reference": "658f1be311a230e0907f5dfe0213742aff0596de",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "ext-tokenizer": "*",[m
[32m+[m[32m                "php": ">=7.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "ircmaxell/php-yacc": "^0.0.7",[m
[32m+[m[32m                "phpunit/phpunit": "^6.5 || ^7.0 || ^8.0 || ^9.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "bin": [[m
[32m+[m[32m                "bin/php-parse"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "4.9-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "PhpParser\\": "lib/PhpParser"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-3-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Nikita Popov"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "A PHP parser written in PHP",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "parser",[m
[32m+[m[32m                "php"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/nikic/PHP-Parser/issues",[m
[32m+[m[32m                "source": "https://github.com/nikic/PHP-Parser/tree/v4.10.2"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2020-09-26T10:30:38+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "opis/closure",[m
[32m+[m[32m            "version": "3.6.0",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/opis/closure.git",[m
[32m+[m[32m                "reference": "c547f8262a5fa9ff507bd06cc394067b83a75085"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/opis/closure/zipball/c547f8262a5fa9ff507bd06cc394067b83a75085",[m
[32m+[m[32m                "reference": "c547f8262a5fa9ff507bd06cc394067b83a75085",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^5.4 || ^7.0 || ^8.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "jeremeamia/superclosure": "^2.0",[m
[32m+[m[32m                "phpunit/phpunit": "^4.0 || ^5.0 || ^6.0 || ^7.0 || ^8.0 || ^9.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "3.6.x-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Opis\\Closure\\": "src/"[m
[32m+[m[32m                },[m
[32m+[m[32m                "files": [[m
[32m+[m[32m                    "functions.php"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Marius Sarca",[m
[32m+[m[32m                    "email": "marius.sarca@gmail.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Sorin Sarca",[m
[32m+[m[32m                    "email": "sarca_sorin@hotmail.com"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "A library that can be used to serialize closures (anonymous functions) and arbitrary objects.",[m
[32m+[m[32m            "homepage": "https://opis.io/closure",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "anonymous functions",[m
[32m+[m[32m                "closure",[m
[32m+[m[32m                "function",[m
[32m+[m[32m                "serializable",[m
[32m+[m[32m                "serialization",[m
[32m+[m[32m                "serialize"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/opis/closure/issues",[m
[32m+[m[32m                "source": "https://github.com/opis/closure/tree/3.6.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2020-10-11T21:42:15+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "paragonie/random_compat",[m
[32m+[m[32m            "version": "v9.99.99",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/paragonie/random_compat.git",[m
[32m+[m[32m                "reference": "84b4dfb120c6f9b4ff7b3685f9b8f1aa365a0c95"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/paragonie/random_compat/zipball/84b4dfb120c6f9b4ff7b3685f9b8f1aa365a0c95",[m
[32m+[m[32m                "reference": "84b4dfb120c6f9b4ff7b3685f9b8f1aa365a0c95",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^7"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "phpunit/phpunit": "4.*|5.*",[m
[32m+[m[32m                "vimeo/psalm": "^1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "ext-libsodium": "Provides a modern crypto API that can be used to generate random bytes."[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Paragon Initiative Enterprises",[m
[32m+[m[32m                    "email": "security@paragonie.com",[m
[32m+[m[32m                    "homepage": "https://paragonie.com"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "PHP 5.x polyfill for random_bytes() and random_int() from PHP 7",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "csprng",[m
[32m+[m[32m                "polyfill",[m
[32m+[m[32m                "pseudorandom",[m
[32m+[m[32m                "random"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "email": "info@paragonie.com",[m
[32m+[m[32m                "issues": "https://github.com/paragonie/random_compat/issues",[m
[32m+[m[32m                "source": "https://github.com/paragonie/random_compat"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2018-07-02T15:55:56+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "phpoption/phpoption",[m
[32m+[m[32m            "version": "1.7.5",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/schmittjoh/php-option.git",[m
[32m+[m[32m                "reference": "994ecccd8f3283ecf5ac33254543eb0ac946d525"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/schmittjoh/php-option/zipball/994ecccd8f3283ecf5ac33254543eb0ac946d525",[m
[32m+[m[32m                "reference": "994ecccd8f3283ecf5ac33254543eb0ac946d525",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^5.5.9 || ^7.0 || ^8.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "bamarni/composer-bin-plugin": "^1.4.1",[m
[32m+[m[32m                "phpunit/phpunit": "^4.8.35 || ^5.7.27 || ^6.5.6 || ^7.0 || ^8.0 || ^9.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "1.7-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "PhpOption\\": "src/PhpOption/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "Apache-2.0"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Johannes M. Schmitt",[m
[32m+[m[32m                    "email": "schmittjoh@gmail.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Graham Campbell",[m
[32m+[m[32m                    "email": "graham@alt-three.com"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Option Type for PHP",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "language",[m
[32m+[m[32m                "option",[m
[32m+[m[32m                "php",[m
[32m+[m[32m                "type"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/schmittjoh/php-option/issues",[m
[32m+[m[32m                "source": "https://github.com/schmittjoh/php-option/tree/1.7.5"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/GrahamCampbell",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/phpoption/phpoption",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-07-20T17:29:33+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "phpseclib/phpseclib",[m
[32m+[m[32m            "version": "2.0.29",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/phpseclib/phpseclib.git",[m
[32m+[m[32m                "reference": "497856a8d997f640b4a516062f84228a772a48a8"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/phpseclib/phpseclib/zipball/497856a8d997f640b4a516062f84228a772a48a8",[m
[32m+[m[32m                "reference": "497856a8d997f640b4a516062f84228a772a48a8",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=5.3.3"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "phing/phing": "~2.7",[m
[32m+[m[32m                "phpunit/phpunit": "^4.8.35|^5.7|^6.0",[m
[32m+[m[32m                "squizlabs/php_codesniffer": "~2.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "ext-gmp": "Install the GMP (GNU Multiple Precision) extension in order to speed up arbitrary precision integer arithmetic operations.",[m
[32m+[m[32m                "ext-libsodium": "SSH2/SFTP can make use of some algorithms provided by the libsodium-php extension.",[m
[32m+[m[32m                "ext-mcrypt": "Install the Mcrypt extension in order to speed up a few other cryptographic operations.",[m
[32m+[m[32m                "ext-openssl": "Install the OpenSSL extension in order to speed up a wide variety of cryptographic operations."[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "files": [[m
[32m+[m[32m                    "phpseclib/bootstrap.php"[m
[32m+[m[32m                ],[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "phpseclib\\": "phpseclib/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Jim Wigginton",[m
[32m+[m[32m                    "email": "terrafrost@php.net",[m
[32m+[m[32m                    "role": "Lead Developer"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Patrick Monnerat",[m
[32m+[m[32m                    "email": "pm@datasphere.ch",[m
[32m+[m[32m                    "role": "Developer"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Andreas Fischer",[m
[32m+[m[32m                    "email": "bantu@phpbb.com",[m
[32m+[m[32m                    "role": "Developer"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Hans-Jürgen Petrich",[m
[32m+[m[32m                    "email": "petrich@tronic-media.com",[m
[32m+[m[32m                    "role": "Developer"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Graham Campbell",[m
[32m+[m[32m                    "email": "graham@alt-three.com",[m
[32m+[m[32m                    "role": "Developer"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "PHP Secure Communications Library - Pure-PHP implementations of RSA, AES, SSH2, SFTP, X.509 etc.",[m
[32m+[m[32m            "homepage": "http://phpseclib.sourceforge.net",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "BigInteger",[m
[32m+[m[32m                "aes",[m
[32m+[m[32m                "asn.1",[m
[32m+[m[32m                "asn1",[m
[32m+[m[32m                "blowfish",[m
[32m+[m[32m                "crypto",[m
[32m+[m[32m                "cryptography",[m
[32m+[m[32m                "encryption",[m
[32m+[m[32m                "rsa",[m
[32m+[m[32m                "security",[m
[32m+[m[32m                "sftp",[m
[32m+[m[32m                "signature",[m
[32m+[m[32m                "signing",[m
[32m+[m[32m                "ssh",[m
[32m+[m[32m                "twofish",[m
[32m+[m[32m                "x.509",[m
[32m+[m[32m                "x509"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/phpseclib/phpseclib/issues",[m
[32m+[m[32m                "source": "https://github.com/phpseclib/phpseclib/tree/2.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/terrafrost",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://www.patreon.com/phpseclib",[m
[32m+[m[32m                    "type": "patreon"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/phpseclib/phpseclib",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-09-08T04:24:43+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "psr/container",[m
[32m+[m[32m            "version": "1.0.0",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/php-fig/container.git",[m
[32m+[m[32m                "reference": "b7ce3b176482dbbc1245ebf52b181af44c2cf55f"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/php-fig/container/zipball/b7ce3b176482dbbc1245ebf52b181af44c2cf55f",[m
[32m+[m[32m                "reference": "b7ce3b176482dbbc1245ebf52b181af44c2cf55f",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=5.3.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "1.0.x-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Psr\\Container\\": "src/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "PHP-FIG",[m
[32m+[m[32m                    "homepage": "http://www.php-fig.org/"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Common Container Interface (PHP FIG PSR-11)",[m
[32m+[m[32m            "homepage": "https://github.com/php-fig/container",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "PSR-11",[m
[32m+[m[32m                "container",[m
[32m+[m[32m                "container-interface",[m
[32m+[m[32m                "container-interop",[m
[32m+[m[32m                "psr"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/php-fig/container/issues",[m
[32m+[m[32m                "source": "https://github.com/php-fig/container/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2017-02-14T16:28:37+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "psr/http-factory",[m
[32m+[m[32m            "version": "1.0.1",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/php-fig/http-factory.git",[m
[32m+[m[32m                "reference": "12ac7fcd07e5b077433f5f2bee95b3a771bf61be"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/php-fig/http-factory/zipball/12ac7fcd07e5b077433f5f2bee95b3a771bf61be",[m
[32m+[m[32m                "reference": "12ac7fcd07e5b077433f5f2bee95b3a771bf61be",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=7.0.0",[m
[32m+[m[32m                "psr/http-message": "^1.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "1.0.x-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Psr\\Http\\Message\\": "src/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "PHP-FIG",[m
[32m+[m[32m                    "homepage": "http://www.php-fig.org/"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Common interfaces for PSR-7 HTTP message factories",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "factory",[m
[32m+[m[32m                "http",[m
[32m+[m[32m                "message",[m
[32m+[m[32m                "psr",[m
[32m+[m[32m                "psr-17",[m
[32m+[m[32m                "psr-7",[m
[32m+[m[32m                "request",[m
[32m+[m[32m                "response"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/php-fig/http-factory/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2019-04-30T12:38:16+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "psr/http-message",[m
[32m+[m[32m            "version": "1.0.1",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/php-fig/http-message.git",[m
[32m+[m[32m                "reference": "f6561bf28d520154e4b0ec72be95418abe6d9363"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/php-fig/http-message/zipball/f6561bf28d520154e4b0ec72be95418abe6d9363",[m
[32m+[m[32m                "reference": "f6561bf28d520154e4b0ec72be95418abe6d9363",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=5.3.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "1.0.x-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Psr\\Http\\Message\\": "src/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "PHP-FIG",[m
[32m+[m[32m                    "homepage": "http://www.php-fig.org/"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Common interface for HTTP messages",[m
[32m+[m[32m            "homepage": "https://github.com/php-fig/http-message",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "http",[m
[32m+[m[32m                "http-message",[m
[32m+[m[32m                "psr",[m
[32m+[m[32m                "psr-7",[m
[32m+[m[32m                "request",[m
[32m+[m[32m                "response"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/php-fig/http-message/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2016-08-06T14:39:51+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "psr/log",[m
[32m+[m[32m            "version": "1.1.3",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/php-fig/log.git",[m
[32m+[m[32m                "reference": "0f73288fd15629204f9d42b7055f72dacbe811fc"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/php-fig/log/zipball/0f73288fd15629204f9d42b7055f72dacbe811fc",[m
[32m+[m[32m                "reference": "0f73288fd15629204f9d42b7055f72dacbe811fc",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=5.3.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "1.1.x-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Psr\\Log\\": "Psr/Log/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "PHP-FIG",[m
[32m+[m[32m                    "homepage": "http://www.php-fig.org/"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Common interface for logging libraries",[m
[32m+[m[32m            "homepage": "https://github.com/php-fig/log",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "log",[m
[32m+[m[32m                "psr",[m
[32m+[m[32m                "psr-3"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/php-fig/log/tree/1.1.3"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2020-03-23T09:12:05+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "psr/simple-cache",[m
[32m+[m[32m            "version": "1.0.1",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/php-fig/simple-cache.git",[m
[32m+[m[32m                "reference": "408d5eafb83c57f6365a3ca330ff23aa4a5fa39b"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/php-fig/simple-cache/zipball/408d5eafb83c57f6365a3ca330ff23aa4a5fa39b",[m
[32m+[m[32m                "reference": "408d5eafb83c57f6365a3ca330ff23aa4a5fa39b",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=5.3.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "1.0.x-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Psr\\SimpleCache\\": "src/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "PHP-FIG",[m
[32m+[m[32m                    "homepage": "http://www.php-fig.org/"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Common interfaces for simple caching",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "cache",[m
[32m+[m[32m                "caching",[m
[32m+[m[32m                "psr",[m
[32m+[m[32m                "psr-16",[m
[32m+[m[32m                "simple-cache"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/php-fig/simple-cache/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2017-10-23T01:57:42+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "psy/psysh",[m
[32m+[m[32m            "version": "v0.9.12",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/bobthecow/psysh.git",[m
[32m+[m[32m                "reference": "90da7f37568aee36b116a030c5f99c915267edd4"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/bobthecow/psysh/zipball/90da7f37568aee36b116a030c5f99c915267edd4",[m
[32m+[m[32m                "reference": "90da7f37568aee36b116a030c5f99c915267edd4",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "dnoegel/php-xdg-base-dir": "0.1.*",[m
[32m+[m[32m                "ext-json": "*",[m
[32m+[m[32m                "ext-tokenizer": "*",[m
[32m+[m[32m                "jakub-onderka/php-console-highlighter": "0.3.*|0.4.*",[m
[32m+[m[32m                "nikic/php-parser": "~1.3|~2.0|~3.0|~4.0",[m
[32m+[m[32m                "php": ">=5.4.0",[m
[32m+[m[32m                "symfony/console": "~2.3.10|^2.4.2|~3.0|~4.0|~5.0",[m
[32m+[m[32m                "symfony/var-dumper": "~2.7|~3.0|~4.0|~5.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "bamarni/composer-bin-plugin": "^1.2",[m
[32m+[m[32m                "hoa/console": "~2.15|~3.16",[m
[32m+[m[32m                "phpunit/phpunit": "~4.8.35|~5.0|~6.0|~7.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "ext-pcntl": "Enabling the PCNTL extension makes PsySH a lot happier :)",[m
[32m+[m[32m                "ext-pdo-sqlite": "The doc command requires SQLite to work.",[m
[32m+[m[32m                "ext-posix": "If you have PCNTL, you'll want the POSIX extension as well.",[m
[32m+[m[32m                "ext-readline": "Enables support for arrow-key history navigation, and showing and manipulating command history.",[m
[32m+[m[32m                "hoa/console": "A pure PHP readline implementation. You'll want this if your PHP install doesn't already support readline or libedit."[m
[32m+[m[32m            },[m
[32m+[m[32m            "bin": [[m
[32m+[m[32m                "bin/psysh"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-develop": "0.9.x-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "files": [[m
[32m+[m[32m                    "src/functions.php"[m
[32m+[m[32m                ],[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Psy\\": "src/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Justin Hileman",[m
[32m+[m[32m                    "email": "justin@justinhileman.info",[m
[32m+[m[32m                    "homepage": "http://justinhileman.com"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "An interactive shell for modern PHP.",[m
[32m+[m[32m            "homepage": "http://psysh.org",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "REPL",[m
[32m+[m[32m                "console",[m
[32m+[m[32m                "interactive",[m
[32m+[m[32m                "shell"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/bobthecow/psysh/issues",[m
[32m+[m[32m                "source": "https://github.com/bobthecow/psysh/tree/v0.9.12"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2019-12-06T14:19:43+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "ralouphie/getallheaders",[m
[32m+[m[32m            "version": "3.0.3",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/ralouphie/getallheaders.git",[m
[32m+[m[32m                "reference": "120b605dfeb996808c31b6477290a714d356e822"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/ralouphie/getallheaders/zipball/120b605dfeb996808c31b6477290a714d356e822",[m
[32m+[m[32m                "reference": "120b605dfeb996808c31b6477290a714d356e822",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=5.6"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "php-coveralls/php-coveralls": "^2.1",[m
[32m+[m[32m                "phpunit/phpunit": "^5 || ^6.5"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "files": [[m
[32m+[m[32m                    "src/getallheaders.php"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Ralph Khattar",[m
[32m+[m[32m                    "email": "ralph.khattar@gmail.com"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "A polyfill for getallheaders.",[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/ralouphie/getallheaders/issues",[m
[32m+[m[32m                "source": "https://github.com/ralouphie/getallheaders/tree/develop"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2019-03-08T08:55:37+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "ramsey/uuid",[m
[32m+[m[32m            "version": "3.9.3",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/ramsey/uuid.git",[m
[32m+[m[32m                "reference": "7e1633a6964b48589b142d60542f9ed31bd37a92"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/ramsey/uuid/zipball/7e1633a6964b48589b142d60542f9ed31bd37a92",[m
[32m+[m[32m                "reference": "7e1633a6964b48589b142d60542f9ed31bd37a92",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "ext-json": "*",[m
[32m+[m[32m                "paragonie/random_compat": "^1 | ^2 | 9.99.99",[m
[32m+[m[32m                "php": "^5.4 | ^7 | ^8",[m
[32m+[m[32m                "symfony/polyfill-ctype": "^1.8"[m
[32m+[m[32m            },[m
[32m+[m[32m            "replace": {[m
[32m+[m[32m                "rhumsaa/uuid": "self.version"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "codeception/aspect-mock": "^1 | ^2",[m
[32m+[m[32m                "doctrine/annotations": "^1.2",[m
[32m+[m[32m                "goaop/framework": "1.0.0-alpha.2 | ^1 | ^2.1",[m
[32m+[m[32m                "jakub-onderka/php-parallel-lint": "^1",[m
[32m+[m[32m                "mockery/mockery": "^0.9.11 | ^1",[m
[32m+[m[32m                "moontoast/math": "^1.1",[m
[32m+[m[32m                "paragonie/random-lib": "^2",[m
[32m+[m[32m                "php-mock/php-mock-phpunit": "^0.3 | ^1.1",[m
[32m+[m[32m                "phpunit/phpunit": "^4.8 | ^5.4 | ^6.5",[m
[32m+[m[32m                "squizlabs/php_codesniffer": "^3.5"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "ext-ctype": "Provides support for PHP Ctype functions",[m
[32m+[m[32m                "ext-libsodium": "Provides the PECL libsodium extension for use with the SodiumRandomGenerator",[m
[32m+[m[32m                "ext-openssl": "Provides the OpenSSL extension for use with the OpenSslGenerator",[m
[32m+[m[32m                "ext-uuid": "Provides the PECL UUID extension for use with the PeclUuidTimeGenerator and PeclUuidRandomGenerator",[m
[32m+[m[32m                "moontoast/math": "Provides support for converting UUID to 128-bit integer (in string form).",[m
[32m+[m[32m                "paragonie/random-lib": "Provides RandomLib for use with the RandomLibAdapter",[m
[32m+[m[32m                "ramsey/uuid-console": "A console application for generating UUIDs with ramsey/uuid",[m
[32m+[m[32m                "ramsey/uuid-doctrine": "Allows the use of Ramsey\\Uuid\\Uuid as Doctrine field type."[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "3.x-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Ramsey\\Uuid\\": "src/"[m
[32m+[m[32m                },[m
[32m+[m[32m                "files": [[m
[32m+[m[32m                    "src/functions.php"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Ben Ramsey",[m
[32m+[m[32m                    "email": "ben@benramsey.com",[m
[32m+[m[32m                    "homepage": "https://benramsey.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Marijn Huizendveld",[m
[32m+[m[32m                    "email": "marijn.huizendveld@gmail.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Thibaud Fabre",[m
[32m+[m[32m                    "email": "thibaud@aztech.io"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Formerly rhumsaa/uuid. A PHP 5.4+ library for generating RFC 4122 version 1, 3, 4, and 5 universally unique identifiers (UUID).",[m
[32m+[m[32m            "homepage": "https://github.com/ramsey/uuid",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "guid",[m
[32m+[m[32m                "identifier",[m
[32m+[m[32m                "uuid"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/ramsey/uuid/issues",[m
[32m+[m[32m                "rss": "https://github.com/ramsey/uuid/releases.atom",[m
[32m+[m[32m                "source": "https://github.com/ramsey/uuid",[m
[32m+[m[32m                "wiki": "https://github.com/ramsey/uuid/wiki"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2020-02-21T04:36:14+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "swiftmailer/swiftmailer",[m
[32m+[m[32m            "version": "v6.2.3",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/swiftmailer/swiftmailer.git",[m
[32m+[m[32m                "reference": "149cfdf118b169f7840bbe3ef0d4bc795d1780c9"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/swiftmailer/swiftmailer/zipball/149cfdf118b169f7840bbe3ef0d4bc795d1780c9",[m
[32m+[m[32m                "reference": "149cfdf118b169f7840bbe3ef0d4bc795d1780c9",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "egulias/email-validator": "~2.0",[m
[32m+[m[32m                "php": ">=7.0.0",[m
[32m+[m[32m                "symfony/polyfill-iconv": "^1.0",[m
[32m+[m[32m                "symfony/polyfill-intl-idn": "^1.10",[m
[32m+[m[32m                "symfony/polyfill-mbstring": "^1.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "mockery/mockery": "~0.9.1",[m
[32m+[m[32m                "symfony/phpunit-bridge": "^3.4.19|^4.1.8"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "ext-intl": "Needed to support internationalized email addresses",[m
[32m+[m[32m                "true/punycode": "Needed to support internationalized email addresses, if ext-intl is not installed"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "6.2-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "files": [[m
[32m+[m[32m                    "lib/swift_required.php"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Chris Corbyn"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Fabien Potencier",[m
[32m+[m[32m                    "email": "fabien@symfony.com"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Swiftmailer, free feature-rich PHP mailer",[m
[32m+[m[32m            "homepage": "https://swiftmailer.symfony.com",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "email",[m
[32m+[m[32m                "mail",[m
[32m+[m[32m                "mailer"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/swiftmailer/swiftmailer/issues",[m
[32m+[m[32m                "source": "https://github.com/swiftmailer/swiftmailer/tree/v6.2.3"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2019-11-12T09:31:26+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "symfony/console",[m
[32m+[m[32m            "version": "v4.4.16",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/symfony/console.git",[m
[32m+[m[32m                "reference": "20f73dd143a5815d475e0838ff867bce1eebd9d5"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/symfony/console/zipball/20f73dd143a5815d475e0838ff867bce1eebd9d5",[m
[32m+[m[32m                "reference": "20f73dd143a5815d475e0838ff867bce1eebd9d5",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=7.1.3",[m
[32m+[m[32m                "symfony/polyfill-mbstring": "~1.0",[m
[32m+[m[32m                "symfony/polyfill-php73": "^1.8",[m
[32m+[m[32m                "symfony/polyfill-php80": "^1.15",[m
[32m+[m[32m                "symfony/service-contracts": "^1.1|^2"[m
[32m+[m[32m            },[m
[32m+[m[32m            "conflict": {[m
[32m+[m[32m                "symfony/dependency-injection": "<3.4",[m
[32m+[m[32m                "symfony/event-dispatcher": "<4.3|>=5",[m
[32m+[m[32m                "symfony/lock": "<4.4",[m
[32m+[m[32m                "symfony/process": "<3.3"[m
[32m+[m[32m            },[m
[32m+[m[32m            "provide": {[m
[32m+[m[32m                "psr/log-implementation": "1.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "psr/log": "~1.0",[m
[32m+[m[32m                "symfony/config": "^3.4|^4.0|^5.0",[m
[32m+[m[32m                "symfony/dependency-injection": "^3.4|^4.0|^5.0",[m
[32m+[m[32m                "symfony/event-dispatcher": "^4.3",[m
[32m+[m[32m                "symfony/lock": "^4.4|^5.0",[m
[32m+[m[32m                "symfony/process": "^3.4|^4.0|^5.0",[m
[32m+[m[32m                "symfony/var-dumper": "^4.3|^5.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "psr/log": "For using the console logger",[m
[32m+[m[32m                "symfony/event-dispatcher": "",[m
[32m+[m[32m                "symfony/lock": "",[m
[32m+[m[32m                "symfony/process": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Symfony\\Component\\Console\\": ""[m
[32m+[m[32m                },[m
[32m+[m[32m                "exclude-from-classmap": [[m
[32m+[m[32m                    "/Tests/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Fabien Potencier",[m
[32m+[m[32m                    "email": "fabien@symfony.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Symfony Community",[m
[32m+[m[32m                    "homepage": "https://symfony.com/contributors"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Symfony Console Component",[m
[32m+[m[32m            "homepage": "https://symfony.com",[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/symfony/console/tree/v4.4.16"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://symfony.com/sponsor",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/fabpot",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/symfony/symfony",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-10-24T11:50:19+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "symfony/css-selector",[m
[32m+[m[32m            "version": "v5.1.8",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/symfony/css-selector.git",[m
[32m+[m[32m                "reference": "6cbebda22ffc0d4bb8fea0c1311c2ca54c4c8fa0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/symfony/css-selector/zipball/6cbebda22ffc0d4bb8fea0c1311c2ca54c4c8fa0",[m
[32m+[m[32m                "reference": "6cbebda22ffc0d4bb8fea0c1311c2ca54c4c8fa0",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=7.2.5"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Symfony\\Component\\CssSelector\\": ""[m
[32m+[m[32m                },[m
[32m+[m[32m                "exclude-from-classmap": [[m
[32m+[m[32m                    "/Tests/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Fabien Potencier",[m
[32m+[m[32m                    "email": "fabien@symfony.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Jean-François Simon",[m
[32m+[m[32m                    "email": "jeanfrancois.simon@sensiolabs.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Symfony Community",[m
[32m+[m[32m                    "homepage": "https://symfony.com/contributors"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Symfony CssSelector Component",[m
[32m+[m[32m            "homepage": "https://symfony.com",[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/symfony/css-selector/tree/v5.1.8"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://symfony.com/sponsor",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/fabpot",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/symfony/symfony",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-10-24T12:01:57+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "symfony/debug",[m
[32m+[m[32m            "version": "v4.4.16",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/symfony/debug.git",[m
[32m+[m[32m                "reference": "c87adf3fc1cd0bf4758316a3a150d50a8f957ef4"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/symfony/debug/zipball/c87adf3fc1cd0bf4758316a3a150d50a8f957ef4",[m
[32m+[m[32m                "reference": "c87adf3fc1cd0bf4758316a3a150d50a8f957ef4",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=7.1.3",[m
[32m+[m[32m                "psr/log": "~1.0",[m
[32m+[m[32m                "symfony/polyfill-php80": "^1.15"[m
[32m+[m[32m            },[m
[32m+[m[32m            "conflict": {[m
[32m+[m[32m                "symfony/http-kernel": "<3.4"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "symfony/http-kernel": "^3.4|^4.0|^5.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Symfony\\Component\\Debug\\": ""[m
[32m+[m[32m                },[m
[32m+[m[32m                "exclude-from-classmap": [[m
[32m+[m[32m                    "/Tests/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Fabien Potencier",[m
[32m+[m[32m                    "email": "fabien@symfony.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Symfony Community",[m
[32m+[m[32m                    "homepage": "https://symfony.com/contributors"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Symfony Debug Component",[m
[32m+[m[32m            "homepage": "https://symfony.com",[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/symfony/debug/tree/v4.4.16"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://symfony.com/sponsor",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/fabpot",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/symfony/symfony",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-10-24T11:50:19+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "symfony/error-handler",[m
[32m+[m[32m            "version": "v4.4.16",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/symfony/error-handler.git",[m
[32m+[m[32m                "reference": "363cca01cabf98e4f1c447b14d0a68617f003613"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/symfony/error-handler/zipball/363cca01cabf98e4f1c447b14d0a68617f003613",[m
[32m+[m[32m                "reference": "363cca01cabf98e4f1c447b14d0a68617f003613",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=7.1.3",[m
[32m+[m[32m                "psr/log": "~1.0",[m
[32m+[m[32m                "symfony/debug": "^4.4.5",[m
[32m+[m[32m                "symfony/polyfill-php80": "^1.15",[m
[32m+[m[32m                "symfony/var-dumper": "^4.4|^5.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "symfony/http-kernel": "^4.4|^5.0",[m
[32m+[m[32m                "symfony/serializer": "^4.4|^5.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Symfony\\Component\\ErrorHandler\\": ""[m
[32m+[m[32m                },[m
[32m+[m[32m                "exclude-from-classmap": [[m
[32m+[m[32m                    "/Tests/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Fabien Potencier",[m
[32m+[m[32m                    "email": "fabien@symfony.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Symfony Community",[m
[32m+[m[32m                    "homepage": "https://symfony.com/contributors"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Symfony ErrorHandler Component",[m
[32m+[m[32m            "homepage": "https://symfony.com",[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/symfony/error-handler/tree/v4.4.16"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://symfony.com/sponsor",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/fabpot",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/symfony/symfony",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-10-24T11:50:19+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "symfony/event-dispatcher",[m
[32m+[m[32m            "version": "v4.4.16",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/symfony/event-dispatcher.git",[m
[32m+[m[32m                "reference": "4204f13d2d0b7ad09454f221bb2195fccdf1fe98"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/symfony/event-dispatcher/zipball/4204f13d2d0b7ad09454f221bb2195fccdf1fe98",[m
[32m+[m[32m                "reference": "4204f13d2d0b7ad09454f221bb2195fccdf1fe98",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=7.1.3",[m
[32m+[m[32m                "symfony/event-dispatcher-contracts": "^1.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "conflict": {[m
[32m+[m[32m                "symfony/dependency-injection": "<3.4"[m
[32m+[m[32m            },[m
[32m+[m[32m            "provide": {[m
[32m+[m[32m                "psr/event-dispatcher-implementation": "1.0",[m
[32m+[m[32m                "symfony/event-dispatcher-implementation": "1.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "psr/log": "~1.0",[m
[32m+[m[32m                "symfony/config": "^3.4|^4.0|^5.0",[m
[32m+[m[32m                "symfony/dependency-injection": "^3.4|^4.0|^5.0",[m
[32m+[m[32m                "symfony/error-handler": "~3.4|~4.4",[m
[32m+[m[32m                "symfony/expression-language": "^3.4|^4.0|^5.0",[m
[32m+[m[32m                "symfony/http-foundation": "^3.4|^4.0|^5.0",[m
[32m+[m[32m                "symfony/service-contracts": "^1.1|^2",[m
[32m+[m[32m                "symfony/stopwatch": "^3.4|^4.0|^5.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "symfony/dependency-injection": "",[m
[32m+[m[32m                "symfony/http-kernel": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Symfony\\Component\\EventDispatcher\\": ""[m
[32m+[m[32m                },[m
[32m+[m[32m                "exclude-from-classmap": [[m
[32m+[m[32m                    "/Tests/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Fabien Potencier",[m
[32m+[m[32m                    "email": "fabien@symfony.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Symfony Community",[m
[32m+[m[32m                    "homepage": "https://symfony.com/contributors"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Symfony EventDispatcher Component",[m
[32m+[m[32m            "homepage": "https://symfony.com",[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/symfony/event-dispatcher/tree/v4.4.16"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://symfony.com/sponsor",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/fabpot",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/symfony/symfony",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-10-24T11:50:19+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "symfony/event-dispatcher-contracts",[m
[32m+[m[32m            "version": "v1.1.9",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/symfony/event-dispatcher-contracts.git",[m
[32m+[m[32m                "reference": "84e23fdcd2517bf37aecbd16967e83f0caee25a7"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/symfony/event-dispatcher-contracts/zipball/84e23fdcd2517bf37aecbd16967e83f0caee25a7",[m
[32m+[m[32m                "reference": "84e23fdcd2517bf37aecbd16967e83f0caee25a7",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=7.1.3"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "psr/event-dispatcher": "",[m
[32m+[m[32m                "symfony/event-dispatcher-implementation": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "1.1-dev"[m
[32m+[m[32m                },[m
[32m+[m[32m                "thanks": {[m
[32m+[m[32m                    "name": "symfony/contracts",[m
[32m+[m[32m                    "url": "https://github.com/symfony/contracts"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Symfony\\Contracts\\EventDispatcher\\": ""[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Nicolas Grekas",[m
[32m+[m[32m                    "email": "p@tchwork.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Symfony Community",[m
[32m+[m[32m                    "homepage": "https://symfony.com/contributors"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Generic abstractions related to dispatching event",[m
[32m+[m[32m            "homepage": "https://symfony.com",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "abstractions",[m
[32m+[m[32m                "contracts",[m
[32m+[m[32m                "decoupling",[m
[32m+[m[32m                "interfaces",[m
[32m+[m[32m                "interoperability",[m
[32m+[m[32m                "standards"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/symfony/event-dispatcher-contracts/tree/v1.1.9"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://symfony.com/sponsor",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/fabpot",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/symfony/symfony",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-07-06T13:19:58+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "symfony/finder",[m
[32m+[m[32m            "version": "v4.4.16",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/symfony/finder.git",[m
[32m+[m[32m                "reference": "26f63b8d4e92f2eecd90f6791a563ebb001abe31"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/symfony/finder/zipball/26f63b8d4e92f2eecd90f6791a563ebb001abe31",[m
[32m+[m[32m                "reference": "26f63b8d4e92f2eecd90f6791a563ebb001abe31",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=7.1.3"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Symfony\\Component\\Finder\\": ""[m
[32m+[m[32m                },[m
[32m+[m[32m                "exclude-from-classmap": [[m
[32m+[m[32m                    "/Tests/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Fabien Potencier",[m
[32m+[m[32m                    "email": "fabien@symfony.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Symfony Community",[m
[32m+[m[32m                    "homepage": "https://symfony.com/contributors"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Symfony Finder Component",[m
[32m+[m[32m            "homepage": "https://symfony.com",[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/symfony/finder/tree/v4.4.16"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://symfony.com/sponsor",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/fabpot",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/symfony/symfony",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-10-24T11:50:19+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "symfony/http-client-contracts",[m
[32m+[m[32m            "version": "v2.3.1",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/symfony/http-client-contracts.git",[m
[32m+[m[32m                "reference": "41db680a15018f9c1d4b23516059633ce280ca33"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/symfony/http-client-contracts/zipball/41db680a15018f9c1d4b23516059633ce280ca33",[m
[32m+[m[32m                "reference": "41db680a15018f9c1d4b23516059633ce280ca33",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=7.2.5"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "symfony/http-client-implementation": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-version": "2.3",[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-main": "2.3-dev"[m
[32m+[m[32m                },[m
[32m+[m[32m                "thanks": {[m
[32m+[m[32m                    "name": "symfony/contracts",[m
[32m+[m[32m                    "url": "https://github.com/symfony/contracts"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Symfony\\Contracts\\HttpClient\\": ""[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Nicolas Grekas",[m
[32m+[m[32m                    "email": "p@tchwork.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Symfony Community",[m
[32m+[m[32m                    "homepage": "https://symfony.com/contributors"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Generic abstractions related to HTTP clients",[m
[32m+[m[32m            "homepage": "https://symfony.com",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "abstractions",[m
[32m+[m[32m                "contracts",[m
[32m+[m[32m                "decoupling",[m
[32m+[m[32m                "interfaces",[m
[32m+[m[32m                "interoperability",[m
[32m+[m[32m                "standards"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/symfony/http-client-contracts/tree/v2.3.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://symfony.com/sponsor",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/fabpot",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/symfony/symfony",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-10-14T17:08:19+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "symfony/http-foundation",[m
[32m+[m[32m            "version": "v4.4.16",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/symfony/http-foundation.git",[m
[32m+[m[32m                "reference": "827a00811ef699e809a201ceafac0b2b246bf38a"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/symfony/http-foundation/zipball/827a00811ef699e809a201ceafac0b2b246bf38a",[m
[32m+[m[32m                "reference": "827a00811ef699e809a201ceafac0b2b246bf38a",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=7.1.3",[m
[32m+[m[32m                "symfony/mime": "^4.3|^5.0",[m
[32m+[m[32m                "symfony/polyfill-mbstring": "~1.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "predis/predis": "~1.0",[m
[32m+[m[32m                "symfony/expression-language": "^3.4|^4.0|^5.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Symfony\\Component\\HttpFoundation\\": ""[m
[32m+[m[32m                },[m
[32m+[m[32m                "exclude-from-classmap": [[m
[32m+[m[32m                    "/Tests/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Fabien Potencier",[m
[32m+[m[32m                    "email": "fabien@symfony.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Symfony Community",[m
[32m+[m[32m                    "homepage": "https://symfony.com/contributors"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Symfony HttpFoundation Component",[m
[32m+[m[32m            "homepage": "https://symfony.com",[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/symfony/http-foundation/tree/v4.4.16"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://symfony.com/sponsor",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/fabpot",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/symfony/symfony",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-10-24T11:50:19+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "symfony/http-kernel",[m
[32m+[m[32m            "version": "v4.4.16",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/symfony/http-kernel.git",[m
[32m+[m[32m                "reference": "109b2a46e470a487ec8b0ffea4b0bb993aaf42ed"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/symfony/http-kernel/zipball/109b2a46e470a487ec8b0ffea4b0bb993aaf42ed",[m
[32m+[m[32m                "reference": "109b2a46e470a487ec8b0ffea4b0bb993aaf42ed",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=7.1.3",[m
[32m+[m[32m                "psr/log": "~1.0",[m
[32m+[m[32m                "symfony/error-handler": "^4.4",[m
[32m+[m[32m                "symfony/event-dispatcher": "^4.4",[m
[32m+[m[32m                "symfony/http-client-contracts": "^1.1|^2",[m
[32m+[m[32m                "symfony/http-foundation": "^4.4|^5.0",[m
[32m+[m[32m                "symfony/polyfill-ctype": "^1.8",[m
[32m+[m[32m                "symfony/polyfill-php73": "^1.9",[m
[32m+[m[32m                "symfony/polyfill-php80": "^1.15"[m
[32m+[m[32m            },[m
[32m+[m[32m            "conflict": {[m
[32m+[m[32m                "symfony/browser-kit": "<4.3",[m
[32m+[m[32m                "symfony/config": "<3.4",[m
[32m+[m[32m                "symfony/console": ">=5",[m
[32m+[m[32m                "symfony/dependency-injection": "<4.3",[m
[32m+[m[32m                "symfony/translation": "<4.2",[m
[32m+[m[32m                "twig/twig": "<1.34|<2.4,>=2"[m
[32m+[m[32m            },[m
[32m+[m[32m            "provide": {[m
[32m+[m[32m                "psr/log-implementation": "1.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "psr/cache": "~1.0",[m
[32m+[m[32m                "symfony/browser-kit": "^4.3|^5.0",[m
[32m+[m[32m                "symfony/config": "^3.4|^4.0|^5.0",[m
[32m+[m[32m                "symfony/console": "^3.4|^4.0",[m
[32m+[m[32m                "symfony/css-selector": "^3.4|^4.0|^5.0",[m
[32m+[m[32m                "symfony/dependency-injection": "^4.3|^5.0",[m
[32m+[m[32m                "symfony/dom-crawler": "^3.4|^4.0|^5.0",[m
[32m+[m[32m                "symfony/expression-language": "^3.4|^4.0|^5.0",[m
[32m+[m[32m                "symfony/finder": "^3.4|^4.0|^5.0",[m
[32m+[m[32m                "symfony/process": "^3.4|^4.0|^5.0",[m
[32m+[m[32m                "symfony/routing": "^3.4|^4.0|^5.0",[m
[32m+[m[32m                "symfony/stopwatch": "^3.4|^4.0|^5.0",[m
[32m+[m[32m                "symfony/templating": "^3.4|^4.0|^5.0",[m
[32m+[m[32m                "symfony/translation": "^4.2|^5.0",[m
[32m+[m[32m                "symfony/translation-contracts": "^1.1|^2",[m
[32m+[m[32m                "twig/twig": "^1.34|^2.4|^3.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "symfony/browser-kit": "",[m
[32m+[m[32m                "symfony/config": "",[m
[32m+[m[32m                "symfony/console": "",[m
[32m+[m[32m                "symfony/dependency-injection": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Symfony\\Component\\HttpKernel\\": ""[m
[32m+[m[32m                },[m
[32m+[m[32m                "exclude-from-classmap": [[m
[32m+[m[32m                    "/Tests/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Fabien Potencier",[m
[32m+[m[32m                    "email": "fabien@symfony.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Symfony Community",[m
[32m+[m[32m                    "homepage": "https://symfony.com/contributors"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Symfony HttpKernel Component",[m
[32m+[m[32m            "homepage": "https://symfony.com",[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/symfony/http-kernel/tree/v4.4.16"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://symfony.com/sponsor",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/fabpot",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/symfony/symfony",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-10-28T05:50:56+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "symfony/mime",[m
[32m+[m[32m            "version": "v5.1.8",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/symfony/mime.git",[m
[32m+[m[32m                "reference": "f5485a92c24d4bcfc2f3fc648744fb398482ff1b"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/symfony/mime/zipball/f5485a92c24d4bcfc2f3fc648744fb398482ff1b",[m
[32m+[m[32m                "reference": "f5485a92c24d4bcfc2f3fc648744fb398482ff1b",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=7.2.5",[m
[32m+[m[32m                "symfony/polyfill-intl-idn": "^1.10",[m
[32m+[m[32m                "symfony/polyfill-mbstring": "^1.0",[m
[32m+[m[32m                "symfony/polyfill-php80": "^1.15"[m
[32m+[m[32m            },[m
[32m+[m[32m            "conflict": {[m
[32m+[m[32m                "symfony/mailer": "<4.4"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "egulias/email-validator": "^2.1.10",[m
[32m+[m[32m                "symfony/dependency-injection": "^4.4|^5.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Symfony\\Component\\Mime\\": ""[m
[32m+[m[32m                },[m
[32m+[m[32m                "exclude-from-classmap": [[m
[32m+[m[32m                    "/Tests/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Fabien Potencier",[m
[32m+[m[32m                    "email": "fabien@symfony.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Symfony Community",[m
[32m+[m[32m                    "homepage": "https://symfony.com/contributors"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "A library to manipulate MIME messages",[m
[32m+[m[32m            "homepage": "https://symfony.com",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "mime",[m
[32m+[m[32m                "mime-type"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/symfony/mime/tree/v5.1.8"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://symfony.com/sponsor",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/fabpot",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/symfony/symfony",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-10-24T12:01:57+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "symfony/polyfill-ctype",[m
[32m+[m[32m            "version": "v1.20.0",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/symfony/polyfill-ctype.git",[m
[32m+[m[32m                "reference": "f4ba089a5b6366e453971d3aad5fe8e897b37f41"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/symfony/polyfill-ctype/zipball/f4ba089a5b6366e453971d3aad5fe8e897b37f41",[m
[32m+[m[32m                "reference": "f4ba089a5b6366e453971d3aad5fe8e897b37f41",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=7.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "ext-ctype": "For best performance"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-main": "1.20-dev"[m
[32m+[m[32m                },[m
[32m+[m[32m                "thanks": {[m
[32m+[m[32m                    "name": "symfony/polyfill",[m
[32m+[m[32m                    "url": "https://github.com/symfony/polyfill"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Symfony\\Polyfill\\Ctype\\": ""[m
[32m+[m[32m                },[m
[32m+[m[32m                "files": [[m
[32m+[m[32m                    "bootstrap.php"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Gert de Pagter",[m
[32m+[m[32m                    "email": "BackEndTea@gmail.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Symfony Community",[m
[32m+[m[32m                    "homepage": "https://symfony.com/contributors"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Symfony polyfill for ctype functions",[m
[32m+[m[32m            "homepage": "https://symfony.com",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "compatibility",[m
[32m+[m[32m                "ctype",[m
[32m+[m[32m                "polyfill",[m
[32m+[m[32m                "portable"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/symfony/polyfill-ctype/tree/v1.20.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://symfony.com/sponsor",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/fabpot",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/symfony/symfony",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-10-23T14:02:19+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "symfony/polyfill-iconv",[m
[32m+[m[32m            "version": "v1.20.0",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/symfony/polyfill-iconv.git",[m
[32m+[m[32m                "reference": "c536646fdb4f29104dd26effc2fdcb9a5b085024"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/symfony/polyfill-iconv/zipball/c536646fdb4f29104dd26effc2fdcb9a5b085024",[m
[32m+[m[32m                "reference": "c536646fdb4f29104dd26effc2fdcb9a5b085024",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=7.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "ext-iconv": "For best performance"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-main": "1.20-dev"[m
[32m+[m[32m                },[m
[32m+[m[32m                "thanks": {[m
[32m+[m[32m                    "name": "symfony/polyfill",[m
[32m+[m[32m                    "url": "https://github.com/symfony/polyfill"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Symfony\\Polyfill\\Iconv\\": ""[m
[32m+[m[32m                },[m
[32m+[m[32m                "files": [[m
[32m+[m[32m                    "bootstrap.php"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Nicolas Grekas",[m
[32m+[m[32m                    "email": "p@tchwork.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Symfony Community",[m
[32m+[m[32m                    "homepage": "https://symfony.com/contributors"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Symfony polyfill for the Iconv extension",[m
[32m+[m[32m            "homepage": "https://symfony.com",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "compatibility",[m
[32m+[m[32m                "iconv",[m
[32m+[m[32m                "polyfill",[m
[32m+[m[32m                "portable",[m
[32m+[m[32m                "shim"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/symfony/polyfill-iconv/tree/v1.20.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://symfony.com/sponsor",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/fabpot",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/symfony/symfony",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-10-23T14:02:19+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "symfony/polyfill-intl-idn",[m
[32m+[m[32m            "version": "v1.20.0",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/symfony/polyfill-intl-idn.git",[m
[32m+[m[32m                "reference": "3b75acd829741c768bc8b1f84eb33265e7cc5117"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/symfony/polyfill-intl-idn/zipball/3b75acd829741c768bc8b1f84eb33265e7cc5117",[m
[32m+[m[32m                "reference": "3b75acd829741c768bc8b1f84eb33265e7cc5117",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=7.1",[m
[32m+[m[32m                "symfony/polyfill-intl-normalizer": "^1.10",[m
[32m+[m[32m                "symfony/polyfill-php72": "^1.10"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "ext-intl": "For best performance"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-main": "1.20-dev"[m
[32m+[m[32m                },[m
[32m+[m[32m                "thanks": {[m
[32m+[m[32m                    "name": "symfony/polyfill",[m
[32m+[m[32m                    "url": "https://github.com/symfony/polyfill"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Symfony\\Polyfill\\Intl\\Idn\\": ""[m
[32m+[m[32m                },[m
[32m+[m[32m                "files": [[m
[32m+[m[32m                    "bootstrap.php"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Laurent Bassin",[m
[32m+[m[32m                    "email": "laurent@bassin.info"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Trevor Rowbotham",[m
[32m+[m[32m                    "email": "trevor.rowbotham@pm.me"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Symfony Community",[m
[32m+[m[32m                    "homepage": "https://symfony.com/contributors"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Symfony polyfill for intl's idn_to_ascii and idn_to_utf8 functions",[m
[32m+[m[32m            "homepage": "https://symfony.com",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "compatibility",[m
[32m+[m[32m                "idn",[m
[32m+[m[32m                "intl",[m
[32m+[m[32m                "polyfill",[m
[32m+[m[32m                "portable",[m
[32m+[m[32m                "shim"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/symfony/polyfill-intl-idn/tree/v1.20.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://symfony.com/sponsor",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/fabpot",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/symfony/symfony",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-10-23T14:02:19+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "symfony/polyfill-intl-normalizer",[m
[32m+[m[32m            "version": "v1.20.0",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/symfony/polyfill-intl-normalizer.git",[m
[32m+[m[32m                "reference": "727d1096295d807c309fb01a851577302394c897"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/symfony/polyfill-intl-normalizer/zipball/727d1096295d807c309fb01a851577302394c897",[m
[32m+[m[32m                "reference": "727d1096295d807c309fb01a851577302394c897",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=7.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "ext-intl": "For best performance"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-main": "1.20-dev"[m
[32m+[m[32m                },[m
[32m+[m[32m                "thanks": {[m
[32m+[m[32m                    "name": "symfony/polyfill",[m
[32m+[m[32m                    "url": "https://github.com/symfony/polyfill"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Symfony\\Polyfill\\Intl\\Normalizer\\": ""[m
[32m+[m[32m                },[m
[32m+[m[32m                "files": [[m
[32m+[m[32m                    "bootstrap.php"[m
[32m+[m[32m                ],[m
[32m+[m[32m                "classmap": [[m
[32m+[m[32m                    "Resources/stubs"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Nicolas Grekas",[m
[32m+[m[32m                    "email": "p@tchwork.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Symfony Community",[m
[32m+[m[32m                    "homepage": "https://symfony.com/contributors"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Symfony polyfill for intl's Normalizer class and related functions",[m
[32m+[m[32m            "homepage": "https://symfony.com",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "compatibility",[m
[32m+[m[32m                "intl",[m
[32m+[m[32m                "normalizer",[m
[32m+[m[32m                "polyfill",[m
[32m+[m[32m                "portable",[m
[32m+[m[32m                "shim"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/symfony/polyfill-intl-normalizer/tree/v1.20.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://symfony.com/sponsor",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/fabpot",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/symfony/symfony",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-10-23T14:02:19+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "symfony/polyfill-mbstring",[m
[32m+[m[32m            "version": "v1.20.0",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/symfony/polyfill-mbstring.git",[m
[32m+[m[32m                "reference": "39d483bdf39be819deabf04ec872eb0b2410b531"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/symfony/polyfill-mbstring/zipball/39d483bdf39be819deabf04ec872eb0b2410b531",[m
[32m+[m[32m                "reference": "39d483bdf39be819deabf04ec872eb0b2410b531",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=7.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "ext-mbstring": "For best performance"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-main": "1.20-dev"[m
[32m+[m[32m                },[m
[32m+[m[32m                "thanks": {[m
[32m+[m[32m                    "name": "symfony/polyfill",[m
[32m+[m[32m                    "url": "https://github.com/symfony/polyfill"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Symfony\\Polyfill\\Mbstring\\": ""[m
[32m+[m[32m                },[m
[32m+[m[32m                "files": [[m
[32m+[m[32m                    "bootstrap.php"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Nicolas Grekas",[m
[32m+[m[32m                    "email": "p@tchwork.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Symfony Community",[m
[32m+[m[32m                    "homepage": "https://symfony.com/contributors"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Symfony polyfill for the Mbstring extension",[m
[32m+[m[32m            "homepage": "https://symfony.com",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "compatibility",[m
[32m+[m[32m                "mbstring",[m
[32m+[m[32m                "polyfill",[m
[32m+[m[32m                "portable",[m
[32m+[m[32m                "shim"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/symfony/polyfill-mbstring/tree/v1.20.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://symfony.com/sponsor",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/fabpot",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/symfony/symfony",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-10-23T14:02:19+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "symfony/polyfill-php72",[m
[32m+[m[32m            "version": "v1.20.0",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/symfony/polyfill-php72.git",[m
[32m+[m[32m                "reference": "cede45fcdfabdd6043b3592e83678e42ec69e930"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/symfony/polyfill-php72/zipball/cede45fcdfabdd6043b3592e83678e42ec69e930",[m
[32m+[m[32m                "reference": "cede45fcdfabdd6043b3592e83678e42ec69e930",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=7.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-main": "1.20-dev"[m
[32m+[m[32m                },[m
[32m+[m[32m                "thanks": {[m
[32m+[m[32m                    "name": "symfony/polyfill",[m
[32m+[m[32m                    "url": "https://github.com/symfony/polyfill"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Symfony\\Polyfill\\Php72\\": ""[m
[32m+[m[32m                },[m
[32m+[m[32m                "files": [[m
[32m+[m[32m                    "bootstrap.php"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Nicolas Grekas",[m
[32m+[m[32m                    "email": "p@tchwork.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Symfony Community",[m
[32m+[m[32m                    "homepage": "https://symfony.com/contributors"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Symfony polyfill backporting some PHP 7.2+ features to lower PHP versions",[m
[32m+[m[32m            "homepage": "https://symfony.com",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "compatibility",[m
[32m+[m[32m                "polyfill",[m
[32m+[m[32m                "portable",[m
[32m+[m[32m                "shim"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/symfony/polyfill-php72/tree/v1.20.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://symfony.com/sponsor",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/fabpot",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/symfony/symfony",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-10-23T14:02:19+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "symfony/polyfill-php73",[m
[32m+[m[32m            "version": "v1.20.0",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/symfony/polyfill-php73.git",[m
[32m+[m[32m                "reference": "8ff431c517be11c78c48a39a66d37431e26a6bed"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/symfony/polyfill-php73/zipball/8ff431c517be11c78c48a39a66d37431e26a6bed",[m
[32m+[m[32m                "reference": "8ff431c517be11c78c48a39a66d37431e26a6bed",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=7.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-main": "1.20-dev"[m
[32m+[m[32m                },[m
[32m+[m[32m                "thanks": {[m
[32m+[m[32m                    "name": "symfony/polyfill",[m
[32m+[m[32m                    "url": "https://github.com/symfony/polyfill"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Symfony\\Polyfill\\Php73\\": ""[m
[32m+[m[32m                },[m
[32m+[m[32m                "files": [[m
[32m+[m[32m                    "bootstrap.php"[m
[32m+[m[32m                ],[m
[32m+[m[32m                "classmap": [[m
[32m+[m[32m                    "Resources/stubs"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Nicolas Grekas",[m
[32m+[m[32m                    "email": "p@tchwork.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Symfony Community",[m
[32m+[m[32m                    "homepage": "https://symfony.com/contributors"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Symfony polyfill backporting some PHP 7.3+ features to lower PHP versions",[m
[32m+[m[32m            "homepage": "https://symfony.com",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "compatibility",[m
[32m+[m[32m                "polyfill",[m
[32m+[m[32m                "portable",[m
[32m+[m[32m                "shim"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/symfony/polyfill-php73/tree/v1.20.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://symfony.com/sponsor",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/fabpot",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/symfony/symfony",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-10-23T14:02:19+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "symfony/polyfill-php80",[m
[32m+[m[32m            "version": "v1.20.0",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/symfony/polyfill-php80.git",[m
[32m+[m[32m                "reference": "e70aa8b064c5b72d3df2abd5ab1e90464ad009de"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/symfony/polyfill-php80/zipball/e70aa8b064c5b72d3df2abd5ab1e90464ad009de",[m
[32m+[m[32m                "reference": "e70aa8b064c5b72d3df2abd5ab1e90464ad009de",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=7.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-main": "1.20-dev"[m
[32m+[m[32m                },[m
[32m+[m[32m                "thanks": {[m
[32m+[m[32m                    "name": "symfony/polyfill",[m
[32m+[m[32m                    "url": "https://github.com/symfony/polyfill"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Symfony\\Polyfill\\Php80\\": ""[m
[32m+[m[32m                },[m
[32m+[m[32m                "files": [[m
[32m+[m[32m                    "bootstrap.php"[m
[32m+[m[32m                ],[m
[32m+[m[32m                "classmap": [[m
[32m+[m[32m                    "Resources/stubs"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Ion Bazan",[m
[32m+[m[32m                    "email": "ion.bazan@gmail.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Nicolas Grekas",[m
[32m+[m[32m                    "email": "p@tchwork.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Symfony Community",[m
[32m+[m[32m                    "homepage": "https://symfony.com/contributors"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Symfony polyfill backporting some PHP 8.0+ features to lower PHP versions",[m
[32m+[m[32m            "homepage": "https://symfony.com",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "compatibility",[m
[32m+[m[32m                "polyfill",[m
[32m+[m[32m                "portable",[m
[32m+[m[32m                "shim"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/symfony/polyfill-php80/tree/v1.20.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://symfony.com/sponsor",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/fabpot",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/symfony/symfony",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-10-23T14:02:19+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "symfony/process",[m
[32m+[m[32m            "version": "v4.4.16",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/symfony/process.git",[m
[32m+[m[32m                "reference": "2f4b049fb80ca5e9874615a2a85dc2a502090f05"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/symfony/process/zipball/2f4b049fb80ca5e9874615a2a85dc2a502090f05",[m
[32m+[m[32m                "reference": "2f4b049fb80ca5e9874615a2a85dc2a502090f05",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=7.1.3"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Symfony\\Component\\Process\\": ""[m
[32m+[m[32m                },[m
[32m+[m[32m                "exclude-from-classmap": [[m
[32m+[m[32m                    "/Tests/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Fabien Potencier",[m
[32m+[m[32m                    "email": "fabien@symfony.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Symfony Community",[m
[32m+[m[32m                    "homepage": "https://symfony.com/contributors"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Symfony Process Component",[m
[32m+[m[32m            "homepage": "https://symfony.com",[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/symfony/process/tree/v4.4.16"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://symfony.com/sponsor",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/fabpot",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/symfony/symfony",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-10-24T11:50:19+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "symfony/psr-http-message-bridge",[m
[32m+[m[32m            "version": "v1.3.0",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/symfony/psr-http-message-bridge.git",[m
[32m+[m[32m                "reference": "9d3e80d54d9ae747ad573cad796e8e247df7b796"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/symfony/psr-http-message-bridge/zipball/9d3e80d54d9ae747ad573cad796e8e247df7b796",[m
[32m+[m[32m                "reference": "9d3e80d54d9ae747ad573cad796e8e247df7b796",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^7.1",[m
[32m+[m[32m                "psr/http-message": "^1.0",[m
[32m+[m[32m                "symfony/http-foundation": "^4.4 || ^5.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "nyholm/psr7": "^1.1",[m
[32m+[m[32m                "symfony/phpunit-bridge": "^4.4 || ^5.0",[m
[32m+[m[32m                "zendframework/zend-diactoros": "^1.4.1 || ^2.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "nyholm/psr7": "For a super lightweight PSR-7/17 implementation"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "symfony-bridge",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "1.3-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Symfony\\Bridge\\PsrHttpMessage\\": ""[m
[32m+[m[32m                },[m
[32m+[m[32m                "exclude-from-classmap": [[m
[32m+[m[32m                    "/Tests/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Fabien Potencier",[m
[32m+[m[32m                    "email": "fabien@symfony.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Symfony Community",[m
[32m+[m[32m                    "homepage": "http://symfony.com/contributors"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "PSR HTTP message bridge",[m
[32m+[m[32m            "homepage": "http://symfony.com",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "http",[m
[32m+[m[32m                "http-message",[m
[32m+[m[32m                "psr-17",[m
[32m+[m[32m                "psr-7"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/symfony/psr-http-message-bridge/issues",[m
[32m+[m[32m                "source": "https://github.com/symfony/psr-http-message-bridge/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2019-11-25T19:33:50+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "symfony/routing",[m
[32m+[m[32m            "version": "v4.4.16",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/symfony/routing.git",[m
[32m+[m[32m                "reference": "826794f2e9305fe73cba859c60d2a336851bd202"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/symfony/routing/zipball/826794f2e9305fe73cba859c60d2a336851bd202",[m
[32m+[m[32m                "reference": "826794f2e9305fe73cba859c60d2a336851bd202",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=7.1.3"[m
[32m+[m[32m            },[m
[32m+[m[32m            "conflict": {[m
[32m+[m[32m                "symfony/config": "<4.2",[m
[32m+[m[32m                "symfony/dependency-injection": "<3.4",[m
[32m+[m[32m                "symfony/yaml": "<3.4"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "doctrine/annotations": "~1.2",[m
[32m+[m[32m                "psr/log": "~1.0",[m
[32m+[m[32m                "symfony/config": "^4.2|^5.0",[m
[32m+[m[32m                "symfony/dependency-injection": "^3.4|^4.0|^5.0",[m
[32m+[m[32m                "symfony/expression-language": "^3.4|^4.0|^5.0",[m
[32m+[m[32m                "symfony/http-foundation": "^3.4|^4.0|^5.0",[m
[32m+[m[32m                "symfony/yaml": "^3.4|^4.0|^5.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "doctrine/annotations": "For using the annotation loader",[m
[32m+[m[32m                "symfony/config": "For using the all-in-one router or any loader",[m
[32m+[m[32m                "symfony/expression-language": "For using expression matching",[m
[32m+[m[32m                "symfony/http-foundation": "For using a Symfony Request object",[m
[32m+[m[32m                "symfony/yaml": "For using the YAML loader"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Symfony\\Component\\Routing\\": ""[m
[32m+[m[32m                },[m
[32m+[m[32m                "exclude-from-classmap": [[m
[32m+[m[32m                    "/Tests/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Fabien Potencier",[m
[32m+[m[32m                    "email": "fabien@symfony.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Symfony Community",[m
[32m+[m[32m                    "homepage": "https://symfony.com/contributors"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Symfony Routing Component",[m
[32m+[m[32m            "homepage": "https://symfony.com",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "router",[m
[32m+[m[32m                "routing",[m
[32m+[m[32m                "uri",[m
[32m+[m[32m                "url"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/symfony/routing/tree/v4.4.16"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://symfony.com/sponsor",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/fabpot",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/symfony/symfony",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-10-24T11:50:19+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "symfony/service-contracts",[m
[32m+[m[32m            "version": "v2.2.0",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/symfony/service-contracts.git",[m
[32m+[m[32m                "reference": "d15da7ba4957ffb8f1747218be9e1a121fd298a1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/symfony/service-contracts/zipball/d15da7ba4957ffb8f1747218be9e1a121fd298a1",[m
[32m+[m[32m                "reference": "d15da7ba4957ffb8f1747218be9e1a121fd298a1",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=7.2.5",[m
[32m+[m[32m                "psr/container": "^1.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "symfony/service-implementation": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "2.2-dev"[m
[32m+[m[32m                },[m
[32m+[m[32m                "thanks": {[m
[32m+[m[32m                    "name": "symfony/contracts",[m
[32m+[m[32m                    "url": "https://github.com/symfony/contracts"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Symfony\\Contracts\\Service\\": ""[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Nicolas Grekas",[m
[32m+[m[32m                    "email": "p@tchwork.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Symfony Community",[m
[32m+[m[32m                    "homepage": "https://symfony.com/contributors"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Generic abstractions related to writing services",[m
[32m+[m[32m            "homepage": "https://symfony.com",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "abstractions",[m
[32m+[m[32m                "contracts",[m
[32m+[m[32m                "decoupling",[m
[32m+[m[32m                "interfaces",[m
[32m+[m[32m                "interoperability",[m
[32m+[m[32m                "standards"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/symfony/service-contracts/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://symfony.com/sponsor",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/fabpot",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/symfony/symfony",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-09-07T11:33:47+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "symfony/translation",[m
[32m+[m[32m            "version": "v4.4.16",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/symfony/translation.git",[m
[32m+[m[32m                "reference": "73095716af79f610f3b6338b911357393fdd10ab"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/symfony/translation/zipball/73095716af79f610f3b6338b911357393fdd10ab",[m
[32m+[m[32m                "reference": "73095716af79f610f3b6338b911357393fdd10ab",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=7.1.3",[m
[32m+[m[32m                "symfony/polyfill-mbstring": "~1.0",[m
[32m+[m[32m                "symfony/translation-contracts": "^1.1.6|^2"[m
[32m+[m[32m            },[m
[32m+[m[32m            "conflict": {[m
[32m+[m[32m                "symfony/config": "<3.4",[m
[32m+[m[32m                "symfony/dependency-injection": "<3.4",[m
[32m+[m[32m                "symfony/http-kernel": "<4.4",[m
[32m+[m[32m                "symfony/yaml": "<3.4"[m
[32m+[m[32m            },[m
[32m+[m[32m            "provide": {[m
[32m+[m[32m                "symfony/translation-implementation": "1.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "psr/log": "~1.0",[m
[32m+[m[32m                "symfony/config": "^3.4|^4.0|^5.0",[m
[32m+[m[32m                "symfony/console": "^3.4|^4.0|^5.0",[m
[32m+[m[32m                "symfony/dependency-injection": "^3.4|^4.0|^5.0",[m
[32m+[m[32m                "symfony/finder": "~2.8|~3.0|~4.0|^5.0",[m
[32m+[m[32m                "symfony/http-kernel": "^4.4",[m
[32m+[m[32m                "symfony/intl": "^3.4|^4.0|^5.0",[m
[32m+[m[32m                "symfony/service-contracts": "^1.1.2|^2",[m
[32m+[m[32m                "symfony/yaml": "^3.4|^4.0|^5.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "psr/log-implementation": "To use logging capability in translator",[m
[32m+[m[32m                "symfony/config": "",[m
[32m+[m[32m                "symfony/yaml": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Symfony\\Component\\Translation\\": ""[m
[32m+[m[32m                },[m
[32m+[m[32m                "exclude-from-classmap": [[m
[32m+[m[32m                    "/Tests/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Fabien Potencier",[m
[32m+[m[32m                    "email": "fabien@symfony.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Symfony Community",[m
[32m+[m[32m                    "homepage": "https://symfony.com/contributors"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Symfony Translation Component",[m
[32m+[m[32m            "homepage": "https://symfony.com",[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/symfony/translation/tree/v4.4.16"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://symfony.com/sponsor",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/fabpot",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/symfony/symfony",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-10-24T11:50:19+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "symfony/translation-contracts",[m
[32m+[m[32m            "version": "v2.3.0",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/symfony/translation-contracts.git",[m
[32m+[m[32m                "reference": "e2eaa60b558f26a4b0354e1bbb25636efaaad105"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/symfony/translation-contracts/zipball/e2eaa60b558f26a4b0354e1bbb25636efaaad105",[m
[32m+[m[32m                "reference": "e2eaa60b558f26a4b0354e1bbb25636efaaad105",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=7.2.5"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "symfony/translation-implementation": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "2.3-dev"[m
[32m+[m[32m                },[m
[32m+[m[32m                "thanks": {[m
[32m+[m[32m                    "name": "symfony/contracts",[m
[32m+[m[32m                    "url": "https://github.com/symfony/contracts"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Symfony\\Contracts\\Translation\\": ""[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Nicolas Grekas",[m
[32m+[m[32m                    "email": "p@tchwork.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Symfony Community",[m
[32m+[m[32m                    "homepage": "https://symfony.com/contributors"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Generic abstractions related to translation",[m
[32m+[m[32m            "homepage": "https://symfony.com",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "abstractions",[m
[32m+[m[32m                "contracts",[m
[32m+[m[32m                "decoupling",[m
[32m+[m[32m                "interfaces",[m
[32m+[m[32m                "interoperability",[m
[32m+[m[32m                "standards"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/symfony/translation-contracts/tree/v2.3.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://symfony.com/sponsor",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/fabpot",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/symfony/symfony",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-09-28T13:05:58+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "symfony/var-dumper",[m
[32m+[m[32m            "version": "v4.4.16",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/symfony/var-dumper.git",[m
[32m+[m[32m                "reference": "3718e18b68d955348ad860e505991802c09f5f73"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/symfony/var-dumper/zipball/3718e18b68d955348ad860e505991802c09f5f73",[m
[32m+[m[32m                "reference": "3718e18b68d955348ad860e505991802c09f5f73",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=7.1.3",[m
[32m+[m[32m                "symfony/polyfill-mbstring": "~1.0",[m
[32m+[m[32m                "symfony/polyfill-php72": "~1.5",[m
[32m+[m[32m                "symfony/polyfill-php80": "^1.15"[m
[32m+[m[32m            },[m
[32m+[m[32m            "conflict": {[m
[32m+[m[32m                "phpunit/phpunit": "<4.8.35|<5.4.3,>=5.0",[m
[32m+[m[32m                "symfony/console": "<3.4"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "ext-iconv": "*",[m
[32m+[m[32m                "symfony/console": "^3.4|^4.0|^5.0",[m
[32m+[m[32m                "symfony/process": "^4.4|^5.0",[m
[32m+[m[32m                "twig/twig": "^1.34|^2.4|^3.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "ext-iconv": "To convert non-UTF-8 strings to UTF-8 (or symfony/polyfill-iconv in case ext-iconv cannot be used).",[m
[32m+[m[32m                "ext-intl": "To show region name in time zone dump",[m
[32m+[m[32m                "symfony/console": "To use the ServerDumpCommand and/or the bin/var-dump-server script"[m
[32m+[m[32m            },[m
[32m+[m[32m            "bin": [[m
[32m+[m[32m                "Resources/bin/var-dump-server"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "files": [[m
[32m+[m[32m                    "Resources/functions/dump.php"[m
[32m+[m[32m                ],[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Symfony\\Component\\VarDumper\\": ""[m
[32m+[m[32m                },[m
[32m+[m[32m                "exclude-from-classmap": [[m
[32m+[m[32m                    "/Tests/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Nicolas Grekas",[m
[32m+[m[32m                    "email": "p@tchwork.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Symfony Community",[m
[32m+[m[32m                    "homepage": "https://symfony.com/contributors"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Symfony mechanism for exploring and dumping PHP variables",[m
[32m+[m[32m            "homepage": "https://symfony.com",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "debug",[m
[32m+[m[32m                "dump"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "source": "https://github.com/symfony/var-dumper/tree/v4.4.16"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://symfony.com/sponsor",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/fabpot",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/symfony/symfony",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-10-26T20:47:51+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "tijsverkoyen/css-to-inline-styles",[m
[32m+[m[32m            "version": "2.2.3",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/tijsverkoyen/CssToInlineStyles.git",[m
[32m+[m[32m                "reference": "b43b05cf43c1b6d849478965062b6ef73e223bb5"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/tijsverkoyen/CssToInlineStyles/zipball/b43b05cf43c1b6d849478965062b6ef73e223bb5",[m
[32m+[m[32m                "reference": "b43b05cf43c1b6d849478965062b6ef73e223bb5",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "ext-dom": "*",[m
[32m+[m[32m                "ext-libxml": "*",[m
[32m+[m[32m                "php": "^5.5 || ^7.0 || ^8.0",[m
[32m+[m[32m                "symfony/css-selector": "^2.7 || ^3.0 || ^4.0 || ^5.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "phpunit/phpunit": "^4.8.35 || ^5.7 || ^6.0 || ^7.5"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "2.2.x-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "TijsVerkoyen\\CssToInlineStyles\\": "src"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-3-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Tijs Verkoyen",[m
[32m+[m[32m                    "email": "css_to_inline_styles@verkoyen.eu",[m
[32m+[m[32m                    "role": "Developer"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "CssToInlineStyles is a class that enables you to convert HTML-pages/files into HTML-pages/files with inline styles. This is very useful when you're sending emails.",[m
[32m+[m[32m            "homepage": "https://github.com/tijsverkoyen/CssToInlineStyles",[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/tijsverkoyen/CssToInlineStyles/issues",[m
[32m+[m[32m                "source": "https://github.com/tijsverkoyen/CssToInlineStyles/tree/2.2.3"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2020-07-13T06:12:54+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "vlucas/phpdotenv",[m
[32m+[m[32m            "version": "v3.6.7",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/vlucas/phpdotenv.git",[m
[32m+[m[32m                "reference": "2065beda6cbe75e2603686907b2e45f6f3a5ad82"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/vlucas/phpdotenv/zipball/2065beda6cbe75e2603686907b2e45f6f3a5ad82",[m
[32m+[m[32m                "reference": "2065beda6cbe75e2603686907b2e45f6f3a5ad82",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^5.4 || ^7.0 || ^8.0",[m
[32m+[m[32m                "phpoption/phpoption": "^1.5.2",[m
[32m+[m[32m                "symfony/polyfill-ctype": "^1.17"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "ext-filter": "*",[m
[32m+[m[32m                "ext-pcre": "*",[m
[32m+[m[32m                "phpunit/phpunit": "^4.8.35 || ^5.7.27 || ^6.5.6 || ^7.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "ext-filter": "Required to use the boolean validator.",[m
[32m+[m[32m                "ext-pcre": "Required to use most of the library."[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "3.6-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Dotenv\\": "src/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-3-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Graham Campbell",[m
[32m+[m[32m                    "email": "graham@alt-three.com",[m
[32m+[m[32m                    "homepage": "https://gjcampbell.co.uk/"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Vance Lucas",[m
[32m+[m[32m                    "email": "vance@vancelucas.com",[m
[32m+[m[32m                    "homepage": "https://vancelucas.com/"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Loads environment variables from `.env` to `getenv()`, `$_ENV` and `$_SERVER` automagically.",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "dotenv",[m
[32m+[m[32m                "env",[m
[32m+[m[32m                "environment"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/vlucas/phpdotenv/issues",[m
[32m+[m[32m                "source": "https://github.com/vlucas/phpdotenv/tree/v3.6.7"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/GrahamCampbell",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/vlucas/phpdotenv",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-07-14T19:04:52+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "zendframework/zend-diactoros",[m
[32m+[m[32m            "version": "2.2.1",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/zendframework/zend-diactoros.git",[m
[32m+[m[32m                "reference": "de5847b068362a88684a55b0dbb40d85986cfa52"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/zendframework/zend-diactoros/zipball/de5847b068362a88684a55b0dbb40d85986cfa52",[m
[32m+[m[32m                "reference": "de5847b068362a88684a55b0dbb40d85986cfa52",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^7.1",[m
[32m+[m[32m                "psr/http-factory": "^1.0",[m
[32m+[m[32m                "psr/http-message": "^1.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "provide": {[m
[32m+[m[32m                "psr/http-factory-implementation": "1.0",[m
[32m+[m[32m                "psr/http-message-implementation": "1.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "ext-curl": "*",[m
[32m+[m[32m                "ext-dom": "*",[m
[32m+[m[32m                "ext-libxml": "*",[m
[32m+[m[32m                "http-interop/http-factory-tests": "^0.5.0",[m
[32m+[m[32m                "php-http/psr7-integration-tests": "dev-master",[m
[32m+[m[32m                "phpunit/phpunit": "^7.0.2",[m
[32m+[m[32m                "zendframework/zend-coding-standard": "~1.0.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "2.1.x-dev",[m
[32m+[m[32m                    "dev-develop": "2.2.x-dev",[m
[32m+[m[32m                    "dev-release-1.8": "1.8.x-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "files": [[m
[32m+[m[32m                    "src/functions/create_uploaded_file.php",[m
[32m+[m[32m                    "src/functions/marshal_headers_from_sapi.php",[m
[32m+[m[32m                    "src/functions/marshal_method_from_sapi.php",[m
[32m+[m[32m                    "src/functions/marshal_protocol_version_from_sapi.php",[m
[32m+[m[32m                    "src/functions/marshal_uri_from_sapi.php",[m
[32m+[m[32m                    "src/functions/normalize_server.php",[m
[32m+[m[32m                    "src/functions/normalize_uploaded_files.php",[m
[32m+[m[32m                    "src/functions/parse_cookie_header.php"[m
[32m+[m[32m                ],[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Zend\\Diactoros\\": "src/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-3-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "PSR HTTP Message implementations",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "http",[m
[32m+[m[32m                "psr",[m
[32m+[m[32m                "psr-7"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "docs": "https://docs.zendframework.com/zend-diactoros/",[m
[32m+[m[32m                "forum": "https://discourse.zendframework.com/c/questions/exprssive",[m
[32m+[m[32m                "issues": "https://github.com/zendframework/zend-diactoros/issues",[m
[32m+[m[32m                "rss": "https://github.com/zendframework/zend-diactoros/releases.atom",[m
[32m+[m[32m                "slack": "https://zendframework-slack.herokuapp.com",[m
[32m+[m[32m                "source": "https://github.com/zendframework/zend-diactoros"[m
[32m+[m[32m            },[m
[32m+[m[32m            "abandoned": "laminas/laminas-diactoros",[m
[32m+[m[32m            "time": "2019-11-13T19:16:13+00:00"[m
[32m+[m[32m        }[m
[32m+[m[32m    ],[m
[32m+[m[32m    "packages-dev": [[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "beyondcode/laravel-dump-server",[m
[32m+[m[32m            "version": "1.3.0",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/beyondcode/laravel-dump-server.git",[m
[32m+[m[32m                "reference": "fcc88fa66895f8c1ff83f6145a5eff5fa2a0739a"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/beyondcode/laravel-dump-server/zipball/fcc88fa66895f8c1ff83f6145a5eff5fa2a0739a",[m
[32m+[m[32m                "reference": "fcc88fa66895f8c1ff83f6145a5eff5fa2a0739a",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "illuminate/console": "5.6.*|5.7.*|5.8.*|^6.0",[m
[32m+[m[32m                "illuminate/http": "5.6.*|5.7.*|5.8.*|^6.0",[m
[32m+[m[32m                "illuminate/support": "5.6.*|5.7.*|5.8.*|^6.0",[m
[32m+[m[32m                "php": "^7.1",[m
[32m+[m[32m                "symfony/var-dumper": "^4.1.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "larapack/dd": "^1.0",[m
[32m+[m[32m                "phpunit/phpunit": "^7.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "laravel": {[m
[32m+[m[32m                    "providers": [[m
[32m+[m[32m                        "BeyondCode\\DumpServer\\DumpServerServiceProvider"[m
[32m+[m[32m                    ][m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "BeyondCode\\DumpServer\\": "src"[m
[32m+[m[32m                },[m
[32m+[m[32m                "files": [[m
[32m+[m[32m                    "helpers.php"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Marcel Pociot",[m
[32m+[m[32m                    "email": "marcel@beyondco.de",[m
[32m+[m[32m                    "homepage": "https://beyondco.de",[m
[32m+[m[32m                    "role": "Developer"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Symfony Var-Dump Server for Laravel",[m
[32m+[m[32m            "homepage": "https://github.com/beyondcode/laravel-dump-server",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "beyondcode",[m
[32m+[m[32m                "laravel-dump-server"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/beyondcode/laravel-dump-server/issues",[m
[32m+[m[32m                "source": "https://github.com/beyondcode/laravel-dump-server/tree/1.3.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2019-08-11T13:17:40+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "doctrine/instantiator",[m
[32m+[m[32m            "version": "1.3.1",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/doctrine/instantiator.git",[m
[32m+[m[32m                "reference": "f350df0268e904597e3bd9c4685c53e0e333feea"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/doctrine/instantiator/zipball/f350df0268e904597e3bd9c4685c53e0e333feea",[m
[32m+[m[32m                "reference": "f350df0268e904597e3bd9c4685c53e0e333feea",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^7.1 || ^8.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "doctrine/coding-standard": "^6.0",[m
[32m+[m[32m                "ext-pdo": "*",[m
[32m+[m[32m                "ext-phar": "*",[m
[32m+[m[32m                "phpbench/phpbench": "^0.13",[m
[32m+[m[32m                "phpstan/phpstan-phpunit": "^0.11",[m
[32m+[m[32m                "phpstan/phpstan-shim": "^0.11",[m
[32m+[m[32m                "phpunit/phpunit": "^7.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "1.2.x-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Doctrine\\Instantiator\\": "src/Doctrine/Instantiator/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Marco Pivetta",[m
[32m+[m[32m                    "email": "ocramius@gmail.com",[m
[32m+[m[32m                    "homepage": "http://ocramius.github.com/"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "A small, lightweight utility to instantiate objects in PHP without invoking their constructors",[m
[32m+[m[32m            "homepage": "https://www.doctrine-project.org/projects/instantiator.html",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "constructor",[m
[32m+[m[32m                "instantiate"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/doctrine/instantiator/issues",[m
[32m+[m[32m                "source": "https://github.com/doctrine/instantiator/tree/1.3.x"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://www.doctrine-project.org/sponsorship.html",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://www.patreon.com/phpdoctrine",[m
[32m+[m[32m                    "type": "patreon"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/doctrine%2Finstantiator",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-05-29T17:27:14+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "filp/whoops",[m
[32m+[m[32m            "version": "2.9.1",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/filp/whoops.git",[m
[32m+[m[32m                "reference": "307fb34a5ab697461ec4c9db865b20ff2fd40771"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/filp/whoops/zipball/307fb34a5ab697461ec4c9db865b20ff2fd40771",[m
[32m+[m[32m                "reference": "307fb34a5ab697461ec4c9db865b20ff2fd40771",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^5.5.9 || ^7.0 || ^8.0",[m
[32m+[m[32m                "psr/log": "^1.0.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "mockery/mockery": "^0.9 || ^1.0",[m
[32m+[m[32m                "phpunit/phpunit": "^4.8.36 || ^5.7.27 || ^6.5.14 || ^7.5.20 || ^8.5.8 || ^9.3.3",[m
[32m+[m[32m                "symfony/var-dumper": "^2.6 || ^3.0 || ^4.0 || ^5.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "symfony/var-dumper": "Pretty print complex values better with var-dumper available",[m
[32m+[m[32m                "whoops/soap": "Formats errors as SOAP responses"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "2.7-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Whoops\\": "src/Whoops/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Filipe Dobreira",[m
[32m+[m[32m                    "homepage": "https://github.com/filp",[m
[32m+[m[32m                    "role": "Developer"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "php error handling for cool kids",[m
[32m+[m[32m            "homepage": "https://filp.github.io/whoops/",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "error",[m
[32m+[m[32m                "exception",[m
[32m+[m[32m                "handling",[m
[32m+[m[32m                "library",[m
[32m+[m[32m                "throwable",[m
[32m+[m[32m                "whoops"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/filp/whoops/issues",[m
[32m+[m[32m                "source": "https://github.com/filp/whoops/tree/2.9.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2020-11-01T12:00:00+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "fzaninotto/faker",[m
[32m+[m[32m            "version": "v1.9.1",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/fzaninotto/Faker.git",[m
[32m+[m[32m                "reference": "fc10d778e4b84d5bd315dad194661e091d307c6f"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/fzaninotto/Faker/zipball/fc10d778e4b84d5bd315dad194661e091d307c6f",[m
[32m+[m[32m                "reference": "fc10d778e4b84d5bd315dad194661e091d307c6f",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^5.3.3 || ^7.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "ext-intl": "*",[m
[32m+[m[32m                "phpunit/phpunit": "^4.8.35 || ^5.7",[m
[32m+[m[32m                "squizlabs/php_codesniffer": "^2.9.2"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "1.9-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Faker\\": "src/Faker/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "François Zaninotto"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Faker is a PHP library that generates fake data for you.",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "data",[m
[32m+[m[32m                "faker",[m
[32m+[m[32m                "fixtures"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/fzaninotto/Faker/issues",[m
[32m+[m[32m                "source": "https://github.com/fzaninotto/Faker/tree/v1.9.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "abandoned": true,[m
[32m+[m[32m            "time": "2019-12-12T13:22:17+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "hamcrest/hamcrest-php",[m
[32m+[m[32m            "version": "v2.0.1",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/hamcrest/hamcrest-php.git",[m
[32m+[m[32m                "reference": "8c3d0a3f6af734494ad8f6fbbee0ba92422859f3"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/hamcrest/hamcrest-php/zipball/8c3d0a3f6af734494ad8f6fbbee0ba92422859f3",[m
[32m+[m[32m                "reference": "8c3d0a3f6af734494ad8f6fbbee0ba92422859f3",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^5.3|^7.0|^8.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "replace": {[m
[32m+[m[32m                "cordoval/hamcrest-php": "*",[m
[32m+[m[32m                "davedevelopment/hamcrest-php": "*",[m
[32m+[m[32m                "kodova/hamcrest-php": "*"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "phpunit/php-file-iterator": "^1.4 || ^2.0",[m
[32m+[m[32m                "phpunit/phpunit": "^4.8.36 || ^5.7 || ^6.5 || ^7.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "2.1-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "classmap": [[m
[32m+[m[32m                    "hamcrest"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-3-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "This is the PHP port of Hamcrest Matchers",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "test"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/hamcrest/hamcrest-php/issues",[m
[32m+[m[32m                "source": "https://github.com/hamcrest/hamcrest-php/tree/v2.0.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2020-07-09T08:09:16+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "mockery/mockery",[m
[32m+[m[32m            "version": "1.3.3",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/mockery/mockery.git",[m
[32m+[m[32m                "reference": "60fa2f67f6e4d3634bb4a45ff3171fa52215800d"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/mockery/mockery/zipball/60fa2f67f6e4d3634bb4a45ff3171fa52215800d",[m
[32m+[m[32m                "reference": "60fa2f67f6e4d3634bb4a45ff3171fa52215800d",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "hamcrest/hamcrest-php": "^2.0.1",[m
[32m+[m[32m                "lib-pcre": ">=7.0",[m
[32m+[m[32m                "php": ">=5.6.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "phpunit/phpunit": "^5.7.10|^6.5|^7.5|^8.5|^9.3"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "1.3.x-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-0": {[m
[32m+[m[32m                    "Mockery": "library/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-3-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Pádraic Brady",[m
[32m+[m[32m                    "email": "padraic.brady@gmail.com",[m
[32m+[m[32m                    "homepage": "http://blog.astrumfutura.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Dave Marshall",[m
[32m+[m[32m                    "email": "dave.marshall@atstsolutions.co.uk",[m
[32m+[m[32m                    "homepage": "http://davedevelopment.co.uk"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Mockery is a simple yet flexible PHP mock object framework",[m
[32m+[m[32m            "homepage": "https://github.com/mockery/mockery",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "BDD",[m
[32m+[m[32m                "TDD",[m
[32m+[m[32m                "library",[m
[32m+[m[32m                "mock",[m
[32m+[m[32m                "mock objects",[m
[32m+[m[32m                "mockery",[m
[32m+[m[32m                "stub",[m
[32m+[m[32m                "test",[m
[32m+[m[32m                "test double",[m
[32m+[m[32m                "testing"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/mockery/mockery/issues",[m
[32m+[m[32m                "source": "https://github.com/mockery/mockery/tree/1.3.3"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2020-08-11T18:10:21+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "myclabs/deep-copy",[m
[32m+[m[32m            "version": "1.10.1",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/myclabs/DeepCopy.git",[m
[32m+[m[32m                "reference": "969b211f9a51aa1f6c01d1d2aef56d3bd91598e5"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/myclabs/DeepCopy/zipball/969b211f9a51aa1f6c01d1d2aef56d3bd91598e5",[m
[32m+[m[32m                "reference": "969b211f9a51aa1f6c01d1d2aef56d3bd91598e5",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^7.1 || ^8.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "replace": {[m
[32m+[m[32m                "myclabs/deep-copy": "self.version"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "doctrine/collections": "^1.0",[m
[32m+[m[32m                "doctrine/common": "^2.6",[m
[32m+[m[32m                "phpunit/phpunit": "^7.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "DeepCopy\\": "src/DeepCopy/"[m
[32m+[m[32m                },[m
[32m+[m[32m                "files": [[m
[32m+[m[32m                    "src/DeepCopy/deep_copy.php"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Create deep copies (clones) of your objects",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "clone",[m
[32m+[m[32m                "copy",[m
[32m+[m[32m                "duplicate",[m
[32m+[m[32m                "object",[m
[32m+[m[32m                "object graph"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/myclabs/DeepCopy/issues",[m
[32m+[m[32m                "source": "https://github.com/myclabs/DeepCopy/tree/1.x"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://tidelift.com/funding/github/packagist/myclabs/deep-copy",[m
[32m+[m[32m                    "type": "tidelift"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-06-29T13:22:24+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "nunomaduro/collision",[m
[32m+[m[32m            "version": "v3.1.0",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/nunomaduro/collision.git",[m
[32m+[m[32m                "reference": "88b58b5bd9bdcc54756480fb3ce87234696544ee"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/nunomaduro/collision/zipball/88b58b5bd9bdcc54756480fb3ce87234696544ee",[m
[32m+[m[32m                "reference": "88b58b5bd9bdcc54756480fb3ce87234696544ee",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "filp/whoops": "^2.1.4",[m
[32m+[m[32m                "jakub-onderka/php-console-highlighter": "0.3.*|0.4.*",[m
[32m+[m[32m                "php": "^7.1 || ^8.0",[m
[32m+[m[32m                "symfony/console": "~2.8|~3.3|~4.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "laravel/framework": "^6.0",[m
[32m+[m[32m                "phpunit/phpunit": "^8.0 || ^9.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "laravel": {[m
[32m+[m[32m                    "providers": [[m
[32m+[m[32m                        "NunoMaduro\\Collision\\Adapters\\Laravel\\CollisionServiceProvider"[m
[32m+[m[32m                    ][m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "NunoMaduro\\Collision\\": "src/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Nuno Maduro",[m
[32m+[m[32m                    "email": "enunomaduro@gmail.com"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Cli error handling for console/command-line PHP applications.",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "artisan",[m
[32m+[m[32m                "cli",[m
[32m+[m[32m                "command-line",[m
[32m+[m[32m                "console",[m
[32m+[m[32m                "error",[m
[32m+[m[32m                "handling",[m
[32m+[m[32m                "laravel",[m
[32m+[m[32m                "laravel-zero",[m
[32m+[m[32m                "php",[m
[32m+[m[32m                "symfony"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/nunomaduro/collision/issues",[m
[32m+[m[32m                "source": "https://github.com/nunomaduro/collision"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=66BYDWAT92N6L",[m
[32m+[m[32m                    "type": "custom"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/nunomaduro",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://www.patreon.com/nunomaduro",[m
[32m+[m[32m                    "type": "patreon"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-10-29T16:05:21+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "phar-io/manifest",[m
[32m+[m[32m            "version": "1.0.3",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/phar-io/manifest.git",[m
[32m+[m[32m                "reference": "7761fcacf03b4d4f16e7ccb606d4879ca431fcf4"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/phar-io/manifest/zipball/7761fcacf03b4d4f16e7ccb606d4879ca431fcf4",[m
[32m+[m[32m                "reference": "7761fcacf03b4d4f16e7ccb606d4879ca431fcf4",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "ext-dom": "*",[m
[32m+[m[32m                "ext-phar": "*",[m
[32m+[m[32m                "phar-io/version": "^2.0",[m
[32m+[m[32m                "php": "^5.6 || ^7.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "1.0.x-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "classmap": [[m
[32m+[m[32m                    "src/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-3-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Arne Blankerts",[m
[32m+[m[32m                    "email": "arne@blankerts.de",[m
[32m+[m[32m                    "role": "Developer"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Sebastian Heuer",[m
[32m+[m[32m                    "email": "sebastian@phpeople.de",[m
[32m+[m[32m                    "role": "Developer"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Sebastian Bergmann",[m
[32m+[m[32m                    "email": "sebastian@phpunit.de",[m
[32m+[m[32m                    "role": "Developer"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Component for reading phar.io manifest information from a PHP Archive (PHAR)",[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/phar-io/manifest/issues",[m
[32m+[m[32m                "source": "https://github.com/phar-io/manifest/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2018-07-08T19:23:20+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "phar-io/version",[m
[32m+[m[32m            "version": "2.0.1",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/phar-io/version.git",[m
[32m+[m[32m                "reference": "45a2ec53a73c70ce41d55cedef9063630abaf1b6"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/phar-io/version/zipball/45a2ec53a73c70ce41d55cedef9063630abaf1b6",[m
[32m+[m[32m                "reference": "45a2ec53a73c70ce41d55cedef9063630abaf1b6",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^5.6 || ^7.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "classmap": [[m
[32m+[m[32m                    "src/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-3-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Arne Blankerts",[m
[32m+[m[32m                    "email": "arne@blankerts.de",[m
[32m+[m[32m                    "role": "Developer"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Sebastian Heuer",[m
[32m+[m[32m                    "email": "sebastian@phpeople.de",[m
[32m+[m[32m                    "role": "Developer"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Sebastian Bergmann",[m
[32m+[m[32m                    "email": "sebastian@phpunit.de",[m
[32m+[m[32m                    "role": "Developer"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Library for handling version information and constraints",[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/phar-io/version/issues",[m
[32m+[m[32m                "source": "https://github.com/phar-io/version/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2018-07-08T19:19:57+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "phpdocumentor/reflection-common",[m
[32m+[m[32m            "version": "2.2.0",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/phpDocumentor/ReflectionCommon.git",[m
[32m+[m[32m                "reference": "1d01c49d4ed62f25aa84a747ad35d5a16924662b"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/phpDocumentor/ReflectionCommon/zipball/1d01c49d4ed62f25aa84a747ad35d5a16924662b",[m
[32m+[m[32m                "reference": "1d01c49d4ed62f25aa84a747ad35d5a16924662b",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^7.2 || ^8.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-2.x": "2.x-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "phpDocumentor\\Reflection\\": "src/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Jaap van Otterdijk",[m
[32m+[m[32m                    "email": "opensource@ijaap.nl"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Common reflection classes used by phpdocumentor to reflect the code structure",[m
[32m+[m[32m            "homepage": "http://www.phpdoc.org",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "FQSEN",[m
[32m+[m[32m                "phpDocumentor",[m
[32m+[m[32m                "phpdoc",[m
[32m+[m[32m                "reflection",[m
[32m+[m[32m                "static analysis"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/phpDocumentor/ReflectionCommon/issues",[m
[32m+[m[32m                "source": "https://github.com/phpDocumentor/ReflectionCommon/tree/2.x"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2020-06-27T09:03:43+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "phpdocumentor/reflection-docblock",[m
[32m+[m[32m            "version": "5.2.2",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/phpDocumentor/ReflectionDocBlock.git",[m
[32m+[m[32m                "reference": "069a785b2141f5bcf49f3e353548dc1cce6df556"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/phpDocumentor/ReflectionDocBlock/zipball/069a785b2141f5bcf49f3e353548dc1cce6df556",[m
[32m+[m[32m                "reference": "069a785b2141f5bcf49f3e353548dc1cce6df556",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "ext-filter": "*",[m
[32m+[m[32m                "php": "^7.2 || ^8.0",[m
[32m+[m[32m                "phpdocumentor/reflection-common": "^2.2",[m
[32m+[m[32m                "phpdocumentor/type-resolver": "^1.3",[m
[32m+[m[32m                "webmozart/assert": "^1.9.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "mockery/mockery": "~1.3.2"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "5.x-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "phpDocumentor\\Reflection\\": "src"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Mike van Riel",[m
[32m+[m[32m                    "email": "me@mikevanriel.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Jaap van Otterdijk",[m
[32m+[m[32m                    "email": "account@ijaap.nl"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "With this component, a library can provide support for annotations via DocBlocks or otherwise retrieve information that is embedded in a DocBlock.",[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/phpDocumentor/ReflectionDocBlock/issues",[m
[32m+[m[32m                "source": "https://github.com/phpDocumentor/ReflectionDocBlock/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2020-09-03T19:13:55+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "phpdocumentor/type-resolver",[m
[32m+[m[32m            "version": "1.4.0",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/phpDocumentor/TypeResolver.git",[m
[32m+[m[32m                "reference": "6a467b8989322d92aa1c8bf2bebcc6e5c2ba55c0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/phpDocumentor/TypeResolver/zipball/6a467b8989322d92aa1c8bf2bebcc6e5c2ba55c0",[m
[32m+[m[32m                "reference": "6a467b8989322d92aa1c8bf2bebcc6e5c2ba55c0",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^7.2 || ^8.0",[m
[32m+[m[32m                "phpdocumentor/reflection-common": "^2.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "ext-tokenizer": "*"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-1.x": "1.x-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "phpDocumentor\\Reflection\\": "src"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Mike van Riel",[m
[32m+[m[32m                    "email": "me@mikevanriel.com"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "A PSR-5 based resolver of Class names, Types and Structural Element Names",[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/phpDocumentor/TypeResolver/issues",[m
[32m+[m[32m                "source": "https://github.com/phpDocumentor/TypeResolver/tree/1.4.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2020-09-17T18:55:26+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "phpspec/prophecy",[m
[32m+[m[32m            "version": "1.12.1",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/phpspec/prophecy.git",[m
[32m+[m[32m                "reference": "8ce87516be71aae9b956f81906aaf0338e0d8a2d"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/phpspec/prophecy/zipball/8ce87516be71aae9b956f81906aaf0338e0d8a2d",[m
[32m+[m[32m                "reference": "8ce87516be71aae9b956f81906aaf0338e0d8a2d",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "doctrine/instantiator": "^1.2",[m
[32m+[m[32m                "php": "^7.2 || ~8.0, <8.1",[m
[32m+[m[32m                "phpdocumentor/reflection-docblock": "^5.2",[m
[32m+[m[32m                "sebastian/comparator": "^3.0 || ^4.0",[m
[32m+[m[32m                "sebastian/recursion-context": "^3.0 || ^4.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "phpspec/phpspec": "^6.0",[m
[32m+[m[32m                "phpunit/phpunit": "^8.0 || ^9.0 <9.3"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "1.11.x-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Prophecy\\": "src/Prophecy"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Konstantin Kudryashov",[m
[32m+[m[32m                    "email": "ever.zet@gmail.com",[m
[32m+[m[32m                    "homepage": "http://everzet.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Marcello Duarte",[m
[32m+[m[32m                    "email": "marcello.duarte@gmail.com"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Highly opinionated mocking framework for PHP 5.3+",[m
[32m+[m[32m            "homepage": "https://github.com/phpspec/prophecy",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "Double",[m
[32m+[m[32m                "Dummy",[m
[32m+[m[32m                "fake",[m
[32m+[m[32m                "mock",[m
[32m+[m[32m                "spy",[m
[32m+[m[32m                "stub"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/phpspec/prophecy/issues",[m
[32m+[m[32m                "source": "https://github.com/phpspec/prophecy/tree/1.12.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2020-09-29T09:10:42+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "phpunit/php-code-coverage",[m
[32m+[m[32m            "version": "6.1.4",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/sebastianbergmann/php-code-coverage.git",[m
[32m+[m[32m                "reference": "807e6013b00af69b6c5d9ceb4282d0393dbb9d8d"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/sebastianbergmann/php-code-coverage/zipball/807e6013b00af69b6c5d9ceb4282d0393dbb9d8d",[m
[32m+[m[32m                "reference": "807e6013b00af69b6c5d9ceb4282d0393dbb9d8d",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "ext-dom": "*",[m
[32m+[m[32m                "ext-xmlwriter": "*",[m
[32m+[m[32m                "php": "^7.1",[m
[32m+[m[32m                "phpunit/php-file-iterator": "^2.0",[m
[32m+[m[32m                "phpunit/php-text-template": "^1.2.1",[m
[32m+[m[32m                "phpunit/php-token-stream": "^3.0",[m
[32m+[m[32m                "sebastian/code-unit-reverse-lookup": "^1.0.1",[m
[32m+[m[32m                "sebastian/environment": "^3.1 || ^4.0",[m
[32m+[m[32m                "sebastian/version": "^2.0.1",[m
[32m+[m[32m                "theseer/tokenizer": "^1.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "phpunit/phpunit": "^7.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "ext-xdebug": "^2.6.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "6.1-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "classmap": [[m
[32m+[m[32m                    "src/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-3-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Sebastian Bergmann",[m
[32m+[m[32m                    "email": "sebastian@phpunit.de",[m
[32m+[m[32m                    "role": "lead"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Library that provides collection, processing, and rendering functionality for PHP code coverage information.",[m
[32m+[m[32m            "homepage": "https://github.com/sebastianbergmann/php-code-coverage",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "coverage",[m
[32m+[m[32m                "testing",[m
[32m+[m[32m                "xunit"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/sebastianbergmann/php-code-coverage/issues",[m
[32m+[m[32m                "source": "https://github.com/sebastianbergmann/php-code-coverage/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2018-10-31T16:06:48+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "phpunit/php-file-iterator",[m
[32m+[m[32m            "version": "2.0.2",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/sebastianbergmann/php-file-iterator.git",[m
[32m+[m[32m                "reference": "050bedf145a257b1ff02746c31894800e5122946"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/sebastianbergmann/php-file-iterator/zipball/050bedf145a257b1ff02746c31894800e5122946",[m
[32m+[m[32m                "reference": "050bedf145a257b1ff02746c31894800e5122946",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^7.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "phpunit/phpunit": "^7.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "2.0.x-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "classmap": [[m
[32m+[m[32m                    "src/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-3-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Sebastian Bergmann",[m
[32m+[m[32m                    "email": "sebastian@phpunit.de",[m
[32m+[m[32m                    "role": "lead"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "FilterIterator implementation that filters files based on a list of suffixes.",[m
[32m+[m[32m            "homepage": "https://github.com/sebastianbergmann/php-file-iterator/",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "filesystem",[m
[32m+[m[32m                "iterator"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/sebastianbergmann/php-file-iterator/issues",[m
[32m+[m[32m                "source": "https://github.com/sebastianbergmann/php-file-iterator/tree/2.0.2"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2018-09-13T20:33:42+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "phpunit/php-text-template",[m
[32m+[m[32m            "version": "1.2.1",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/sebastianbergmann/php-text-template.git",[m
[32m+[m[32m                "reference": "31f8b717e51d9a2afca6c9f046f5d69fc27c8686"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/sebastianbergmann/php-text-template/zipball/31f8b717e51d9a2afca6c9f046f5d69fc27c8686",[m
[32m+[m[32m                "reference": "31f8b717e51d9a2afca6c9f046f5d69fc27c8686",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=5.3.3"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "classmap": [[m
[32m+[m[32m                    "src/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-3-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Sebastian Bergmann",[m
[32m+[m[32m                    "email": "sebastian@phpunit.de",[m
[32m+[m[32m                    "role": "lead"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Simple template engine.",[m
[32m+[m[32m            "homepage": "https://github.com/sebastianbergmann/php-text-template/",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "template"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/sebastianbergmann/php-text-template/issues",[m
[32m+[m[32m                "source": "https://github.com/sebastianbergmann/php-text-template/tree/1.2.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2015-06-21T13:50:34+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "phpunit/php-timer",[m
[32m+[m[32m            "version": "2.1.2",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/sebastianbergmann/php-timer.git",[m
[32m+[m[32m                "reference": "1038454804406b0b5f5f520358e78c1c2f71501e"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/sebastianbergmann/php-timer/zipball/1038454804406b0b5f5f520358e78c1c2f71501e",[m
[32m+[m[32m                "reference": "1038454804406b0b5f5f520358e78c1c2f71501e",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^7.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "phpunit/phpunit": "^7.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "2.1-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "classmap": [[m
[32m+[m[32m                    "src/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-3-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Sebastian Bergmann",[m
[32m+[m[32m                    "email": "sebastian@phpunit.de",[m
[32m+[m[32m                    "role": "lead"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Utility class for timing",[m
[32m+[m[32m            "homepage": "https://github.com/sebastianbergmann/php-timer/",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "timer"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/sebastianbergmann/php-timer/issues",[m
[32m+[m[32m                "source": "https://github.com/sebastianbergmann/php-timer/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2019-06-07T04:22:29+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "phpunit/php-token-stream",[m
[32m+[m[32m            "version": "3.1.1",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/sebastianbergmann/php-token-stream.git",[m
[32m+[m[32m                "reference": "995192df77f63a59e47f025390d2d1fdf8f425ff"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/sebastianbergmann/php-token-stream/zipball/995192df77f63a59e47f025390d2d1fdf8f425ff",[m
[32m+[m[32m                "reference": "995192df77f63a59e47f025390d2d1fdf8f425ff",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "ext-tokenizer": "*",[m
[32m+[m[32m                "php": "^7.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "phpunit/phpunit": "^7.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "3.1-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "classmap": [[m
[32m+[m[32m                    "src/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-3-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Sebastian Bergmann",[m
[32m+[m[32m                    "email": "sebastian@phpunit.de"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Wrapper around PHP's tokenizer extension.",[m
[32m+[m[32m            "homepage": "https://github.com/sebastianbergmann/php-token-stream/",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "tokenizer"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/sebastianbergmann/php-token-stream/issues",[m
[32m+[m[32m                "source": "https://github.com/sebastianbergmann/php-token-stream/tree/3.1.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "abandoned": true,[m
[32m+[m[32m            "time": "2019-09-17T06:23:10+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "phpunit/phpunit",[m
[32m+[m[32m            "version": "7.5.20",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/sebastianbergmann/phpunit.git",[m
[32m+[m[32m                "reference": "9467db479d1b0487c99733bb1e7944d32deded2c"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/sebastianbergmann/phpunit/zipball/9467db479d1b0487c99733bb1e7944d32deded2c",[m
[32m+[m[32m                "reference": "9467db479d1b0487c99733bb1e7944d32deded2c",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "doctrine/instantiator": "^1.1",[m
[32m+[m[32m                "ext-dom": "*",[m
[32m+[m[32m                "ext-json": "*",[m
[32m+[m[32m                "ext-libxml": "*",[m
[32m+[m[32m                "ext-mbstring": "*",[m
[32m+[m[32m                "ext-xml": "*",[m
[32m+[m[32m                "myclabs/deep-copy": "^1.7",[m
[32m+[m[32m                "phar-io/manifest": "^1.0.2",[m
[32m+[m[32m                "phar-io/version": "^2.0",[m
[32m+[m[32m                "php": "^7.1",[m
[32m+[m[32m                "phpspec/prophecy": "^1.7",[m
[32m+[m[32m                "phpunit/php-code-coverage": "^6.0.7",[m
[32m+[m[32m                "phpunit/php-file-iterator": "^2.0.1",[m
[32m+[m[32m                "phpunit/php-text-template": "^1.2.1",[m
[32m+[m[32m                "phpunit/php-timer": "^2.1",[m
[32m+[m[32m                "sebastian/comparator": "^3.0",[m
[32m+[m[32m                "sebastian/diff": "^3.0",[m
[32m+[m[32m                "sebastian/environment": "^4.0",[m
[32m+[m[32m                "sebastian/exporter": "^3.1",[m
[32m+[m[32m                "sebastian/global-state": "^2.0",[m
[32m+[m[32m                "sebastian/object-enumerator": "^3.0.3",[m
[32m+[m[32m                "sebastian/resource-operations": "^2.0",[m
[32m+[m[32m                "sebastian/version": "^2.0.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "conflict": {[m
[32m+[m[32m                "phpunit/phpunit-mock-objects": "*"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "ext-pdo": "*"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "ext-soap": "*",[m
[32m+[m[32m                "ext-xdebug": "*",[m
[32m+[m[32m                "phpunit/php-invoker": "^2.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "bin": [[m
[32m+[m[32m                "phpunit"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "7.5-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "classmap": [[m
[32m+[m[32m                    "src/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-3-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Sebastian Bergmann",[m
[32m+[m[32m                    "email": "sebastian@phpunit.de",[m
[32m+[m[32m                    "role": "lead"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "The PHP Unit Testing framework.",[m
[32m+[m[32m            "homepage": "https://phpunit.de/",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "phpunit",[m
[32m+[m[32m                "testing",[m
[32m+[m[32m                "xunit"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/sebastianbergmann/phpunit/issues",[m
[32m+[m[32m                "source": "https://github.com/sebastianbergmann/phpunit/tree/7.5.20"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2020-01-08T08:45:45+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "sebastian/code-unit-reverse-lookup",[m
[32m+[m[32m            "version": "1.0.1",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/sebastianbergmann/code-unit-reverse-lookup.git",[m
[32m+[m[32m                "reference": "4419fcdb5eabb9caa61a27c7a1db532a6b55dd18"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/sebastianbergmann/code-unit-reverse-lookup/zipball/4419fcdb5eabb9caa61a27c7a1db532a6b55dd18",[m
[32m+[m[32m                "reference": "4419fcdb5eabb9caa61a27c7a1db532a6b55dd18",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^5.6 || ^7.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "phpunit/phpunit": "^5.7 || ^6.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "1.0.x-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "classmap": [[m
[32m+[m[32m                    "src/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-3-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Sebastian Bergmann",[m
[32m+[m[32m                    "email": "sebastian@phpunit.de"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Looks up which function or method a line of code belongs to",[m
[32m+[m[32m            "homepage": "https://github.com/sebastianbergmann/code-unit-reverse-lookup/",[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/sebastianbergmann/code-unit-reverse-lookup/issues",[m
[32m+[m[32m                "source": "https://github.com/sebastianbergmann/code-unit-reverse-lookup/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2017-03-04T06:30:41+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "sebastian/comparator",[m
[32m+[m[32m            "version": "3.0.2",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/sebastianbergmann/comparator.git",[m
[32m+[m[32m                "reference": "5de4fc177adf9bce8df98d8d141a7559d7ccf6da"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/sebastianbergmann/comparator/zipball/5de4fc177adf9bce8df98d8d141a7559d7ccf6da",[m
[32m+[m[32m                "reference": "5de4fc177adf9bce8df98d8d141a7559d7ccf6da",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^7.1",[m
[32m+[m[32m                "sebastian/diff": "^3.0",[m
[32m+[m[32m                "sebastian/exporter": "^3.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "phpunit/phpunit": "^7.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "3.0-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "classmap": [[m
[32m+[m[32m                    "src/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-3-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Jeff Welch",[m
[32m+[m[32m                    "email": "whatthejeff@gmail.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Volker Dusch",[m
[32m+[m[32m                    "email": "github@wallbash.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Bernhard Schussek",[m
[32m+[m[32m                    "email": "bschussek@2bepublished.at"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Sebastian Bergmann",[m
[32m+[m[32m                    "email": "sebastian@phpunit.de"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Provides the functionality to compare PHP values for equality",[m
[32m+[m[32m            "homepage": "https://github.com/sebastianbergmann/comparator",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "comparator",[m
[32m+[m[32m                "compare",[m
[32m+[m[32m                "equality"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/sebastianbergmann/comparator/issues",[m
[32m+[m[32m                "source": "https://github.com/sebastianbergmann/comparator/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2018-07-12T15:12:46+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "sebastian/diff",[m
[32m+[m[32m            "version": "3.0.2",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/sebastianbergmann/diff.git",[m
[32m+[m[32m                "reference": "720fcc7e9b5cf384ea68d9d930d480907a0c1a29"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/sebastianbergmann/diff/zipball/720fcc7e9b5cf384ea68d9d930d480907a0c1a29",[m
[32m+[m[32m                "reference": "720fcc7e9b5cf384ea68d9d930d480907a0c1a29",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^7.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "phpunit/phpunit": "^7.5 || ^8.0",[m
[32m+[m[32m                "symfony/process": "^2 || ^3.3 || ^4"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "3.0-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "classmap": [[m
[32m+[m[32m                    "src/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-3-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Kore Nordmann",[m
[32m+[m[32m                    "email": "mail@kore-nordmann.de"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Sebastian Bergmann",[m
[32m+[m[32m                    "email": "sebastian@phpunit.de"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Diff implementation",[m
[32m+[m[32m            "homepage": "https://github.com/sebastianbergmann/diff",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "diff",[m
[32m+[m[32m                "udiff",[m
[32m+[m[32m                "unidiff",[m
[32m+[m[32m                "unified diff"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/sebastianbergmann/diff/issues",[m
[32m+[m[32m                "source": "https://github.com/sebastianbergmann/diff/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2019-02-04T06:01:07+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "sebastian/environment",[m
[32m+[m[32m            "version": "4.2.3",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/sebastianbergmann/environment.git",[m
[32m+[m[32m                "reference": "464c90d7bdf5ad4e8a6aea15c091fec0603d4368"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/sebastianbergmann/environment/zipball/464c90d7bdf5ad4e8a6aea15c091fec0603d4368",[m
[32m+[m[32m                "reference": "464c90d7bdf5ad4e8a6aea15c091fec0603d4368",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^7.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "phpunit/phpunit": "^7.5"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "ext-posix": "*"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "4.2-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "classmap": [[m
[32m+[m[32m                    "src/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-3-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Sebastian Bergmann",[m
[32m+[m[32m                    "email": "sebastian@phpunit.de"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Provides functionality to handle HHVM/PHP environments",[m
[32m+[m[32m            "homepage": "http://www.github.com/sebastianbergmann/environment",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "Xdebug",[m
[32m+[m[32m                "environment",[m
[32m+[m[32m                "hhvm"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/sebastianbergmann/environment/issues",[m
[32m+[m[32m                "source": "https://github.com/sebastianbergmann/environment/tree/4.2.3"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2019-11-20T08:46:58+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "sebastian/exporter",[m
[32m+[m[32m            "version": "3.1.2",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/sebastianbergmann/exporter.git",[m
[32m+[m[32m                "reference": "68609e1261d215ea5b21b7987539cbfbe156ec3e"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/sebastianbergmann/exporter/zipball/68609e1261d215ea5b21b7987539cbfbe156ec3e",[m
[32m+[m[32m                "reference": "68609e1261d215ea5b21b7987539cbfbe156ec3e",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^7.0",[m
[32m+[m[32m                "sebastian/recursion-context": "^3.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "ext-mbstring": "*",[m
[32m+[m[32m                "phpunit/phpunit": "^6.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "3.1.x-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "classmap": [[m
[32m+[m[32m                    "src/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-3-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Sebastian Bergmann",[m
[32m+[m[32m                    "email": "sebastian@phpunit.de"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Jeff Welch",[m
[32m+[m[32m                    "email": "whatthejeff@gmail.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Volker Dusch",[m
[32m+[m[32m                    "email": "github@wallbash.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Adam Harvey",[m
[32m+[m[32m                    "email": "aharvey@php.net"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Bernhard Schussek",[m
[32m+[m[32m                    "email": "bschussek@gmail.com"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Provides the functionality to export PHP variables for visualization",[m
[32m+[m[32m            "homepage": "http://www.github.com/sebastianbergmann/exporter",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "export",[m
[32m+[m[32m                "exporter"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/sebastianbergmann/exporter/issues",[m
[32m+[m[32m                "source": "https://github.com/sebastianbergmann/exporter/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2019-09-14T09:02:43+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "sebastian/global-state",[m
[32m+[m[32m            "version": "2.0.0",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/sebastianbergmann/global-state.git",[m
[32m+[m[32m                "reference": "e8ba02eed7bbbb9e59e43dedd3dddeff4a56b0c4"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/sebastianbergmann/global-state/zipball/e8ba02eed7bbbb9e59e43dedd3dddeff4a56b0c4",[m
[32m+[m[32m                "reference": "e8ba02eed7bbbb9e59e43dedd3dddeff4a56b0c4",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^7.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "phpunit/phpunit": "^6.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "suggest": {[m
[32m+[m[32m                "ext-uopz": "*"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "2.0-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "classmap": [[m
[32m+[m[32m                    "src/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-3-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Sebastian Bergmann",[m
[32m+[m[32m                    "email": "sebastian@phpunit.de"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Snapshotting of global state",[m
[32m+[m[32m            "homepage": "http://www.github.com/sebastianbergmann/global-state",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "global state"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/sebastianbergmann/global-state/issues",[m
[32m+[m[32m                "source": "https://github.com/sebastianbergmann/global-state/tree/2.0.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2017-04-27T15:39:26+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "sebastian/object-enumerator",[m
[32m+[m[32m            "version": "3.0.3",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/sebastianbergmann/object-enumerator.git",[m
[32m+[m[32m                "reference": "7cfd9e65d11ffb5af41198476395774d4c8a84c5"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/sebastianbergmann/object-enumerator/zipball/7cfd9e65d11ffb5af41198476395774d4c8a84c5",[m
[32m+[m[32m                "reference": "7cfd9e65d11ffb5af41198476395774d4c8a84c5",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^7.0",[m
[32m+[m[32m                "sebastian/object-reflector": "^1.1.1",[m
[32m+[m[32m                "sebastian/recursion-context": "^3.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "phpunit/phpunit": "^6.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "3.0.x-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "classmap": [[m
[32m+[m[32m                    "src/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-3-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Sebastian Bergmann",[m
[32m+[m[32m                    "email": "sebastian@phpunit.de"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Traverses array structures and object graphs to enumerate all referenced objects",[m
[32m+[m[32m            "homepage": "https://github.com/sebastianbergmann/object-enumerator/",[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/sebastianbergmann/object-enumerator/issues",[m
[32m+[m[32m                "source": "https://github.com/sebastianbergmann/object-enumerator/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2017-08-03T12:35:26+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "sebastian/object-reflector",[m
[32m+[m[32m            "version": "1.1.1",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/sebastianbergmann/object-reflector.git",[m
[32m+[m[32m                "reference": "773f97c67f28de00d397be301821b06708fca0be"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/sebastianbergmann/object-reflector/zipball/773f97c67f28de00d397be301821b06708fca0be",[m
[32m+[m[32m                "reference": "773f97c67f28de00d397be301821b06708fca0be",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^7.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "phpunit/phpunit": "^6.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "1.1-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "classmap": [[m
[32m+[m[32m                    "src/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-3-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Sebastian Bergmann",[m
[32m+[m[32m                    "email": "sebastian@phpunit.de"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Allows reflection of object attributes, including inherited and non-public ones",[m
[32m+[m[32m            "homepage": "https://github.com/sebastianbergmann/object-reflector/",[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/sebastianbergmann/object-reflector/issues",[m
[32m+[m[32m                "source": "https://github.com/sebastianbergmann/object-reflector/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2017-03-29T09:07:27+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "sebastian/recursion-context",[m
[32m+[m[32m            "version": "3.0.0",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/sebastianbergmann/recursion-context.git",[m
[32m+[m[32m                "reference": "5b0cd723502bac3b006cbf3dbf7a1e3fcefe4fa8"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/sebastianbergmann/recursion-context/zipball/5b0cd723502bac3b006cbf3dbf7a1e3fcefe4fa8",[m
[32m+[m[32m                "reference": "5b0cd723502bac3b006cbf3dbf7a1e3fcefe4fa8",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^7.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "phpunit/phpunit": "^6.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "3.0.x-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "classmap": [[m
[32m+[m[32m                    "src/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-3-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Jeff Welch",[m
[32m+[m[32m                    "email": "whatthejeff@gmail.com"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Sebastian Bergmann",[m
[32m+[m[32m                    "email": "sebastian@phpunit.de"[m
[32m+[m[32m                },[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Adam Harvey",[m
[32m+[m[32m                    "email": "aharvey@php.net"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Provides functionality to recursively process PHP variables",[m
[32m+[m[32m            "homepage": "http://www.github.com/sebastianbergmann/recursion-context",[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/sebastianbergmann/recursion-context/issues",[m
[32m+[m[32m                "source": "https://github.com/sebastianbergmann/recursion-context/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2017-03-03T06:23:57+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "sebastian/resource-operations",[m
[32m+[m[32m            "version": "2.0.1",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/sebastianbergmann/resource-operations.git",[m
[32m+[m[32m                "reference": "4d7a795d35b889bf80a0cc04e08d77cedfa917a9"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/sebastianbergmann/resource-operations/zipball/4d7a795d35b889bf80a0cc04e08d77cedfa917a9",[m
[32m+[m[32m                "reference": "4d7a795d35b889bf80a0cc04e08d77cedfa917a9",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^7.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "2.0-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "classmap": [[m
[32m+[m[32m                    "src/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-3-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Sebastian Bergmann",[m
[32m+[m[32m                    "email": "sebastian@phpunit.de"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Provides a list of PHP built-in functions that operate on resources",[m
[32m+[m[32m            "homepage": "https://www.github.com/sebastianbergmann/resource-operations",[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/sebastianbergmann/resource-operations/issues",[m
[32m+[m[32m                "source": "https://github.com/sebastianbergmann/resource-operations/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2018-10-04T04:07:39+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "sebastian/version",[m
[32m+[m[32m            "version": "2.0.1",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/sebastianbergmann/version.git",[m
[32m+[m[32m                "reference": "99732be0ddb3361e16ad77b68ba41efc8e979019"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/sebastianbergmann/version/zipball/99732be0ddb3361e16ad77b68ba41efc8e979019",[m
[32m+[m[32m                "reference": "99732be0ddb3361e16ad77b68ba41efc8e979019",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": ">=5.6"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "extra": {[m
[32m+[m[32m                "branch-alias": {[m
[32m+[m[32m                    "dev-master": "2.0.x-dev"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "classmap": [[m
[32m+[m[32m                    "src/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-3-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Sebastian Bergmann",[m
[32m+[m[32m                    "email": "sebastian@phpunit.de",[m
[32m+[m[32m                    "role": "lead"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Library that helps with managing the version number of Git-hosted PHP projects",[m
[32m+[m[32m            "homepage": "https://github.com/sebastianbergmann/version",[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/sebastianbergmann/version/issues",[m
[32m+[m[32m                "source": "https://github.com/sebastianbergmann/version/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2016-10-03T07:35:21+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "theseer/tokenizer",[m
[32m+[m[32m            "version": "1.2.0",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/theseer/tokenizer.git",[m
[32m+[m[32m                "reference": "75a63c33a8577608444246075ea0af0d052e452a"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/theseer/tokenizer/zipball/75a63c33a8577608444246075ea0af0d052e452a",[m
[32m+[m[32m                "reference": "75a63c33a8577608444246075ea0af0d052e452a",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "ext-dom": "*",[m
[32m+[m[32m                "ext-tokenizer": "*",[m
[32m+[m[32m                "ext-xmlwriter": "*",[m
[32m+[m[32m                "php": "^7.2 || ^8.0"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "classmap": [[m
[32m+[m[32m                    "src/"[m
[32m+[m[32m                ][m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "BSD-3-Clause"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Arne Blankerts",[m
[32m+[m[32m                    "email": "arne@blankerts.de",[m
[32m+[m[32m                    "role": "Developer"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "A small library for converting tokenized PHP source code into XML and potentially other formats",[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/theseer/tokenizer/issues",[m
[32m+[m[32m                "source": "https://github.com/theseer/tokenizer/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "funding": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "url": "https://github.com/theseer",[m
[32m+[m[32m                    "type": "github"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "time": "2020-07-12T23:59:07+00:00"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "webmozart/assert",[m
[32m+[m[32m            "version": "1.9.1",[m
[32m+[m[32m            "source": {[m
[32m+[m[32m                "type": "git",[m
[32m+[m[32m                "url": "https://github.com/webmozart/assert.git",[m
[32m+[m[32m                "reference": "bafc69caeb4d49c39fd0779086c03a3738cbb389"[m
[32m+[m[32m            },[m
[32m+[m[32m            "dist": {[m
[32m+[m[32m                "type": "zip",[m
[32m+[m[32m                "url": "https://api.github.com/repos/webmozart/assert/zipball/bafc69caeb4d49c39fd0779086c03a3738cbb389",[m
[32m+[m[32m                "reference": "bafc69caeb4d49c39fd0779086c03a3738cbb389",[m
[32m+[m[32m                "shasum": ""[m
[32m+[m[32m            },[m
[32m+[m[32m            "require": {[m
[32m+[m[32m                "php": "^5.3.3 || ^7.0 || ^8.0",[m
[32m+[m[32m                "symfony/polyfill-ctype": "^1.8"[m
[32m+[m[32m            },[m
[32m+[m[32m            "conflict": {[m
[32m+[m[32m                "phpstan/phpstan": "<0.12.20",[m
[32m+[m[32m                "vimeo/psalm": "<3.9.1"[m
[32m+[m[32m            },[m
[32m+[m[32m            "require-dev": {[m
[32m+[m[32m                "phpunit/phpunit": "^4.8.36 || ^7.5.13"[m
[32m+[m[32m            },[m
[32m+[m[32m            "type": "library",[m
[32m+[m[32m            "autoload": {[m
[32m+[m[32m                "psr-4": {[m
[32m+[m[32m                    "Webmozart\\Assert\\": "src/"[m
[32m+[m[32m                }[m
[32m+[m[32m            },[m
[32m+[m[32m            "notification-url": "https://packagist.org/downloads/",[m
[32m+[m[32m            "license": [[m
[32m+[m[32m                "MIT"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "authors": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "name": "Bernhard Schussek",[m
[32m+[m[32m                    "email": "bschussek@gmail.com"[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "description": "Assertions to validate method input/output with nice error messages.",[m
[32m+[m[32m            "keywords": [[m
[32m+[m[32m                "assert",[m
[32m+[m[32m                "check",[m
[32m+[m[32m                "validate"[m
[32m+[m[32m            ],[m
[32m+[m[32m            "support": {[m
[32m+[m[32m                "issues": "https://github.com/webmozart/assert/issues",[m
[32m+[m[32m                "source": "https://github.com/webmozart/assert/tree/master"[m
[32m+[m[32m            },[m
[32m+[m[32m            "time": "2020-07-08T17:02:28+00:00"[m
[32m+[m[32m        }[m
[32m+[m[32m    ],[m
[32m+[m[32m    "aliases": [],[m
[32m+[m[32m    "minimum-stability": "dev",[m
[32m+[m[32m    "stability-flags": [],[m
[32m+[m[32m    "prefer-stable": true,[m
[32m+[m[32m    "prefer-lowest": false,[m
[32m+[m[32m    "platform": {[m
[32m+[m[32m        "php": "^7.1.3"[m
[32m+[m[32m    },[m
[32m+[m[32m    "platform-dev": [],[m
[32m+[m[32m    "plugin-api-version": "2.0.0"[m
[32m+[m[32m}[m
[1mdiff --git a/config/app.php b/config/app.php[m
[1mnew file mode 100755[m
[1mindex 0000000..bc142a3[m
[1m--- /dev/null[m
[1m+++ b/config/app.php[m
[36m@@ -0,0 +1,233 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mreturn [[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Application Name[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | This value is the name of your application. This value is used when the[m
[32m+[m[32m    | framework needs to place the application's name in a notification or[m
[32m+[m[32m    | any other location as required by the application or its packages.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'name' => env('APP_NAME', 'Laravel'),[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Application Environment[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | This value determines the "environment" your application is currently[m
[32m+[m[32m    | running in. This may determine how you prefer to configure various[m
[32m+[m[32m    | services the application utilizes. Set this in your ".env" file.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'env' => env('APP_ENV', 'production'),[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Application Debug Mode[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | When your application is in debug mode, detailed error messages with[m
[32m+[m[32m    | stack traces will be shown on every error that occurs within your[m
[32m+[m[32m    | application. If disabled, a simple generic error page is shown.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'debug' => env('APP_DEBUG', false),[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Application URL[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | This URL is used by the console to properly generate URLs when using[m
[32m+[m[32m    | the Artisan command line tool. You should set this to the root of[m
[32m+[m[32m    | your application so that it is used when running Artisan tasks.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'url' => env('APP_URL', 'http://localhost'),[m
[32m+[m
[32m+[m[32m    'asset_url' => env('ASSET_URL', null),[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Application Timezone[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | Here you may specify the default timezone for your application, which[m
[32m+[m[32m    | will be used by the PHP date and date-time functions. We have gone[m
[32m+[m[32m    | ahead and set this to a sensible default for you out of the box.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'timezone' => 'UTC',[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Application Locale Configuration[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | The application locale determines the default locale that will be used[m
[32m+[m[32m    | by the translation service provider. You are free to set this value[m
[32m+[m[32m    | to any of the locales which will be supported by the application.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'locale' => 'en',[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Application Fallback Locale[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | The fallback locale determines the locale to use when the current one[m
[32m+[m[32m    | is not available. You may change the value to correspond to any of[m
[32m+[m[32m    | the language folders that are provided through your application.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'fallback_locale' => 'en',[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Faker Locale[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | This locale will be used by the Faker PHP library when generating fake[m
[32m+[m[32m    | data for your database seeds. For example, this will be used to get[m
[32m+[m[32m    | localized telephone numbers, street address information and more.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'faker_locale' => 'en_US',[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Encryption Key[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | This key is used by the Illuminate encrypter service and should be set[m
[32m+[m[32m    | to a random, 32 character string, otherwise these encrypted strings[m
[32m+[m[32m    | will not be safe. Please do this before deploying an application![m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'key' => env('APP_KEY'),[m
[32m+[m
[32m+[m[32m    'cipher' => 'AES-256-CBC',[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Autoloaded Service Providers[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | The service providers listed here will be automatically loaded on the[m
[32m+[m[32m    | request to your application. Feel free to add your own services to[m
[32m+[m[32m    | this array to grant expanded functionality to your applications.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'providers' => [[m
[32m+[m
[32m+[m[32m        /*[m
[32m+[m[32m         * Laravel Framework Service Providers...[m
[32m+[m[32m         */[m
[32m+[m[32m        Illuminate\Auth\AuthServiceProvider::class,[m
[32m+[m[32m        Illuminate\Broadcasting\BroadcastServiceProvider::class,[m
[32m+[m[32m        Illuminate\Bus\BusServiceProvider::class,[m
[32m+[m[32m        Illuminate\Cache\CacheServiceProvider::class,[m
[32m+[m[32m        Illuminate\Foundation\Providers\ConsoleSupportServiceProvider::class,[m
[32m+[m[32m        Illuminate\Cookie\CookieServiceProvider::class,[m
[32m+[m[32m        Illuminate\Database\DatabaseServiceProvider::class,[m
[32m+[m[32m        Illuminate\Encryption\EncryptionServiceProvider::class,[m
[32m+[m[32m        Illuminate\Filesystem\FilesystemServiceProvider::class,[m
[32m+[m[32m        Illuminate\Foundation\Providers\FoundationServiceProvider::class,[m
[32m+[m[32m        Illuminate\Hashing\HashServiceProvider::class,[m
[32m+[m[32m        Illuminate\Mail\MailServiceProvider::class,[m
[32m+[m[32m        Illuminate\Notifications\NotificationServiceProvider::class,[m
[32m+[m[32m        Illuminate\Pagination\PaginationServiceProvider::class,[m
[32m+[m[32m        Illuminate\Pipeline\PipelineServiceProvider::class,[m
[32m+[m[32m        Illuminate\Queue\QueueServiceProvider::class,[m
[32m+[m[32m        Illuminate\Redis\RedisServiceProvider::class,[m
[32m+[m[32m        Illuminate\Auth\Passwords\PasswordResetServiceProvider::class,[m
[32m+[m[32m        Illuminate\Session\SessionServiceProvider::class,[m
[32m+[m[32m        Illuminate\Translation\TranslationServiceProvider::class,[m
[32m+[m[32m        Illuminate\Validation\ValidationServiceProvider::class,[m
[32m+[m[32m        Illuminate\View\ViewServiceProvider::class,[m
[32m+[m
[32m+[m[32m        /*[m
[32m+[m[32m         * Package Service Providers...[m
[32m+[m[32m         */[m
[32m+[m
[32m+[m[32m        /*[m
[32m+[m[32m         * Application Service Providers...[m
[32m+[m[32m         */[m
[32m+[m[32m        App\Providers\AppServiceProvider::class,[m
[32m+[m[32m        App\Providers\AuthServiceProvider::class,[m
[32m+[m[32m        // App\Providers\BroadcastServiceProvider::class,[m
[32m+[m[32m        App\Providers\EventServiceProvider::class,[m
[32m+[m[32m        App\Providers\RouteServiceProvider::class,[m
[32m+[m[32m        App\Providers\PermissionsServiceProvider::class,[m
[32m+[m
[32m+[m[32m    ],[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Class Aliases[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | This array of class aliases will be registered when this application[m
[32m+[m[32m    | is started. However, feel free to register as many as you wish as[m
[32m+[m[32m    | the aliases are "lazy" loaded so they don't hinder performance.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'aliases' => [[m
[32m+[m
[32m+[m[32m        'App' => Illuminate\Support\Facades\App::class,[m
[32m+[m[32m        'Arr' => Illuminate\Support\Arr::class,[m
[32m+[m[32m        'Artisan' => Illuminate\Support\Facades\Artisan::class,[m
[32m+[m[32m        'Auth' => Illuminate\Support\Facades\Auth::class,[m
[32m+[m[32m        'Blade' => Illuminate\Support\Facades\Blade::class,[m
[32m+[m[32m        'Broadcast' => Illuminate\Support\Facades\Broadcast::class,[m
[32m+[m[32m        'Bus' => Illuminate\Support\Facades\Bus::class,[m
[32m+[m[32m        'Cache' => Illuminate\Support\Facades\Cache::class,[m
[32m+[m[32m        'Config' => Illuminate\Support\Facades\Config::class,[m
[32m+[m[32m        'Cookie' => Illuminate\Support\Facades\Cookie::class,[m
[32m+[m[32m        'Crypt' => Illuminate\Support\Facades\Crypt::class,[m
[32m+[m[32m        'DB' => Illuminate\Support\Facades\DB::class,[m
[32m+[m[32m        'Eloquent' => Illuminate\Database\Eloquent\Model::class,[m
[32m+[m[32m        'Event' => Illuminate\Support\Facades\Event::class,[m
[32m+[m[32m        'File' => Illuminate\Support\Facades\File::class,[m
[32m+[m[32m        'Gate' => Illuminate\Support\Facades\Gate::class,[m
[32m+[m[32m        'Hash' => Illuminate\Support\Facades\Hash::class,[m
[32m+[m[32m        'Lang' => Illuminate\Support\Facades\Lang::class,[m
[32m+[m[32m        'Log' => Illuminate\Support\Facades\Log::class,[m
[32m+[m[32m        'Mail' => Illuminate\Support\Facades\Mail::class,[m
[32m+[m[32m        'Notification' => Illuminate\Support\Facades\Notification::class,[m
[32m+[m[32m        'Password' => Illuminate\Support\Facades\Password::class,[m
[32m+[m[32m        'Queue' => Illuminate\Support\Facades\Queue::class,[m
[32m+[m[32m        'Redirect' => Illuminate\Support\Facades\Redirect::class,[m
[32m+[m[32m        'Redis' => Illuminate\Support\Facades\Redis::class,[m
[32m+[m[32m        'Request' => Illuminate\Support\Facades\Request::class,[m
[32m+[m[32m        'Response' => Illuminate\Support\Facades\Response::class,[m
[32m+[m[32m        'Route' => Illuminate\Support\Facades\Route::class,[m
[32m+[m[32m        'Schema' => Illuminate\Support\Facades\Schema::class,[m
[32m+[m[32m        'Session' => Illuminate\Support\Facades\Session::class,[m
[32m+[m[32m        'Storage' => Illuminate\Support\Facades\Storage::class,[m
[32m+[m[32m        'Str' => Illuminate\Support\Str::class,[m
[32m+[m[32m        'URL' => Illuminate\Support\Facades\URL::class,[m
[32m+[m[32m        'Validator' => Illuminate\Support\Facades\Validator::class,[m
[32m+[m[32m        'View' => Illuminate\Support\Facades\View::class,[m
[32m+[m[32m        'Helper' => App\Helpers\Helper::class,[m
[32m+[m
[32m+[m[32m    ],[m
[32m+[m
[32m+[m[32m];[m
[1mdiff --git a/config/auth.php b/config/auth.php[m
[1mnew file mode 100755[m
[1mindex 0000000..006a799[m
[1m--- /dev/null[m
[1m+++ b/config/auth.php[m
[36m@@ -0,0 +1,103 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mreturn [[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Authentication Defaults[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | This option controls the default authentication "guard" and password[m
[32m+[m[32m    | reset options for your application. You may change these defaults[m
[32m+[m[32m    | as required, but they're a perfect start for most applications.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'defaults' => [[m
[32m+[m[32m        'guard' => 'web',[m
[32m+[m[32m        'passwords' => 'users',[m
[32m+[m[32m    ],[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Authentication Guards[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | Next, you may define every authentication guard for your application.[m
[32m+[m[32m    | Of course, a great default configuration has been defined for you[m
[32m+[m[32m    | here which uses session storage and the Eloquent user provider.[m
[32m+[m[32m    |[m
[32m+[m[32m    | All authentication drivers have a user provider. This defines how the[m
[32m+[m[32m    | users are actually retrieved out of your database or other storage[m
[32m+[m[32m    | mechanisms used by this application to persist your user's data.[m
[32m+[m[32m    |[m
[32m+[m[32m    | Supported: "session", "token"[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'guards' => [[m
[32m+[m[32m        'web' => [[m
[32m+[m[32m            'driver' => 'session',[m
[32m+[m[32m            'provider' => 'users',[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        'api' => [[m
[32m+[m[32m            'driver' => 'passport',[m
[32m+[m[32m            'provider' => 'users',[m
[32m+[m[32m            'hash' => false,[m
[32m+[m[32m        ],[m
[32m+[m[32m    ],[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | User Providers[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | All authentication drivers have a user provider. This defines how the[m
[32m+[m[32m    | users are actually retrieved out of your database or other storage[m
[32m+[m[32m    | mechanisms used by this application to persist your user's data.[m
[32m+[m[32m    |[m
[32m+[m[32m    | If you have multiple user tables or models you may configure multiple[m
[32m+[m[32m    | sources which represent each model / table. These sources may then[m
[32m+[m[32m    | be assigned to any extra authentication guards you have defined.[m
[32m+[m[32m    |[m
[32m+[m[32m    | Supported: "database", "eloquent"[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'providers' => [[m
[32m+[m[32m        'users' => [[m
[32m+[m[32m            'driver' => 'eloquent',[m
[32m+[m[32m            'model' => App\Models\User::class,[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        // 'users' => [[m
[32m+[m[32m        //     'driver' => 'database',[m
[32m+[m[32m        //     'table' => 'users',[m
[32m+[m[32m        // ],[m
[32m+[m[32m    ],[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Resetting Passwords[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | You may specify multiple password reset configurations if you have more[m
[32m+[m[32m    | than one user table or model in the application and you want to have[m
[32m+[m[32m    | separate password reset settings based on the specific user types.[m
[32m+[m[32m    |[m
[32m+[m[32m    | The expire time is the number of minutes that the reset token should be[m
[32m+[m[32m    | considered valid. This security feature keeps tokens short-lived so[m
[32m+[m[32m    | they have less time to be guessed. You may change this as needed.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'passwords' => [[m
[32m+[m[32m        'users' => [[m
[32m+[m[32m            'provider' => 'users',[m
[32m+[m[32m            'table' => 'password_resets',[m
[32m+[m[32m            'expire' => 60,[m
[32m+[m[32m        ],[m
[32m+[m[32m    ],[m
[32m+[m
[32m+[m[32m];[m
[1mdiff --git a/config/broadcasting.php b/config/broadcasting.php[m
[1mnew file mode 100755[m
[1mindex 0000000..3bba110[m
[1m--- /dev/null[m
[1m+++ b/config/broadcasting.php[m
[36m@@ -0,0 +1,59 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mreturn [[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Default Broadcaster[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | This option controls the default broadcaster that will be used by the[m
[32m+[m[32m    | framework when an event needs to be broadcast. You may set this to[m
[32m+[m[32m    | any of the connections defined in the "connections" array below.[m
[32m+[m[32m    |[m
[32m+[m[32m    | Supported: "pusher", "redis", "log", "null"[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'default' => env('BROADCAST_DRIVER', 'null'),[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Broadcast Connections[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | Here you may define all of the broadcast connections that will be used[m
[32m+[m[32m    | to broadcast events to other systems or over websockets. Samples of[m
[32m+[m[32m    | each available type of connection are provided inside this array.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'connections' => [[m
[32m+[m
[32m+[m[32m        'pusher' => [[m
[32m+[m[32m            'driver' => 'pusher',[m
[32m+[m[32m            'key' => env('PUSHER_APP_KEY'),[m
[32m+[m[32m            'secret' => env('PUSHER_APP_SECRET'),[m
[32m+[m[32m            'app_id' => env('PUSHER_APP_ID'),[m
[32m+[m[32m            'options' => [[m
[32m+[m[32m                'cluster' => env('PUSHER_APP_CLUSTER'),[m
[32m+[m[32m                'useTLS' => true,[m
[32m+[m[32m            ],[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        'redis' => [[m
[32m+[m[32m            'driver' => 'redis',[m
[32m+[m[32m            'connection' => 'default',[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        'log' => [[m
[32m+[m[32m            'driver' => 'log',[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        'null' => [[m
[32m+[m[32m            'driver' => 'null',[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m    ],[m
[32m+[m
[32m+[m[32m];[m
[1mdiff --git a/config/cache.php b/config/cache.php[m
[1mnew file mode 100755[m
[1mindex 0000000..46751e6[m
[1m--- /dev/null[m
[1m+++ b/config/cache.php[m
[36m@@ -0,0 +1,103 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32muse Illuminate\Support\Str;[m
[32m+[m
[32m+[m[32mreturn [[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Default Cache Store[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | This option controls the default cache connection that gets used while[m
[32m+[m[32m    | using this caching library. This connection is used when another is[m
[32m+[m[32m    | not explicitly specified when executing a given caching function.[m
[32m+[m[32m    |[m
[32m+[m[32m    | Supported: "apc", "array", "database", "file",[m
[32m+[m[32m    |            "memcached", "redis", "dynamodb"[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'default' => env('CACHE_DRIVER', 'file'),[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Cache Stores[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | Here you may define all of the cache "stores" for your application as[m
[32m+[m[32m    | well as their drivers. You may even define multiple stores for the[m
[32m+[m[32m    | same cache driver to group types of items stored in your caches.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'stores' => [[m
[32m+[m
[32m+[m[32m        'apc' => [[m
[32m+[m[32m            'driver' => 'apc',[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        'array' => [[m
[32m+[m[32m            'driver' => 'array',[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        'database' => [[m
[32m+[m[32m            'driver' => 'database',[m
[32m+[m[32m            'table' => 'cache',[m
[32m+[m[32m            'connection' => null,[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        'file' => [[m
[32m+[m[32m            'driver' => 'file',[m
[32m+[m[32m            'path' => storage_path('framework/cache/data'),[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        'memcached' => [[m
[32m+[m[32m            'driver' => 'memcached',[m
[32m+[m[32m            'persistent_id' => env('MEMCACHED_PERSISTENT_ID'),[m
[32m+[m[32m            'sasl' => [[m
[32m+[m[32m                env('MEMCACHED_USERNAME'),[m
[32m+[m[32m                env('MEMCACHED_PASSWORD'),[m
[32m+[m[32m            ],[m
[32m+[m[32m            'options' => [[m
[32m+[m[32m                // Memcached::OPT_CONNECT_TIMEOUT => 2000,[m
[32m+[m[32m            ],[m
[32m+[m[32m            'servers' => [[m
[32m+[m[32m                [[m
[32m+[m[32m                    'host' => env('MEMCACHED_HOST', '127.0.0.1'),[m
[32m+[m[32m                    'port' => env('MEMCACHED_PORT', 11211),[m
[32m+[m[32m                    'weight' => 100,[m
[32m+[m[32m                ],[m
[32m+[m[32m            ],[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        'redis' => [[m
[32m+[m[32m            'driver' => 'redis',[m
[32m+[m[32m            'connection' => 'cache',[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        'dynamodb' => [[m
[32m+[m[32m            'driver' => 'dynamodb',[m
[32m+[m[32m            'key' => env('AWS_ACCESS_KEY_ID'),[m
[32m+[m[32m            'secret' => env('AWS_SECRET_ACCESS_KEY'),[m
[32m+[m[32m            'region' => env('AWS_DEFAULT_REGION', 'us-east-1'),[m
[32m+[m[32m            'table' => env('DYNAMODB_CACHE_TABLE', 'cache'),[m
[32m+[m[32m            'endpoint' => env('DYNAMODB_ENDPOINT'),[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m    ],[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Cache Key Prefix[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | When utilizing a RAM based store such as APC or Memcached, there might[m
[32m+[m[32m    | be other applications utilizing the same cache. So, we'll specify a[m
[32m+[m[32m    | value to get prefixed to all our keys so we can avoid collisions.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'prefix' => env('CACHE_PREFIX', Str::slug(env('APP_NAME', 'laravel'), '_').'_cache'),[m
[32m+[m
[32m+[m[32m];[m
[1mdiff --git a/config/database.php b/config/database.php[m
[1mnew file mode 100755[m
[1mindex 0000000..921769c[m
[1m--- /dev/null[m
[1m+++ b/config/database.php[m
[36m@@ -0,0 +1,147 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32muse Illuminate\Support\Str;[m
[32m+[m
[32m+[m[32mreturn [[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Default Database Connection Name[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | Here you may specify which of the database connections below you wish[m
[32m+[m[32m    | to use as your default connection for all database work. Of course[m
[32m+[m[32m    | you may use many connections at once using the Database library.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'default' => env('DB_CONNECTION', 'mysql'),[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Database Connections[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | Here are each of the database connections setup for your application.[m
[32m+[m[32m    | Of course, examples of configuring each database platform that is[m
[32m+[m[32m    | supported by Laravel is shown below to make development simple.[m
[32m+[m[32m    |[m
[32m+[m[32m    |[m
[32m+[m[32m    | All database work in Laravel is done through the PHP PDO facilities[m
[32m+[m[32m    | so make sure you have the driver for your particular database of[m
[32m+[m[32m    | choice installed on your machine before you begin development.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'connections' => [[m
[32m+[m
[32m+[m[32m        'sqlite' => [[m
[32m+[m[32m            'driver' => 'sqlite',[m
[32m+[m[32m            'url' => env('DATABASE_URL'),[m
[32m+[m[32m            'database' => env('DB_DATABASE', database_path('database.sqlite')),[m
[32m+[m[32m            'prefix' => '',[m
[32m+[m[32m            'foreign_key_constraints' => env('DB_FOREIGN_KEYS', true),[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        'mysql' => [[m
[32m+[m[32m            'driver' => 'mysql',[m
[32m+[m[32m            'url' => env('DATABASE_URL'),[m
[32m+[m[32m            'host' => env('DB_HOST', '127.0.0.1'),[m
[32m+[m[32m            'port' => env('DB_PORT', '3306'),[m
[32m+[m[32m            'database' => env('DB_DATABASE', 'forge'),[m
[32m+[m[32m            'username' => env('DB_USERNAME', 'forge'),[m
[32m+[m[32m            'password' => env('DB_PASSWORD', ''),[m
[32m+[m[32m            'unix_socket' => env('DB_SOCKET', ''),[m
[32m+[m[32m            'charset' => 'utf8mb4',[m
[32m+[m[32m            'collation' => 'utf8mb4_unicode_ci',[m
[32m+[m[32m            'prefix' => '',[m
[32m+[m[32m            'prefix_indexes' => true,[m
[32m+[m[32m            'strict' => true,[m
[32m+[m[32m            'engine' => null,[m
[32m+[m[32m            'options' => extension_loaded('pdo_mysql') ? array_filter([[m
[32m+[m[32m                PDO::MYSQL_ATTR_SSL_CA => env('MYSQL_ATTR_SSL_CA'),[m
[32m+[m[32m            ]) : [],[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        'pgsql' => [[m
[32m+[m[32m            'driver' => 'pgsql',[m
[32m+[m[32m            'url' => env('DATABASE_URL'),[m
[32m+[m[32m            'host' => env('DB_HOST', '127.0.0.1'),[m
[32m+[m[32m            'port' => env('DB_PORT', '5432'),[m
[32m+[m[32m            'database' => env('DB_DATABASE', 'forge'),[m
[32m+[m[32m            'username' => env('DB_USERNAME', 'forge'),[m
[32m+[m[32m            'password' => env('DB_PASSWORD', ''),[m
[32m+[m[32m            'charset' => 'utf8',[m
[32m+[m[32m            'prefix' => '',[m
[32m+[m[32m            'prefix_indexes' => true,[m
[32m+[m[32m            'schema' => 'public',[m
[32m+[m[32m            'sslmode' => 'prefer',[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        'sqlsrv' => [[m
[32m+[m[32m            'driver' => 'sqlsrv',[m
[32m+[m[32m            'url' => env('DATABASE_URL'),[m
[32m+[m[32m            'host' => env('DB_HOST', 'localhost'),[m
[32m+[m[32m            'port' => env('DB_PORT', '1433'),[m
[32m+[m[32m            'database' => env('DB_DATABASE', 'forge'),[m
[32m+[m[32m            'username' => env('DB_USERNAME', 'forge'),[m
[32m+[m[32m            'password' => env('DB_PASSWORD', ''),[m
[32m+[m[32m            'charset' => 'utf8',[m
[32m+[m[32m            'prefix' => '',[m
[32m+[m[32m            'prefix_indexes' => true,[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m    ],[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Migration Repository Table[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | This table keeps track of all the migrations that have already run for[m
[32m+[m[32m    | your application. Using this information, we can determine which of[m
[32m+[m[32m    | the migrations on disk haven't actually been run in the database.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'migrations' => 'migrations',[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Redis Databases[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | Redis is an open source, fast, and advanced key-value store that also[m
[32m+[m[32m    | provides a richer body of commands than a typical key-value system[m
[32m+[m[32m    | such as APC or Memcached. Laravel makes it easy to dig right in.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'redis' => [[m
[32m+[m
[32m+[m[32m        'client' => env('REDIS_CLIENT', 'predis'),[m
[32m+[m
[32m+[m[32m        'options' => [[m
[32m+[m[32m            'cluster' => env('REDIS_CLUSTER', 'predis'),[m
[32m+[m[32m            'prefix' => env('REDIS_PREFIX', Str::slug(env('APP_NAME', 'laravel'), '_').'_database_'),[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        'default' => [[m
[32m+[m[32m            'url' => env('REDIS_URL'),[m
[32m+[m[32m            'host' => env('REDIS_HOST', '127.0.0.1'),[m
[32m+[m[32m            'password' => env('REDIS_PASSWORD', null),[m
[32m+[m[32m            'port' => env('REDIS_PORT', 6379),[m
[32m+[m[32m            'database' => env('REDIS_DB', 0),[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        'cache' => [[m
[32m+[m[32m            'url' => env('REDIS_URL'),[m
[32m+[m[32m            'host' => env('REDIS_HOST', '127.0.0.1'),[m
[32m+[m[32m            'password' => env('REDIS_PASSWORD', null),[m
[32m+[m[32m            'port' => env('REDIS_PORT', 6379),[m
[32m+[m[32m            'database' => env('REDIS_CACHE_DB', 1),[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m    ],[m
[32m+[m
[32m+[m[32m];[m
[1mdiff --git a/config/filesystems.php b/config/filesystems.php[m
[1mnew file mode 100755[m
[1mindex 0000000..77fa5de[m
[1m--- /dev/null[m
[1m+++ b/config/filesystems.php[m
[36m@@ -0,0 +1,69 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mreturn [[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Default Filesystem Disk[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | Here you may specify the default filesystem disk that should be used[m
[32m+[m[32m    | by the framework. The "local" disk, as well as a variety of cloud[m
[32m+[m[32m    | based disks are available to your application. Just store away![m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'default' => env('FILESYSTEM_DRIVER', 'local'),[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Default Cloud Filesystem Disk[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | Many applications store files both locally and in the cloud. For this[m
[32m+[m[32m    | reason, you may specify a default "cloud" driver here. This driver[m
[32m+[m[32m    | will be bound as the Cloud disk implementation in the container.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'cloud' => env('FILESYSTEM_CLOUD', 's3'),[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Filesystem Disks[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | Here you may configure as many filesystem "disks" as you wish, and you[m
[32m+[m[32m    | may even configure multiple disks of the same driver. Defaults have[m
[32m+[m[32m    | been setup for each driver as an example of the required options.[m
[32m+[m[32m    |[m
[32m+[m[32m    | Supported Drivers: "local", "ftp", "sftp", "s3", "rackspace"[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'disks' => [[m
[32m+[m
[32m+[m[32m        'local' => [[m
[32m+[m[32m            'driver' => 'local',[m
[32m+[m[32m            'root' => storage_path('app'),[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        'public' => [[m
[32m+[m[32m            'driver' => 'local',[m
[32m+[m[32m            'root' => storage_path('app/public'),[m
[32m+[m[32m            'url' => env('APP_URL').'/storage',[m
[32m+[m[32m            'visibility' => 'public',[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        's3' => [[m
[32m+[m[32m            'driver' => 's3',[m
[32m+[m[32m            'key' => env('AWS_ACCESS_KEY_ID'),[m
[32m+[m[32m            'secret' => env('AWS_SECRET_ACCESS_KEY'),[m
[32m+[m[32m            'region' => env('AWS_DEFAULT_REGION'),[m
[32m+[m[32m            'bucket' => env('AWS_BUCKET'),[m
[32m+[m[32m            'url' => env('AWS_URL'),[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m    ],[m
[32m+[m
[32m+[m[32m];[m
[1mdiff --git a/config/hashing.php b/config/hashing.php[m
[1mnew file mode 100755[m
[1mindex 0000000..8425770[m
[1m--- /dev/null[m
[1m+++ b/config/hashing.php[m
[36m@@ -0,0 +1,52 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mreturn [[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Default Hash Driver[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | This option controls the default hash driver that will be used to hash[m
[32m+[m[32m    | passwords for your application. By default, the bcrypt algorithm is[m
[32m+[m[32m    | used; however, you remain free to modify this option if you wish.[m
[32m+[m[32m    |[m
[32m+[m[32m    | Supported: "bcrypt", "argon", "argon2id"[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'driver' => 'bcrypt',[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Bcrypt Options[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | Here you may specify the configuration options that should be used when[m
[32m+[m[32m    | passwords are hashed using the Bcrypt algorithm. This will allow you[m
[32m+[m[32m    | to control the amount of time it takes to hash the given password.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'bcrypt' => [[m
[32m+[m[32m        'rounds' => env('BCRYPT_ROUNDS', 10),[m
[32m+[m[32m    ],[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Argon Options[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | Here you may specify the configuration options that should be used when[m
[32m+[m[32m    | passwords are hashed using the Argon algorithm. These will allow you[m
[32m+[m[32m    | to control the amount of time it takes to hash the given password.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'argon' => [[m
[32m+[m[32m        'memory' => 1024,[m
[32m+[m[32m        'threads' => 2,[m
[32m+[m[32m        'time' => 2,[m
[32m+[m[32m    ],[m
[32m+[m
[32m+[m[32m];[m
[1mdiff --git a/config/logging.php b/config/logging.php[m
[1mnew file mode 100755[m
[1mindex 0000000..d09cd7d[m
[1m--- /dev/null[m
[1m+++ b/config/logging.php[m
[36m@@ -0,0 +1,94 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32muse Monolog\Handler\StreamHandler;[m
[32m+[m[32muse Monolog\Handler\SyslogUdpHandler;[m
[32m+[m
[32m+[m[32mreturn [[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Default Log Channel[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | This option defines the default log channel that gets used when writing[m
[32m+[m[32m    | messages to the logs. The name specified in this option should match[m
[32m+[m[32m    | one of the channels defined in the "channels" configuration array.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'default' => env('LOG_CHANNEL', 'stack'),[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Log Channels[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | Here you may configure the log channels for your application. Out of[m
[32m+[m[32m    | the box, Laravel uses the Monolog PHP logging library. This gives[m
[32m+[m[32m    | you a variety of powerful log handlers / formatters to utilize.[m
[32m+[m[32m    |[m
[32m+[m[32m    | Available Drivers: "single", "daily", "slack", "syslog",[m
[32m+[m[32m    |                    "errorlog", "monolog",[m
[32m+[m[32m    |                    "custom", "stack"[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'channels' => [[m
[32m+[m[32m        'stack' => [[m
[32m+[m[32m            'driver' => 'stack',[m
[32m+[m[32m            'channels' => ['daily'],[m
[32m+[m[32m            'ignore_exceptions' => false,[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        'single' => [[m
[32m+[m[32m            'driver' => 'single',[m
[32m+[m[32m            'path' => storage_path('logs/laravel.log'),[m
[32m+[m[32m            'level' => 'debug',[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        'daily' => [[m
[32m+[m[32m            'driver' => 'daily',[m
[32m+[m[32m            'path' => storage_path('logs/laravel.log'),[m
[32m+[m[32m            'level' => 'debug',[m
[32m+[m[32m            'days' => 14,[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        'slack' => [[m
[32m+[m[32m            'driver' => 'slack',[m
[32m+[m[32m            'url' => env('LOG_SLACK_WEBHOOK_URL'),[m
[32m+[m[32m            'username' => 'Laravel Log',[m
[32m+[m[32m            'emoji' => ':boom:',[m
[32m+[m[32m            'level' => 'critical',[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        'papertrail' => [[m
[32m+[m[32m            'driver' => 'monolog',[m
[32m+[m[32m            'level' => 'debug',[m
[32m+[m[32m            'handler' => SyslogUdpHandler::class,[m
[32m+[m[32m            'handler_with' => [[m
[32m+[m[32m                'host' => env('PAPERTRAIL_URL'),[m
[32m+[m[32m                'port' => env('PAPERTRAIL_PORT'),[m
[32m+[m[32m            ],[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        'stderr' => [[m
[32m+[m[32m            'driver' => 'monolog',[m
[32m+[m[32m            'handler' => StreamHandler::class,[m
[32m+[m[32m            'formatter' => env('LOG_STDERR_FORMATTER'),[m
[32m+[m[32m            'with' => [[m
[32m+[m[32m                'stream' => 'php://stderr',[m
[32m+[m[32m            ],[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        'syslog' => [[m
[32m+[m[32m            'driver' => 'syslog',[m
[32m+[m[32m            'level' => 'debug',[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        'errorlog' => [[m
[32m+[m[32m            'driver' => 'errorlog',[m
[32m+[m[32m            'level' => 'debug',[m
[32m+[m[32m        ],[m
[32m+[m[32m    ],[m
[32m+[m
[32m+[m[32m];[m
[1mdiff --git a/config/mail.php b/config/mail.php[m
[1mnew file mode 100755[m
[1mindex 0000000..6f8469f[m
[1m--- /dev/null[m
[1m+++ b/config/mail.php[m
[36m@@ -0,0 +1,136 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mreturn [[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Mail Driver[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | Laravel supports both SMTP and PHP's "mail" function as drivers for the[m
[32m+[m[32m    | sending of e-mail. You may specify which one you're using throughout[m
[32m+[m[32m    | your application here. By default, Laravel is setup for SMTP mail.[m
[32m+[m[32m    |[m
[32m+[m[32m    | Supported: "smtp", "sendmail", "mailgun", "mandrill", "ses",[m
[32m+[m[32m    |            "sparkpost", "postmark", "log", "array"[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'driver' => env('MAIL_DRIVER', 'smtp'),[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | SMTP Host Address[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | Here you may provide the host address of the SMTP server used by your[m
[32m+[m[32m    | applications. A default option is provided that is compatible with[m
[32m+[m[32m    | the Mailgun mail service which will provide reliable deliveries.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'host' => env('MAIL_HOST', 'smtp.mailgun.org'),[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | SMTP Host Port[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | This is the SMTP port used by your application to deliver e-mails to[m
[32m+[m[32m    | users of the application. Like the host we have set this value to[m
[32m+[m[32m    | stay compatible with the Mailgun e-mail application by default.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'port' => env('MAIL_PORT', 587),[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Global "From" Address[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | You may wish for all e-mails sent by your application to be sent from[m
[32m+[m[32m    | the same address. Here, you may specify a name and address that is[m
[32m+[m[32m    | used globally for all e-mails that are sent by your application.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'from' => [[m
[32m+[m[32m        'address' => env('MAIL_FROM_ADDRESS', 'hello@example.com'),[m
[32m+[m[32m        'name' => env('MAIL_FROM_NAME', 'Example'),[m
[32m+[m[32m    ],[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | E-Mail Encryption Protocol[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | Here you may specify the encryption protocol that should be used when[m
[32m+[m[32m    | the application send e-mail messages. A sensible default using the[m
[32m+[m[32m    | transport layer security protocol should provide great security.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'encryption' => env('MAIL_ENCRYPTION', 'tls'),[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | SMTP Server Username[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | If your SMTP server requires a username for authentication, you should[m
[32m+[m[32m    | set it here. This will get used to authenticate with your server on[m
[32m+[m[32m    | connection. You may also set the "password" value below this one.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'username' => env('MAIL_USERNAME'),[m
[32m+[m
[32m+[m[32m    'password' => env('MAIL_PASSWORD'),[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Sendmail System Path[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | When using the "sendmail" driver to send e-mails, we will need to know[m
[32m+[m[32m    | the path to where Sendmail lives on this server. A default path has[m
[32m+[m[32m    | been provided here, which will work well on most of your systems.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'sendmail' => '/usr/sbin/sendmail -bs',[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Markdown Mail Settings[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | If you are using Markdown based email rendering, you may configure your[m
[32m+[m[32m    | theme and component paths here, allowing you to customize the design[m
[32m+[m[32m    | of the emails. Or, you may simply stick with the Laravel defaults![m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'markdown' => [[m
[32m+[m[32m        'theme' => 'default',[m
[32m+[m
[32m+[m[32m        'paths' => [[m
[32m+[m[32m            resource_path('views/vendor/mail'),[m
[32m+[m[32m        ],[m
[32m+[m[32m    ],[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Log Channel[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | If you are using the "log" driver, you may specify the logging channel[m
[32m+[m[32m    | if you prefer to keep mail messages separate from other log entries[m
[32m+[m[32m    | for simpler reading. Otherwise, the default channel will be used.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'log_channel' => env('MAIL_LOG_CHANNEL'),[m
[32m+[m
[32m+[m[32m];[m
[1mdiff --git a/config/queue.php b/config/queue.php[m
[1mnew file mode 100755[m
[1mindex 0000000..07c7d2a[m
[1m--- /dev/null[m
[1m+++ b/config/queue.php[m
[36m@@ -0,0 +1,87 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mreturn [[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Default Queue Connection Name[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | Laravel's queue API supports an assortment of back-ends via a single[m
[32m+[m[32m    | API, giving you convenient access to each back-end using the same[m
[32m+[m[32m    | syntax for every one. Here you may define a default connection.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'default' => env('QUEUE_CONNECTION', 'sync'),[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Queue Connections[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | Here you may configure the connection information for each server that[m
[32m+[m[32m    | is used by your application. A default configuration has been added[m
[32m+[m[32m    | for each back-end shipped with Laravel. You are free to add more.[m
[32m+[m[32m    |[m
[32m+[m[32m    | Drivers: "sync", "database", "beanstalkd", "sqs", "redis", "null"[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'connections' => [[m
[32m+[m
[32m+[m[32m        'sync' => [[m
[32m+[m[32m            'driver' => 'sync',[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        'database' => [[m
[32m+[m[32m            'driver' => 'database',[m
[32m+[m[32m            'table' => 'jobs',[m
[32m+[m[32m            'queue' => 'default',[m
[32m+[m[32m            'retry_after' => 90,[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        'beanstalkd' => [[m
[32m+[m[32m            'driver' => 'beanstalkd',[m
[32m+[m[32m            'host' => 'localhost',[m
[32m+[m[32m            'queue' => 'default',[m
[32m+[m[32m            'retry_after' => 90,[m
[32m+[m[32m            'block_for' => 0,[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        'sqs' => [[m
[32m+[m[32m            'driver' => 'sqs',[m
[32m+[m[32m            'key' => env('AWS_ACCESS_KEY_ID'),[m
[32m+[m[32m            'secret' => env('AWS_SECRET_ACCESS_KEY'),[m
[32m+[m[32m            'prefix' => env('SQS_PREFIX', 'https://sqs.us-east-1.amazonaws.com/your-account-id'),[m
[32m+[m[32m            'queue' => env('SQS_QUEUE', 'your-queue-name'),[m
[32m+[m[32m            'region' => env('AWS_DEFAULT_REGION', 'us-east-1'),[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m        'redis' => [[m
[32m+[m[32m            'driver' => 'redis',[m
[32m+[m[32m            'connection' => 'default',[m
[32m+[m[32m            'queue' => env('REDIS_QUEUE', 'default'),[m
[32m+[m[32m            'retry_after' => 90,[m
[32m+[m[32m            'block_for' => null,[m
[32m+[m[32m        ],[m
[32m+[m
[32m+[m[32m    ],[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Failed Queue Jobs[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | These options configure the behavior of failed queue job logging so you[m
[32m+[m[32m    | can control which database and table are used to store the jobs that[m
[32m+[m[32m    | have failed. You may change them to any database / table you wish.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'failed' => [[m
[32m+[m[32m        'database' => env('DB_CONNECTION', 'mysql'),[m
[32m+[m[32m        'table' => 'failed_jobs',[m
[32m+[m[32m    ],[m
[32m+[m
[32m+[m[32m];[m
[1mdiff --git a/config/services.php b/config/services.php[m
[1mnew file mode 100755[m
[1mindex 0000000..8ce6cc6[m
[1m--- /dev/null[m
[1m+++ b/config/services.php[m
[36m@@ -0,0 +1,37 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mreturn [[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Third Party Services[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | This file is for storing the credentials for third party services such[m
[32m+[m[32m    | as Mailgun, SparkPost and others. This file provides a sane default[m
[32m+[m[32m    | location for this type of information, allowing packages to have[m
[32m+[m[32m    | a conventional file to locate the various service credentials.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'mailgun' => [[m
[32m+[m[32m        'domain' => env('MAILGUN_DOMAIN'),[m
[32m+[m[32m        'secret' => env('MAILGUN_SECRET'),[m
[32m+[m[32m        'endpoint' => env('MAILGUN_ENDPOINT', 'api.mailgun.net'),[m
[32m+[m[32m    ],[m
[32m+[m
[32m+[m[32m    'postmark' => [[m
[32m+[m[32m        'token' => env('POSTMARK_TOKEN'),[m
[32m+[m[32m    ],[m
[32m+[m
[32m+[m[32m    'ses' => [[m
[32m+[m[32m        'key' => env('AWS_ACCESS_KEY_ID'),[m
[32m+[m[32m        'secret' => env('AWS_SECRET_ACCESS_KEY'),[m
[32m+[m[32m        'region' => env('AWS_DEFAULT_REGION', 'us-east-1'),[m
[32m+[m[32m    ],[m
[32m+[m
[32m+[m[32m    'sparkpost' => [[m
[32m+[m[32m        'secret' => env('SPARKPOST_SECRET'),[m
[32m+[m[32m    ],[m
[32m+[m
[32m+[m[32m];[m
[1mdiff --git a/config/session.php b/config/session.php[m
[1mnew file mode 100755[m
[1mindex 0000000..fbb9b4d[m
[1m--- /dev/null[m
[1m+++ b/config/session.php[m
[36m@@ -0,0 +1,199 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32muse Illuminate\Support\Str;[m
[32m+[m
[32m+[m[32mreturn [[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Default Session Driver[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | This option controls the default session "driver" that will be used on[m
[32m+[m[32m    | requests. By default, we will use the lightweight native driver but[m
[32m+[m[32m    | you may specify any of the other wonderful drivers provided here.[m
[32m+[m[32m    |[m
[32m+[m[32m    | Supported: "file", "cookie", "database", "apc",[m
[32m+[m[32m    |            "memcached", "redis", "dynamodb", "array"[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'driver' => env('SESSION_DRIVER', 'file'),[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Session Lifetime[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | Here you may specify the number of minutes that you wish the session[m
[32m+[m[32m    | to be allowed to remain idle before it expires. If you want them[m
[32m+[m[32m    | to immediately expire on the browser closing, set that option.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'lifetime' => env('SESSION_LIFETIME', 120),[m
[32m+[m
[32m+[m[32m    'expire_on_close' => false,[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Session Encryption[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | This option allows you to easily specify that all of your session data[m
[32m+[m[32m    | should be encrypted before it is stored. All encryption will be run[m
[32m+[m[32m    | automatically by Laravel and you can use the Session like normal.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'encrypt' => false,[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Session File Location[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | When using the native session driver, we need a location where session[m
[32m+[m[32m    | files may be stored. A default has been set for you but a different[m
[32m+[m[32m    | location may be specified. This is only needed for file sessions.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'files' => storage_path('framework/sessions'),[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Session Database Connection[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | When using the "database" or "redis" session drivers, you may specify a[m
[32m+[m[32m    | connection that should be used to manage these sessions. This should[m
[32m+[m[32m    | correspond to a connection in your database configuration options.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'connection' => env('SESSION_CONNECTION', null),[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Session Database Table[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | When using the "database" session driver, you may specify the table we[m
[32m+[m[32m    | should use to manage the sessions. Of course, a sensible default is[m
[32m+[m[32m    | provided for you; however, you are free to change this as needed.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'table' => 'sessions',[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Session Cache Store[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | When using the "apc", "memcached", or "dynamodb" session drivers you may[m
[32m+[m[32m    | list a cache store that should be used for these sessions. This value[m
[32m+[m[32m    | must match with one of the application's configured cache "stores".[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'store' => env('SESSION_STORE', null),[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Session Sweeping Lottery[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | Some session drivers must manually sweep their storage location to get[m
[32m+[m[32m    | rid of old sessions from storage. Here are the chances that it will[m
[32m+[m[32m    | happen on a given request. By default, the odds are 2 out of 100.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'lottery' => [2, 100],[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Session Cookie Name[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | Here you may change the name of the cookie used to identify a session[m
[32m+[m[32m    | instance by ID. The name specified here will get used every time a[m
[32m+[m[32m    | new session cookie is created by the framework for every driver.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'cookie' => env([m
[32m+[m[32m        'SESSION_COOKIE',[m
[32m+[m[32m        Str::slug(env('APP_NAME', 'laravel'), '_').'_session'[m
[32m+[m[32m    ),[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Session Cookie Path[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | The session cookie path determines the path for which the cookie will[m
[32m+[m[32m    | be regarded as available. Typically, this will be the root path of[m
[32m+[m[32m    | your application but you are free to change this when necessary.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'path' => '/',[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Session Cookie Domain[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | Here you may change the domain of the cookie used to identify a session[m
[32m+[m[32m    | in your application. This will determine which domains the cookie is[m
[32m+[m[32m    | available to in your application. A sensible default has been set.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'domain' => env('SESSION_DOMAIN', null),[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | HTTPS Only Cookies[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | By setting this option to true, session cookies will only be sent back[m
[32m+[m[32m    | to the server if the browser has a HTTPS connection. This will keep[m
[32m+[m[32m    | the cookie from being sent to you if it can not be done securely.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'secure' => env('SESSION_SECURE_COOKIE', false),[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | HTTP Access Only[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | Setting this value to true will prevent JavaScript from accessing the[m
[32m+[m[32m    | value of the cookie and the cookie will only be accessible through[m
[32m+[m[32m    | the HTTP protocol. You are free to modify this option if needed.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'http_only' => true,[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Same-Site Cookies[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | This option determines how your cookies behave when cross-site requests[m
[32m+[m[32m    | take place, and can be used to mitigate CSRF attacks. By default, we[m
[32m+[m[32m    | do not enable this as other CSRF protection services are in place.[m
[32m+[m[32m    |[m
[32m+[m[32m    | Supported: "lax", "strict"[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'same_site' => null,[m
[32m+[m
[32m+[m[32m];[m
[1mdiff --git a/config/status.php b/config/status.php[m
[1mnew file mode 100755[m
[1mindex 0000000..b6efc3d[m
[1m--- /dev/null[m
[1m+++ b/config/status.php[m
[36m@@ -0,0 +1,62 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mreturn [[m
[32m+[m[32m    'status_code' => [[m
[32m+[m[32m        100 => 'Continue',[m
[32m+[m[32m        101 => 'Switching Protocols',[m
[32m+[m[32m        102 => 'Processing',[m
[32m+[m[32m        103 => 'Checkpoint',[m
[32m+[m[32m        200 => 'OK',[m
[32m+[m[32m        201 => 'Created',[m
[32m+[m[32m        202 => 'Accepted',[m
[32m+[m[32m        203 => 'Non-Authoritative Information',[m
[32m+[m[32m        204 => 'No Content',[m
[32m+[m[32m        205 => 'Reset Content',[m
[32m+[m[32m        206 => 'Partial Content',[m
[32m+[m[32m        207 => 'Multi-Status',[m
[32m+[m[32m        300 => 'Multiple Choices',[m
[32m+[m[32m        301 => 'Moved Permanently',[m
[32m+[m[32m        302 => 'Found',[m
[32m+[m[32m        303 => 'See Other',[m
[32m+[m[32m        304 => 'Not Modified',[m
[32m+[m[32m        305 => 'Use Proxy',[m
[32m+[m[32m        306 => 'Switch Proxy',[m
[32m+[m[32m        307 => 'Temporary Redirect',[m
[32m+[m[32m        400 => 'Bad Request',[m
[32m+[m[32m        401 => 'Unauthorized',[m
[32m+[m[32m        402 => 'Payment Required',[m
[32m+[m[32m        403 => 'Forbidden',[m
[32m+[m[32m        404 => 'Not Found',[m
[32m+[m[32m        405 => 'Method Not Allowed',[m
[32m+[m[32m        406 => 'Not Acceptable',[m
[32m+[m[32m        407 => 'Proxy Authentication Required',[m
[32m+[m[32m        408 => 'Request Timeout',[m
[32m+[m[32m        409 => 'Conflict',[m
[32m+[m[32m        410 => 'Gone',[m
[32m+[m[32m        411 => 'Length Required',[m
[32m+[m[32m        412 => 'Precondition Failed',[m
[32m+[m[32m        413 => 'Request Entity Too Large',[m
[32m+[m[32m        414 => 'Request-URI Too Long',[m
[32m+[m[32m        415 => 'Unsupported Media Type',[m
[32m+[m[32m        416 => 'Requested Range Not Satisfiable',[m
[32m+[m[32m        417 => 'Expectation Failed',[m
[32m+[m[32m        418 => 'I\'m a teapot',[m
[32m+[m[32m        422 => 'Unprocessable Entity',[m
[32m+[m[32m        423 => 'Locked',[m
[32m+[m[32m        424 => 'Failed Dependency',[m
[32m+[m[32m        425 => 'Unordered Collection',[m
[32m+[m[32m        426 => 'Upgrade Required',[m
[32m+[m[32m        449 => 'Retry With',[m
[32m+[m[32m        450 => 'Blocked by Windows Parental Controls',[m
[32m+[m[32m        500 => 'Internal Server Error',[m
[32m+[m[32m        501 => 'Not Implemented',[m
[32m+[m[32m        502 => 'Bad Gateway',[m
[32m+[m[32m        503 => 'Service Unavailable',[m
[32m+[m[32m        504 => 'Gateway Timeout',[m
[32m+[m[32m        505 => 'HTTP Version Not Supported',[m
[32m+[m[32m        506 => 'Variant Also Negotiates',[m
[32m+[m[32m        507 => 'Insufficient Storage',[m
[32m+[m[32m        509 => 'Bandwidth Limit Exceeded',[m
[32m+[m[32m        510 => 'Not Extended'[m
[32m+[m[32m    ][m
[32m+[m[32m];[m
[1mdiff --git a/config/view.php b/config/view.php[m
[1mnew file mode 100755[m
[1mindex 0000000..22b8a18[m
[1m--- /dev/null[m
[1m+++ b/config/view.php[m
[36m@@ -0,0 +1,36 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mreturn [[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | View Storage Paths[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | Most templating systems load templates from disk. Here you may specify[m
[32m+[m[32m    | an array of paths that should be checked for your views. Of course[m
[32m+[m[32m    | the usual Laravel view path has already been registered for you.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'paths' => [[m
[32m+[m[32m        resource_path('views'),[m
[32m+[m[32m    ],[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Compiled View Path[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | This option determines where all the compiled Blade templates will be[m
[32m+[m[32m    | stored for your application. Typically, this is within the storage[m
[32m+[m[32m    | directory. However, as usual, you are free to change this value.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'compiled' => env([m
[32m+[m[32m        'VIEW_COMPILED_PATH',[m
[32m+[m[32m        realpath(storage_path('framework/views'))[m
[32m+[m[32m    ),[m
[32m+[m
[32m+[m[32m];[m
[1mdiff --git a/database/.gitignore b/database/.gitignore[m
[1mnew file mode 100755[m
[1mindex 0000000..97fc976[m
[1m--- /dev/null[m
[1m+++ b/database/.gitignore[m
[36m@@ -0,0 +1,2 @@[m
[32m+[m[32m*.sqlite[m
[32m+[m[32m*.sqlite-journal[m
[1mdiff --git a/database/factories/ArticleFactory.php b/database/factories/ArticleFactory.php[m
[1mnew file mode 100644[m
[1mindex 0000000..cb9ac64[m
[1m--- /dev/null[m
[1m+++ b/database/factories/ArticleFactory.php[m
[36m@@ -0,0 +1,12 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32m/** @var \Illuminate\Database\Eloquent\Factory $factory */[m
[32m+[m
[32m+[m[32muse App\Models\Article;[m
[32m+[m[32muse Faker\Generator as Faker;[m
[32m+[m
[32m+[m[32m$factory->define(Article::class, function (Faker $faker) {[m
[32m+[m[32m    return [[m
[32m+[m[32m        //[m
[32m+[m[32m    ];[m
[32m+[m[32m});[m
[1mdiff --git a/database/factories/CategoryFactory.php b/database/factories/CategoryFactory.php[m
[1mnew file mode 100644[m
[1mindex 0000000..aacb071[m
[1m--- /dev/null[m
[1m+++ b/database/factories/CategoryFactory.php[m
[36m@@ -0,0 +1,12 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32m/** @var \Illuminate\Database\Eloquent\Factory $factory */[m
[32m+[m
[32m+[m[32muse App\Models\Category;[m
[32m+[m[32muse Faker\Generator as Faker;[m
[32m+[m
[32m+[m[32m$factory->define(Category::class, function (Faker $faker) {[m
[32m+[m[32m    return [[m
[32m+[m[32m        //[m
[32m+[m[32m    ];[m
[32m+[m[32m});[m
[1mdiff --git a/database/factories/CommentFactory.php b/database/factories/CommentFactory.php[m
[1mnew file mode 100644[m
[1mindex 0000000..1660027[m
[1m--- /dev/null[m
[1m+++ b/database/factories/CommentFactory.php[m
[36m@@ -0,0 +1,12 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32m/** @var \Illuminate\Database\Eloquent\Factory $factory */[m
[32m+[m
[32m+[m[32muse App\Models\Comment;[m
[32m+[m[32muse Faker\Generator as Faker;[m
[32m+[m
[32m+[m[32m$factory->define(Comment::class, function (Faker $faker) {[m
[32m+[m[32m    return [[m
[32m+[m[32m        //[m
[32m+[m[32m    ];[m
[32m+[m[32m});[m
[1mdiff --git a/database/factories/MediaFactory.php b/database/factories/MediaFactory.php[m
[1mnew file mode 100644[m
[1mindex 0000000..e0569ef[m
[1m--- /dev/null[m
[1m+++ b/database/factories/MediaFactory.php[m
[36m@@ -0,0 +1,12 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32m/** @var \Illuminate\Database\Eloquent\Factory $factory */[m
[32m+[m
[32m+[m[32muse App\Models\Media;[m
[32m+[m[32muse Faker\Generator as Faker;[m
[32m+[m
[32m+[m[32m$factory->define(Media::class, function (Faker $faker) {[m
[32m+[m[32m    return [[m
[32m+[m[32m        //[m
[32m+[m[32m    ];[m
[32m+[m[32m});[m
[1mdiff --git a/database/factories/PageFactory.php b/database/factories/PageFactory.php[m
[1mnew file mode 100644[m
[1mindex 0000000..0684466[m
[1m--- /dev/null[m
[1m+++ b/database/factories/PageFactory.php[m
[36m@@ -0,0 +1,12 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32m/** @var \Illuminate\Database\Eloquent\Factory $factory */[m
[32m+[m
[32m+[m[32muse App\Models\Page;[m
[32m+[m[32muse Faker\Generator as Faker;[m
[32m+[m
[32m+[m[32m$factory->define(Page::class, function (Faker $faker) {[m
[32m+[m[32m    return [[m
[32m+[m[32m        //[m
[32m+[m[32m    ];[m
[32m+[m[32m});[m
[1mdiff --git a/database/factories/PermissionFactory.php b/database/factories/PermissionFactory.php[m
[1mnew file mode 100755[m
[1mindex 0000000..233f91e[m
[1m--- /dev/null[m
[1m+++ b/database/factories/PermissionFactory.php[m
[36m@@ -0,0 +1,12 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32m/** @var \Illuminate\Database\Eloquent\Factory $factory */[m
[32m+[m
[32m+[m[32muse App\Permission;[m
[32m+[m[32muse Faker\Generator as Faker;[m
[32m+[m
[32m+[m[32m$factory->define(Permission::class, function (Faker $faker) {[m
[32m+[m[32m    return [[m
[32m+[m[32m        //[m
[32m+[m[32m    ];[m
[32m+[m[32m});[m
[1mdiff --git a/database/factories/QuizFactory.php b/database/factories/QuizFactory.php[m
[1mnew file mode 100644[m
[1mindex 0000000..ac7e82e[m
[1m--- /dev/null[m
[1m+++ b/database/factories/QuizFactory.php[m
[36m@@ -0,0 +1,12 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32m/** @var \Illuminate\Database\Eloquent\Factory $factory */[m
[32m+[m
[32m+[m[32muse App\Models\Quiz;[m
[32m+[m[32muse Faker\Generator as Faker;[m
[32m+[m
[32m+[m[32m$factory->define(Quiz::class, function (Faker $faker) {[m
[32m+[m[32m    return [[m
[32m+[m[32m        //[m
[32m+[m[32m    ];[m
[32m+[m[32m});[m
[1mdiff --git a/database/factories/QuizFormFactory.php b/database/factories/QuizFormFactory.php[m
[1mnew file mode 100644[m
[1mindex 0000000..d6eaebf[m
[1m--- /dev/null[m
[1m+++ b/database/factories/QuizFormFactory.php[m
[36m@@ -0,0 +1,12 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32m/** @var \Illuminate\Database\Eloquent\Factory $factory */[m
[32m+[m
[32m+[m[32muse App\Models\QuizForm;[m
[32m+[m[32muse Faker\Generator as Faker;[m
[32m+[m
[32m+[m[32m$factory->define(QuizForm::class, function (Faker $faker) {[m
[32m+[m[32m    return [[m
[32m+[m[32m        //[m
[32m+[m[32m    ];[m
[32m+[m[32m});[m
[1mdiff --git a/database/factories/QuizFormFieldFactory.php b/database/factories/QuizFormFieldFactory.php[m
[1mnew file mode 100644[m
[1mindex 0000000..1ba7cb7[m
[1m--- /dev/null[m
[1m+++ b/database/factories/QuizFormFieldFactory.php[m
[36m@@ -0,0 +1,12 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32m/** @var \Illuminate\Database\Eloquent\Factory $factory */[m
[32m+[m
[32m+[m[32muse App\Models\QuizFormField;[m
[32m+[m[32muse Faker\Generator as Faker;[m
[32m+[m
[32m+[m[32m$factory->define(QuizFormField::class, function (Faker $faker) {[m
[32m+[m[32m    return [[m
[32m+[m[32m        //[m
[32m+[m[32m    ];[m
[32m+[m[32m});[m
[1mdiff --git a/database/factories/RoleFactory.php b/database/factories/RoleFactory.php[m
[1mnew file mode 100755[m
[1mindex 0000000..5dee1f7[m
[1m--- /dev/null[m
[1m+++ b/database/factories/RoleFactory.php[m
[36m@@ -0,0 +1,12 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32m/** @var \Illuminate\Database\Eloquent\Factory $factory */[m
[32m+[m
[32m+[m[32muse App\Role;[m
[32m+[m[32muse Faker\Generator as Faker;[m
[32m+[m
[32m+[m[32m$factory->define(Role::class, function (Faker $faker) {[m
[32m+[m[32m    return [[m
[32m+[m[32m        //[m
[32m+[m[32m    ];[m
[32m+[m[32m});[m
[1mdiff --git a/database/factories/TeamFactory.php b/database/factories/TeamFactory.php[m
[1mnew file mode 100644[m
[1mindex 0000000..ad4deda[m
[1m--- /dev/null[m
[1m+++ b/database/factories/TeamFactory.php[m
[36m@@ -0,0 +1,12 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32m/** @var \Illuminate\Database\Eloquent\Factory $factory */[m
[32m+[m
[32m+[m[32muse App\Models\Team;[m
[32m+[m[32muse Faker\Generator as Faker;[m
[32m+[m
[32m+[m[32m$factory->define(Team::class, function (Faker $faker) {[m
[32m+[m[32m    return [[m
[32m+[m[32m        //[m
[32m+[m[32m    ];[m
[32m+[m[32m});[m
[1mdiff --git a/database/factories/UserFactory.php b/database/factories/UserFactory.php[m
[1mnew file mode 100755[m
[1mindex 0000000..0a7f70c[m
[1m--- /dev/null[m
[1m+++ b/database/factories/UserFactory.php[m
[36m@@ -0,0 +1,25 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32m/** @var \Illuminate\Database\Eloquent\Factory $factory */[m
[32m+[m[32muse App\User;[m
[32m+[m[32muse Illuminate\Support\Str;[m
[32m+[m[32muse Faker\Generator as Faker;[m
[32m+[m
[32m+[m[32m/*[m
[32m+[m[32m|--------------------------------------------------------------------------[m
[32m+[m[32m| Model Factories[m
[32m+[m[32m|--------------------------------------------------------------------------[m
[32m+[m[32m|[m
[32m+[m[32m| This directory should contain each of the model factory definitions for[m
[32m+[m[32m| your application. Factories provide a convenient way to generate new[m
[32m+[m[32m| model instances for testing / seeding your application's database.[m
[32m+[m[32m|[m
[32m+[m[32m*/[m
[32m+[m
[32m+[m[32m$factory->define(User::class, function (Faker $faker) {[m
[32m+[m[32m    return [[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m    ];[m
[32m+[m[32m});[m
[1mdiff --git a/database/migrations/2014_10_12_000000_create_users_table.php b/database/migrations/2014_10_12_000000_create_users_table.php[m
[1mnew file mode 100755[m
[1mindex 0000000..124bef8[m
[1m--- /dev/null[m
[1m+++ b/database/migrations/2014_10_12_000000_create_users_table.php[m
[36m@@ -0,0 +1,39 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32muse Illuminate\Support\Facades\Schema;[m
[32m+[m[32muse Illuminate\Database\Schema\Blueprint;[m
[32m+[m[32muse Illuminate\Database\Migrations\Migration;[m
[32m+[m
[32m+[m[32mclass CreateUsersTable extends Migration[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Run the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function up()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::create('users', function (Blueprint $table) {[m
[32m+[m[32m            $table->uuid('id')->primary();[m
[32m+[m[32m            $table->string('username')->index()->unique();[m
[32m+[m[32m            $table->string('first_name')->index()->nullable();[m
[32m+[m[32m            $table->string('last_name')->nullable();[m
[32m+[m[32m            $table->string('slug')->nullable();[m
[32m+[m[32m            $table->string('email')->index()->unique();[m
[32m+[m[32m            $table->timestamp('email_verified_at')->nullable();[m
[32m+[m[32m            $table->string('password');[m
[32m+[m[32m            $table->rememberToken();[m
[32m+[m[32m            $table->timestamps();[m
[32m+[m[32m        });[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Reverse the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function down()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::dropIfExists('users');[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/database/migrations/2014_10_12_100000_create_password_resets_table.php b/database/migrations/2014_10_12_100000_create_password_resets_table.php[m
[1mnew file mode 100755[m
[1mindex 0000000..0d5cb84[m
[1m--- /dev/null[m
[1m+++ b/database/migrations/2014_10_12_100000_create_password_resets_table.php[m
[36m@@ -0,0 +1,32 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32muse Illuminate\Support\Facades\Schema;[m
[32m+[m[32muse Illuminate\Database\Schema\Blueprint;[m
[32m+[m[32muse Illuminate\Database\Migrations\Migration;[m
[32m+[m
[32m+[m[32mclass CreatePasswordResetsTable extends Migration[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Run the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function up()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::create('password_resets', function (Blueprint $table) {[m
[32m+[m[32m            $table->string('email')->index();[m
[32m+[m[32m            $table->string('token');[m
[32m+[m[32m            $table->timestamp('created_at')->nullable();[m
[32m+[m[32m        });[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Reverse the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function down()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::dropIfExists('password_resets');[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/database/migrations/2020_11_04_065422_create_permissions_table.php b/database/migrations/2020_11_04_065422_create_permissions_table.php[m
[1mnew file mode 100755[m
[1mindex 0000000..19b4536[m
[1m--- /dev/null[m
[1m+++ b/database/migrations/2020_11_04_065422_create_permissions_table.php[m
[36m@@ -0,0 +1,33 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32muse Illuminate\Support\Facades\Schema;[m
[32m+[m[32muse Illuminate\Database\Schema\Blueprint;[m
[32m+[m[32muse Illuminate\Database\Migrations\Migration;[m
[32m+[m
[32m+[m[32mclass CreatePermissionsTable extends Migration[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Run the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function up()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::create('permissions', function (Blueprint $table) {[m
[32m+[m[32m            $table->bigIncrements('id');[m
[32m+[m[32m            $table->string('name');[m
[32m+[m[32m            $table->string('slug');[m
[32m+[m[32m            $table->timestamps();[m
[32m+[m[32m        });[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Reverse the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function down()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::dropIfExists('permissions');[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/database/migrations/2020_11_04_065435_create_roles_table.php b/database/migrations/2020_11_04_065435_create_roles_table.php[m
[1mnew file mode 100755[m
[1mindex 0000000..fa60c74[m
[1m--- /dev/null[m
[1m+++ b/database/migrations/2020_11_04_065435_create_roles_table.php[m
[36m@@ -0,0 +1,33 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32muse Illuminate\Support\Facades\Schema;[m
[32m+[m[32muse Illuminate\Database\Schema\Blueprint;[m
[32m+[m[32muse Illuminate\Database\Migrations\Migration;[m
[32m+[m
[32m+[m[32mclass CreateRolesTable extends Migration[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Run the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function up()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::create('roles', function (Blueprint $table) {[m
[32m+[m[32m            $table->bigIncrements('id');[m
[32m+[m[32m            $table->string('name');[m
[32m+[m[32m            $table->string('slug');[m
[32m+[m[32m            $table->timestamps();[m
[32m+[m[32m        });[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Reverse the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function down()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::dropIfExists('roles');[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/database/migrations/2020_11_04_065650_create_users_permissions_table.php b/database/migrations/2020_11_04_065650_create_users_permissions_table.php[m
[1mnew file mode 100755[m
[1mindex 0000000..7253f92[m
[1m--- /dev/null[m
[1m+++ b/database/migrations/2020_11_04_065650_create_users_permissions_table.php[m
[36m@@ -0,0 +1,38 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32muse Illuminate\Support\Facades\Schema;[m
[32m+[m[32muse Illuminate\Database\Schema\Blueprint;[m
[32m+[m[32muse Illuminate\Database\Migrations\Migration;[m
[32m+[m
[32m+[m[32mclass CreateUsersPermissionsTable extends Migration[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Run the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function up()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::create('users_permissions', function (Blueprint $table) {[m
[32m+[m[32m            $table->uuid('user_id');[m
[32m+[m[32m            $table->unsignedBigInteger('permission_id');[m
[32m+[m
[32m+[m[32m            //FOREIGN KEY CONSTRAINTS[m
[32m+[m[32m            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');[m
[32m+[m[32m            $table->foreign('permission_id')->references('id')->on('permissions')->onDelete('cascade');[m
[32m+[m
[32m+[m[32m            //SETTING THE PRIMARY KEYS[m
[32m+[m[32m            $table->primary(['user_id','permission_id']);[m
[32m+[m[32m        });[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Reverse the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function down()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::dropIfExists('users_permissions');[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/database/migrations/2020_11_04_065741_create_users_roles_table.php b/database/migrations/2020_11_04_065741_create_users_roles_table.php[m
[1mnew file mode 100755[m
[1mindex 0000000..91f68b5[m
[1m--- /dev/null[m
[1m+++ b/database/migrations/2020_11_04_065741_create_users_roles_table.php[m
[36m@@ -0,0 +1,38 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32muse Illuminate\Support\Facades\Schema;[m
[32m+[m[32muse Illuminate\Database\Schema\Blueprint;[m
[32m+[m[32muse Illuminate\Database\Migrations\Migration;[m
[32m+[m
[32m+[m[32mclass CreateUsersRolesTable extends Migration[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Run the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function up()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::create('users_roles', function (Blueprint $table) {[m
[32m+[m[32m            $table->uuid('user_id');[m
[32m+[m[32m            $table->unsignedBigInteger('role_id');[m
[32m+[m
[32m+[m[32m            //FOREIGN KEY CONSTRAINTS[m
[32m+[m[32m            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');[m
[32m+[m[32m            $table->foreign('role_id')->references('id')->on('roles')->onDelete('cascade');[m
[32m+[m
[32m+[m[32m            //SETTING THE PRIMARY KEYS[m
[32m+[m[32m            $table->primary(['user_id','role_id']);[m
[32m+[m[32m        });[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Reverse the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function down()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::dropIfExists('users_roles');[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/database/migrations/2020_11_04_065824_create_roles_permissions_table.php b/database/migrations/2020_11_04_065824_create_roles_permissions_table.php[m
[1mnew file mode 100755[m
[1mindex 0000000..2291041[m
[1m--- /dev/null[m
[1m+++ b/database/migrations/2020_11_04_065824_create_roles_permissions_table.php[m
[36m@@ -0,0 +1,38 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32muse Illuminate\Support\Facades\Schema;[m
[32m+[m[32muse Illuminate\Database\Schema\Blueprint;[m
[32m+[m[32muse Illuminate\Database\Migrations\Migration;[m
[32m+[m
[32m+[m[32mclass CreateRolesPermissionsTable extends Migration[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Run the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function up()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::create('roles_permissions', function (Blueprint $table) {[m
[32m+[m[32m            $table->unsignedBigInteger('role_id');[m
[32m+[m[32m            $table->unsignedBigInteger('permission_id');[m
[32m+[m
[32m+[m[32m            //FOREIGN KEY CONSTRAINTS[m
[32m+[m[32m            $table->foreign('role_id')->references('id')->on('roles')->onDelete('cascade');[m
[32m+[m[32m            $table->foreign('permission_id')->references('id')->on('permissions')->onDelete('cascade');[m
[32m+[m
[32m+[m[32m            //SETTING THE PRIMARY KEYS[m
[32m+[m[32m            $table->primary(['role_id','permission_id']);[m
[32m+[m[32m        });[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Reverse the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function down()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::dropIfExists('roles_permissions');[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/database/migrations/2020_11_04_122750_create_articles_table.php b/database/migrations/2020_11_04_122750_create_articles_table.php[m
[1mnew file mode 100644[m
[1mindex 0000000..b5c58ad[m
[1m--- /dev/null[m
[1m+++ b/database/migrations/2020_11_04_122750_create_articles_table.php[m
[36m@@ -0,0 +1,44 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32muse Illuminate\Support\Facades\Schema;[m
[32m+[m[32muse Illuminate\Database\Schema\Blueprint;[m
[32m+[m[32muse Illuminate\Database\Migrations\Migration;[m
[32m+[m
[32m+[m[32mclass CreateArticlesTable extends Migration[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Run the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function up()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::create('articles', function (Blueprint $table) {[m
[32m+[m[32m            $table->uuid('id')->primary();[m
[32m+[m[32m            $table->uuid('user_id');[m
[32m+[m[32m            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');[m
[32m+[m[32m            $table->uuid('category_id');[m
[32m+[m[32m            $table->string('en_title')->index();[m
[32m+[m[32m            $table->string('bn_title')->index()->nullable();[m
[32m+[m[32m            $table->text('tag')->nullable();[m
[32m+[m[32m            $table->string('slug')->unique();[m
[32m+[m[32m            $table->text('en_short_summary')->nullable();[m
[32m+[m[32m            $table->text('bn_short_summary')->nullable();[m
[32m+[m[32m            $table->binary('en_body')->nullable();[m
[32m+[m[32m            $table->binary('bn_body')->nullable();[m
[32m+[m[32m            $table->enum('status', ['draft', 'hide', 'private', 'public']);[m
[32m+[m[32m            $table->timestamp('publish_date')->nullable();[m
[32m+[m[32m            $table->timestamps();[m
[32m+[m[32m        });[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Reverse the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function down()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::dropIfExists('articles');[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/database/migrations/2020_11_04_122818_create_categories_table.php b/database/migrations/2020_11_04_122818_create_categories_table.php[m
[1mnew file mode 100644[m
[1mindex 0000000..2f65820[m
[1m--- /dev/null[m
[1m+++ b/database/migrations/2020_11_04_122818_create_categories_table.php[m
[36m@@ -0,0 +1,34 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32muse Illuminate\Support\Facades\Schema;[m
[32m+[m[32muse Illuminate\Database\Schema\Blueprint;[m
[32m+[m[32muse Illuminate\Database\Migrations\Migration;[m
[32m+[m
[32m+[m[32mclass CreateCategoriesTable extends Migration[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Run the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function up()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::create('categories', function (Blueprint $table) {[m
[32m+[m[32m            $table->uuid('id')->primary();[m
[32m+[m[32m            $table->uuid('parent_id')->default(0);[m
[32m+[m[32m            $table->string('name')->index()->unique();[m
[32m+[m[32m            $table->string('slug')->nullable();[m
[32m+[m[32m            $table->timestamps();[m
[32m+[m[32m        });[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Reverse the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function down()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::dropIfExists('categories');[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/database/migrations/2020_11_04_122830_create_comments_table.php b/database/migrations/2020_11_04_122830_create_comments_table.php[m
[1mnew file mode 100644[m
[1mindex 0000000..18e240e[m
[1m--- /dev/null[m
[1m+++ b/database/migrations/2020_11_04_122830_create_comments_table.php[m
[36m@@ -0,0 +1,36 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32muse Illuminate\Support\Facades\Schema;[m
[32m+[m[32muse Illuminate\Database\Schema\Blueprint;[m
[32m+[m[32muse Illuminate\Database\Migrations\Migration;[m
[32m+[m
[32m+[m[32mclass CreateCommentsTable extends Migration[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Run the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function up()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::create('comments', function (Blueprint $table) {[m
[32m+[m[32m            $table->uuid('id')->primary();[m
[32m+[m[32m            $table->uuid('user_id');[m
[32m+[m[32m            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');[m
[32m+[m[32m            $table->uuid('article_id');[m
[32m+[m[32m            $table->foreign('article_id')->references('id')->on('articles')->onDelete('cascade');[m
[32m+[m[32m            $table->text('body');[m
[32m+[m[32m            $table->timestamps();[m
[32m+[m[32m        });[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Reverse the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function down()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::dropIfExists('comments');[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/database/migrations/2020_11_04_122852_create_media_table.php b/database/migrations/2020_11_04_122852_create_media_table.php[m
[1mnew file mode 100644[m
[1mindex 0000000..44bad87[m
[1m--- /dev/null[m
[1m+++ b/database/migrations/2020_11_04_122852_create_media_table.php[m
[36m@@ -0,0 +1,33 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32muse Illuminate\Support\Facades\Schema;[m
[32m+[m[32muse Illuminate\Database\Schema\Blueprint;[m
[32m+[m[32muse Illuminate\Database\Migrations\Migration;[m
[32m+[m
[32m+[m[32mclass CreateMediaTable extends Migration[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Run the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function up()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::create('media', function (Blueprint $table) {[m
[32m+[m[32m            $table->bigIncrements('id');[m
[32m+[m[32m            $table->text('url')->nullable();[m
[32m+[m[32m            $table->morphs('mediable');[m
[32m+[m[32m            $table->timestamps();[m
[32m+[m[32m        });[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Reverse the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function down()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::dropIfExists('media');[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/database/migrations/2020_11_04_122904_create_pages_table.php b/database/migrations/2020_11_04_122904_create_pages_table.php[m
[1mnew file mode 100644[m
[1mindex 0000000..41483f8[m
[1m--- /dev/null[m
[1m+++ b/database/migrations/2020_11_04_122904_create_pages_table.php[m
[36m@@ -0,0 +1,43 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32muse Illuminate\Support\Facades\Schema;[m
[32m+[m[32muse Illuminate\Database\Schema\Blueprint;[m
[32m+[m[32muse Illuminate\Database\Migrations\Migration;[m
[32m+[m
[32m+[m[32mclass CreatePagesTable extends Migration[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Run the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function up()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::create('pages', function (Blueprint $table) {[m
[32m+[m[32m            $table->uuid('id')->primary();[m
[32m+[m[32m            $table->integer('parent_id')->nullable()->index();[m
[32m+[m[32m            $table->integer('position')->nullable();[m
[32m+[m[32m            $table->integer('left')->nullable()->index();[m
[32m+[m[32m            $table->integer('right')->nullable()->index();[m
[32m+[m[32m            $table->integer('depth')->nullable();[m
[32m+[m[32m            $table->string('name')->index();[m
[32m+[m[32m            $table->string('slug');[m
[32m+[m[32m            $table->string('outline')->longText()->nullable();[m
[32m+[m[32m            $table->binary('description')->nullable();[m
[32m+[m[32m            $table->integer('user_id')->unsigned();[m
[32m+[m[32m            $table->integer('article_id')->unsigned();[m
[32m+[m[32m            $table->integer('team_id')->unsigned();[m
[32m+[m[32m            $table->timestamps();[m
[32m+[m[32m        });[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Reverse the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function down()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::dropIfExists('pages');[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/database/migrations/2020_11_04_122920_create_teams_table.php b/database/migrations/2020_11_04_122920_create_teams_table.php[m
[1mnew file mode 100644[m
[1mindex 0000000..dce750b[m
[1m--- /dev/null[m
[1m+++ b/database/migrations/2020_11_04_122920_create_teams_table.php[m
[36m@@ -0,0 +1,33 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32muse Illuminate\Support\Facades\Schema;[m
[32m+[m[32muse Illuminate\Database\Schema\Blueprint;[m
[32m+[m[32muse Illuminate\Database\Migrations\Migration;[m
[32m+[m
[32m+[m[32mclass CreateTeamsTable extends Migration[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Run the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function up()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::create('teams', function (Blueprint $table) {[m
[32m+[m[32m            $table->bigIncrements('id');[m
[32m+[m[32m            $table->string('name');[m
[32m+[m[32m            $table->string('slug');[m
[32m+[m[32m            $table->timestamps();[m
[32m+[m[32m        });[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Reverse the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function down()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::dropIfExists('teams');[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/database/migrations/2020_11_04_123656_create_quiz_forms_table.php b/database/migrations/2020_11_04_123656_create_quiz_forms_table.php[m
[1mnew file mode 100644[m
[1mindex 0000000..2d2b188[m
[1m--- /dev/null[m
[1m+++ b/database/migrations/2020_11_04_123656_create_quiz_forms_table.php[m
[36m@@ -0,0 +1,33 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32muse Illuminate\Support\Facades\Schema;[m
[32m+[m[32muse Illuminate\Database\Schema\Blueprint;[m
[32m+[m[32muse Illuminate\Database\Migrations\Migration;[m
[32m+[m
[32m+[m[32mclass CreateQuizFormsTable extends Migration[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Run the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function up()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::create('quiz_forms', function (Blueprint $table) {[m
[32m+[m[32m            $table->uuid('id')->primary();[m
[32m+[m[32m            $table->string('name')->index();[m
[32m+[m[32m            $table->string('slug');[m
[32m+[m[32m            $table->timestamps();[m
[32m+[m[32m        });[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Reverse the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function down()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::dropIfExists('quiz_forms');[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/database/migrations/2020_11_04_123707_create_quiz_form_fields_table.php b/database/migrations/2020_11_04_123707_create_quiz_form_fields_table.php[m
[1mnew file mode 100644[m
[1mindex 0000000..cb5aeae[m
[1m--- /dev/null[m
[1m+++ b/database/migrations/2020_11_04_123707_create_quiz_form_fields_table.php[m
[36m@@ -0,0 +1,43 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32muse Illuminate\Support\Facades\Schema;[m
[32m+[m[32muse Illuminate\Database\Schema\Blueprint;[m
[32m+[m[32muse Illuminate\Database\Migrations\Migration;[m
[32m+[m
[32m+[m[32mclass CreateQuizFormFieldsTable extends Migration[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Run the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function up()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::create('quiz_form_fields', function (Blueprint $table) {[m
[32m+[m[32m            $table->uuid('id')->primary();[m
[32m+[m[32m            $table->uuid('quiz_form_id');[m
[32m+[m[32m            $table->foreign('quiz_form_id')->references('id')->on('quiz_forms')->onDelete('cascade');[m
[32m+[m[32m            $table->string('f_label');[m
[32m+[m[32m            $table->string('f_name');[m
[32m+[m[32m            $table->string('f_id');[m
[32m+[m[32m            $table->string('f_class');[m
[32m+[m[32m            $table->enum('f_type', ['Text','Email','Password','Number','Textarea','Radio','Checkbox', 'Select/Dropdown']);[m
[32m+[m[32m            $table->text('f_option_value')->nullable();[m
[32m+[m[32m            $table->string('f_default_value')->nullable();[m
[32m+[m[32m            $table->integer('f_max_value')->nullable();[m
[32m+[m[32m            $table->integer('f_sort_order')->nullable();[m
[32m+[m[32m            $table->enum('f_required', [1,0])->nullable();[m
[32m+[m[32m            $table->timestamps();[m
[32m+[m[32m        });[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Reverse the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function down()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::dropIfExists('quiz_form_fields');[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/database/migrations/2020_11_04_124785_create_quizzes_table.php b/database/migrations/2020_11_04_124785_create_quizzes_table.php[m
[1mnew file mode 100644[m
[1mindex 0000000..65f454f[m
[1m--- /dev/null[m
[1m+++ b/database/migrations/2020_11_04_124785_create_quizzes_table.php[m
[36m@@ -0,0 +1,35 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32muse Illuminate\Support\Facades\Schema;[m
[32m+[m[32muse Illuminate\Database\Schema\Blueprint;[m
[32m+[m[32muse Illuminate\Database\Migrations\Migration;[m
[32m+[m
[32m+[m[32mclass CreateQuizzesTable extends Migration[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Run the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function up()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::create('quizzes', function (Blueprint $table) {[m
[32m+[m[32m            $table->uuid('id')->primary();[m
[32m+[m[32m            $table->uuid('quiz_form_id');[m
[32m+[m[32m            $table->foreign('quiz_form_id')->references('id')->on('quiz_forms')->onDelete('cascade');[m
[32m+[m[32m            $table->string('name')->index();[m
[32m+[m[32m            $table->string('slug');[m
[32m+[m[32m            $table->timestamps();[m
[32m+[m[32m        });[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Reverse the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function down()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::dropIfExists('quizzes');[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/database/migrations/2020_11_05_043718_create_users_teams_table.php b/database/migrations/2020_11_05_043718_create_users_teams_table.php[m
[1mnew file mode 100644[m
[1mindex 0000000..dbe9ced[m
[1m--- /dev/null[m
[1m+++ b/database/migrations/2020_11_05_043718_create_users_teams_table.php[m
[36m@@ -0,0 +1,33 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32muse Illuminate\Support\Facades\Schema;[m
[32m+[m[32muse Illuminate\Database\Schema\Blueprint;[m
[32m+[m[32muse Illuminate\Database\Migrations\Migration;[m
[32m+[m
[32m+[m[32mclass CreateUsersTeamsTable extends Migration[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Run the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function up()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::create('users_teams', function (Blueprint $table) {[m
[32m+[m[32m            $table->bigIncrements('id');[m
[32m+[m[32m            $table->uuid('user_id');[m
[32m+[m[32m            $table->unsignedBigInteger('team_id');[m
[32m+[m[32m            $table->timestamps();[m
[32m+[m[32m        });[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Reverse the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function down()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::dropIfExists('users_teams');[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/database/migrations/2020_11_05_044255_create_notifications_table.php b/database/migrations/2020_11_05_044255_create_notifications_table.php[m
[1mnew file mode 100644[m
[1mindex 0000000..fb16d5b[m
[1m--- /dev/null[m
[1m+++ b/database/migrations/2020_11_05_044255_create_notifications_table.php[m
[36m@@ -0,0 +1,35 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32muse Illuminate\Support\Facades\Schema;[m
[32m+[m[32muse Illuminate\Database\Schema\Blueprint;[m
[32m+[m[32muse Illuminate\Database\Migrations\Migration;[m
[32m+[m
[32m+[m[32mclass CreateNotificationsTable extends Migration[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Run the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function up()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::create('notifications', function (Blueprint $table) {[m
[32m+[m[32m            $table->uuid('id')->primary();[m
[32m+[m[32m            $table->string('type');[m
[32m+[m[32m            $table->morphs('notifiable');[m
[32m+[m[32m            $table->text('data');[m
[32m+[m[32m            $table->timestamp('read_at')->nullable();[m
[32m+[m[32m            $table->timestamps();[m
[32m+[m[32m        });[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Reverse the migrations.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function down()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::dropIfExists('notifications');[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/database/seeds/DatabaseSeeder.php b/database/seeds/DatabaseSeeder.php[m
[1mnew file mode 100755[m
[1mindex 0000000..91cb6d1[m
[1m--- /dev/null[m
[1m+++ b/database/seeds/DatabaseSeeder.php[m
[36m@@ -0,0 +1,16 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32muse Illuminate\Database\Seeder;[m
[32m+[m
[32m+[m[32mclass DatabaseSeeder extends Seeder[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Seed the application's database.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function run()[m
[32m+[m[32m    {[m
[32m+[m[32m        // $this->call(UsersTableSeeder::class);[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/database/seeds/PermissionTableSeeder.php b/database/seeds/PermissionTableSeeder.php[m
[1mnew file mode 100755[m
[1mindex 0000000..c7e1844[m
[1m--- /dev/null[m
[1m+++ b/database/seeds/PermissionTableSeeder.php[m
[36m@@ -0,0 +1,56 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32muse App\Models\Permission;[m
[32m+[m[32muse Illuminate\Database\Seeder;[m
[32m+[m[32muse Illuminate\Support\Facades\Schema;[m
[32m+[m
[32m+[m[32mclass PermissionTableSeeder extends Seeder[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Run the database seeds.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function run()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::disableForeignKeyConstraints();[m
[32m+[m[32m        Permission::truncate();[m
[32m+[m
[32m+[m[32m        $Permissions = [[m
[32m+[m[32m            'User List',[m
[32m+[m[32m            'User Create',[m
[32m+[m[32m            'User Edit',[m
[32m+[m[32m            'User Delete',[m
[32m+[m[32m            'Role List',[m
[32m+[m[32m            'Role Create',[m
[32m+[m[32m            'Role Edit',[m
[32m+[m[32m            'Role Delete',[m
[32m+[m[32m            'Permission List',[m
[32m+[m[32m            'Permission Create',[m
[32m+[m[32m            'Permission Edit',[m
[32m+[m[32m            'Permission Delete',[m
[32m+[m[32m            'Category List',[m
[32m+[m[32m            'Category Create',[m
[32m+[m[32m            'Category Edit',[m
[32m+[m[32m            'Category Delete',[m
[32m+[m[32m            'Article List',[m
[32m+[m[32m            'Article Create',[m
[32m+[m[32m            'Article Edit',[m
[32m+[m[32m            'Article Delete',[m
[32m+[m[32m            'Team List',[m
[32m+[m[32m            'Team Create',[m
[32m+[m[32m            'Team Edit',[m
[32m+[m[32m            'Team Delete',[m
[32m+[m
[32m+[m[32m        ];[m
[32m+[m
[32m+[m
[32m+[m[32m        foreach ($Permissions as $Permission) {[m
[32m+[m
[32m+[m[32m            Permission::Create(['name' => $Permission, 'slug' => \App\Helpers\Helper::slugify($Permission)]);[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        Schema::enableForeignKeyConstraints();[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/database/seeds/RoleTableSeeder.php b/database/seeds/RoleTableSeeder.php[m
[1mnew file mode 100644[m
[1mindex 0000000..4b0c22e[m
[1m--- /dev/null[m
[1m+++ b/database/seeds/RoleTableSeeder.php[m
[36m@@ -0,0 +1,35 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32muse App\Models\Role;[m
[32m+[m[32muse Illuminate\Database\Seeder;[m
[32m+[m[32muse Illuminate\Support\Facades\Schema;[m
[32m+[m
[32m+[m[32mclass RoleTableSeeder extends Seeder[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Run the database seeds.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function run()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::disableForeignKeyConstraints();[m
[32m+[m[32m        Role::truncate();[m
[32m+[m
[32m+[m[32m        $roles = [[m
[32m+[m[32m            'Super Admin',[m
[32m+[m[32m            'Admin',[m
[32m+[m[32m            'Moderator',[m
[32m+[m[32m            'Editor',[m
[32m+[m[32m        ];[m
[32m+[m
[32m+[m
[32m+[m[32m        foreach ($roles as $role) {[m
[32m+[m
[32m+[m[32m            Role::Create(['name' => $role, 'slug' => \App\Helpers\Helper::slugify($role)]);[m
[32m+[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        Schema::enableForeignKeyConstraints();[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/database/seeds/UserTableSeeder.php b/database/seeds/UserTableSeeder.php[m
[1mnew file mode 100755[m
[1mindex 0000000..b95305b[m
[1m--- /dev/null[m
[1m+++ b/database/seeds/UserTableSeeder.php[m
[36m@@ -0,0 +1,49 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32muse App\Models\Permission;[m
[32m+[m[32muse App\Models\Role;[m
[32m+[m[32muse App\Models\User;[m
[32m+[m[32muse Illuminate\Database\Seeder;[m
[32m+[m[32muse Illuminate\Support\Facades\Schema;[m
[32m+[m
[32m+[m[32mclass UserTableSeeder extends Seeder[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Run the database seeds.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function run()[m
[32m+[m[32m    {[m
[32m+[m[32m        Schema::disableForeignKeyConstraints();[m
[32m+[m[32m        User::truncate();[m
[32m+[m[32m        $userPermission = Permission::all();[m
[32m+[m[32m        $userRole = Role::where('slug', 'super-admin')->first();[m
[32m+[m
[32m+[m[32m        $userRole->permissions()->attach($userPermission);[m
[32m+[m
[32m+[m[32m        $userId = time().rand(1000,9000);[m
[32m+[m
[32m+[m[32m        User::create([[m
[32m+[m[32m            'id' => $userId,[m
[32m+[m[32m            'username' => 'admin',[m
[32m+[m[32m            'first_name' => 'Md Ziaur',[m
[32m+[m[32m            'last_name' => 'Rahman',[m
[32m+[m[32m            'slug' => 'zia-rahman',[m
[32m+[m[32m            'email' => 'admin@gmail.com',[m
[32m+[m[32m            'password' => bcrypt('123456'),[m
[32m+[m[32m            'email_verified_at' => now(),[m
[32m+[m[32m            'remember_token' => Str::random(10)[m
[32m+[m[32m        ]);[m
[32m+[m
[32m+[m[32m        $user = User::where('id', $userId)->first();[m
[32m+[m[32m        $user->roles()->attach($userRole);[m
[32m+[m[32m        $user->permissions()->attach($userPermission);[m
[32m+[m[32m        $user->media()->create([[m
[32m+[m[32m            'url' => url('/').'/media/avatar/placeholder.png'[m
[32m+[m[32m        ]);[m
[32m+[m
[32m+[m[32m        Schema::enableForeignKeyConstraints();[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/package.json b/package.json[m
[1mnew file mode 100755[m
[1mindex 0000000..bf85f38[m
[1m--- /dev/null[m
[1m+++ b/package.json[m
[36m@@ -0,0 +1,25 @@[m
[32m+[m[32m{[m
[32m+[m[32m    "private": true,[m
[32m+[m[32m    "scripts": {[m
[32m+[m[32m        "dev": "npm run development",[m
[32m+[m[32m        "development": "cross-env NODE_ENV=development node_modules/webpack/bin/webpack.js --progress --hide-modules --config=node_modules/laravel-mix/setup/webpack.config.js",[m
[32m+[m[32m        "watch": "npm run development -- --watch",[m
[32m+[m[32m        "watch-poll": "npm run watch -- --watch-poll",[m
[32m+[m[32m        "hot": "cross-env NODE_ENV=development node_modules/webpack-dev-server/bin/webpack-dev-server.js --inline --hot --config=node_modules/laravel-mix/setup/webpack.config.js",[m
[32m+[m[32m        "prod": "npm run production",[m
[32m+[m[32m        "production": "cross-env NODE_ENV=production node_modules/webpack/bin/webpack.js --no-progress --hide-modules --config=node_modules/laravel-mix/setup/webpack.config.js"[m
[32m+[m[32m    },[m
[32m+[m[32m    "devDependencies": {[m
[32m+[m[32m        "axios": "^0.19",[m
[32m+[m[32m        "bootstrap": "^4.1.0",[m
[32m+[m[32m        "cross-env": "^5.1",[m
[32m+[m[32m        "jquery": "^3.2",[m
[32m+[m[32m        "laravel-mix": "^4.0.7",[m
[32m+[m[32m        "lodash": "^4.17.13",[m
[32m+[m[32m        "popper.js": "^1.12",[m
[32m+[m[32m        "resolve-url-loader": "^2.3.1",[m
[32m+[m[32m        "sass": "^1.15.2",[m
[32m+[m[32m        "sass-loader": "^7.1.0",[m
[32m+[m[32m        "vue": "^2.5.17"[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/phpunit.xml b/phpunit.xml[m
[1mnew file mode 100755[m
[1mindex 0000000..da4add3[m
[1m--- /dev/null[m
[1m+++ b/phpunit.xml[m
[36m@@ -0,0 +1,33 @@[m
[32m+[m[32m<?xml version="1.0" encoding="UTF-8"?>[m
[32m+[m[32m<phpunit backupGlobals="false"[m
[32m+[m[32m         backupStaticAttributes="false"[m
[32m+[m[32m         bootstrap="vendor/autoload.php"[m
[32m+[m[32m         colors="true"[m
[32m+[m[32m         convertErrorsToExceptions="true"[m
[32m+[m[32m         convertNoticesToExceptions="true"[m
[32m+[m[32m         convertWarningsToExceptions="true"[m
[32m+[m[32m         processIsolation="false"[m
[32m+[m[32m         stopOnFailure="false">[m
[32m+[m[32m    <testsuites>[m
[32m+[m[32m        <testsuite name="Unit">[m
[32m+[m[32m            <directory suffix="Test.php">./tests/Unit</directory>[m
[32m+[m[32m        </testsuite>[m
[32m+[m
[32m+[m[32m        <testsuite name="Feature">[m
[32m+[m[32m            <directory suffix="Test.php">./tests/Feature</directory>[m
[32m+[m[32m        </testsuite>[m
[32m+[m[32m    </testsuites>[m
[32m+[m[32m    <filter>[m
[32m+[m[32m        <whitelist processUncoveredFilesFromWhitelist="true">[m
[32m+[m[32m            <directory suffix=".php">./app</directory>[m
[32m+[m[32m        </whitelist>[m
[32m+[m[32m    </filter>[m
[32m+[m[32m    <php>[m
[32m+[m[32m        <server name="APP_ENV" value="testing"/>[m
[32m+[m[32m        <server name="BCRYPT_ROUNDS" value="4"/>[m
[32m+[m[32m        <server name="CACHE_DRIVER" value="array"/>[m
[32m+[m[32m        <server name="MAIL_DRIVER" value="array"/>[m
[32m+[m[32m        <server name="QUEUE_CONNECTION" value="sync"/>[m
[32m+[m[32m        <server name="SESSION_DRIVER" value="array"/>[m
[32m+[m[32m    </php>[m
[32m+[m[32m</phpunit>[m
[1mdiff --git a/public/.htaccess b/public/.htaccess[m
[1mnew file mode 100755[m
[1mindex 0000000..b75525b[m
[1m--- /dev/null[m
[1m+++ b/public/.htaccess[m
[36m@@ -0,0 +1,21 @@[m
[32m+[m[32m<IfModule mod_rewrite.c>[m
[32m+[m[32m    <IfModule mod_negotiation.c>[m
[32m+[m[32m        Options -MultiViews -Indexes[m
[32m+[m[32m    </IfModule>[m
[32m+[m
[32m+[m[32m    RewriteEngine On[m
[32m+[m
[32m+[m[32m    # Handle Authorization Header[m
[32m+[m[32m    RewriteCond %{HTTP:Authorization} .[m
[32m+[m[32m    RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}][m
[32m+[m
[32m+[m[32m    # Redirect Trailing Slashes If Not A Folder...[m
[32m+[m[32m    RewriteCond %{REQUEST_FILENAME} !-d[m
[32m+[m[32m    RewriteCond %{REQUEST_URI} (.+)/$[m
[32m+[m[32m    RewriteRule ^ %1 [L,R=301][m
[32m+[m
[32m+[m[32m    # Handle Front Controller...[m
[32m+[m[32m    RewriteCond %{REQUEST_FILENAME} !-d[m
[32m+[m[32m    RewriteCond %{REQUEST_FILENAME} !-f[m
[32m+[m[32m    RewriteRule ^ index.php [L][m
[32m+[m[32m</IfModule>[m
[1mdiff --git a/public/css/app.css b/public/css/app.css[m
[1mnew file mode 100755[m
[1mindex 0000000..1937c51[m
[1m--- /dev/null[m
[1m+++ b/public/css/app.css[m
[36m@@ -0,0 +1,8 @@[m
[32m+[m[32m@import url(https://fonts.googleapis.com/css?family=Nunito);[m
[32m+[m
[32m+[m[32m/*![m
[32m+[m[32m * Bootstrap v4.1.3 (https://getbootstrap.com/)[m
[32m+[m[32m * Copyright 2011-2018 The Bootstrap Authors[m
[32m+[m[32m * Copyright 2011-2018 Twitter, Inc.[m
[32m+[m[32m * Licensed under MIT (https://github.com/twbs/bootstrap/blob/master/LICENSE)[m
[32m+[m[32m */:root{--blue:#3490dc;--indigo:#6574cd;--purple:#9561e2;--pink:#f66d9b;--red:#e3342f;--orange:#f6993f;--yellow:#ffed4a;--green:#38c172;--teal:#4dc0b5;--cyan:#6cb2eb;--white:#fff;--gray:#6c757d;--gray-dark:#343a40;--primary:#3490dc;--secondary:#6c757d;--success:#38c172;--info:#6cb2eb;--warning:#ffed4a;--danger:#e3342f;--light:#f8f9fa;--dark:#343a40;--breakpoint-xs:0;--breakpoint-sm:576px;--breakpoint-md:768px;--breakpoint-lg:992px;--breakpoint-xl:1200px;--font-family-sans-serif:"Nunito",sans-serif;--font-family-monospace:SFMono-Regular,Menlo,Monaco,Consolas,"Liberation Mono","Courier New",monospace}*,:after,:before{box-sizing:border-box}html{font-family:sans-serif;line-height:1.15;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%;-ms-overflow-style:scrollbar;-webkit-tap-highlight-color:rgba(0,0,0,0)}@-ms-viewport{width:device-width}article,aside,figcaption,figure,footer,header,hgroup,main,nav,section{display:block}body{margin:0;font-family:Nunito,sans-serif;font-size:.9rem;font-weight:400;line-height:1.6;color:#212529;text-align:left;background-color:#f8fafc}[tabindex="-1"]:focus{outline:0!important}hr{box-sizing:content-box;height:0;overflow:visible}h1,h2,h3,h4,h5,h6{margin-top:0;margin-bottom:.5rem}p{margin-top:0;margin-bottom:1rem}abbr[data-original-title],abbr[title]{text-decoration:underline;-webkit-text-decoration:underline dotted;text-decoration:underline dotted;cursor:help;border-bottom:0}address{font-style:normal;line-height:inherit}address,dl,ol,ul{margin-bottom:1rem}dl,ol,ul{margin-top:0}ol ol,ol ul,ul ol,ul ul{margin-bottom:0}dt{font-weight:700}dd{margin-bottom:.5rem;margin-left:0}blockquote{margin:0 0 1rem}dfn{font-style:italic}b,strong{font-weight:bolder}small{font-size:80%}sub,sup{position:relative;font-size:75%;line-height:0;vertical-align:baseline}sub{bottom:-.25em}sup{top:-.5em}a{color:#3490dc;text-decoration:none;background-color:transparent;-webkit-text-decoration-skip:objects}a:hover{color:#1d68a7;text-decoration:underline}a:not([href]):not([tabindex]),a:not([href]):not([tabindex]):focus,a:not([href]):not([tabindex]):hover{color:inherit;text-decoration:none}a:not([href]):not([tabindex]):focus{outline:0}code,kbd,pre,samp{font-family:SFMono-Regular,Menlo,Monaco,Consolas,Liberation Mono,Courier New,monospace;font-size:1em}pre{margin-top:0;margin-bottom:1rem;overflow:auto;-ms-overflow-style:scrollbar}figure{margin:0 0 1rem}img{border-style:none}img,svg{vertical-align:middle}svg{overflow:hidden}table{border-collapse:collapse}caption{padding-top:.75rem;padding-bottom:.75rem;color:#6c757d;text-align:left;caption-side:bottom}th{text-align:inherit}label{display:inline-block;margin-bottom:.5rem}button{border-radius:0}button:focus{outline:1px dotted;outline:5px auto -webkit-focus-ring-color}button,input,optgroup,select,textarea{margin:0;font-family:inherit;font-size:inherit;line-height:inherit}button,input{overflow:visible}button,select{text-transform:none}[type=reset],[type=submit],button,html [type=button]{-webkit-appearance:button}[type=button]::-moz-focus-inner,[type=reset]::-moz-focus-inner,[type=submit]::-moz-focus-inner,button::-moz-focus-inner{padding:0;border-style:none}input[type=checkbox],input[type=radio]{box-sizing:border-box;padding:0}input[type=date],input[type=datetime-local],input[type=month],input[type=time]{-webkit-appearance:listbox}textarea{overflow:auto;resize:vertical}fieldset{min-width:0;padding:0;margin:0;border:0}legend{display:block;width:100%;max-width:100%;padding:0;margin-bottom:.5rem;font-size:1.5rem;line-height:inherit;color:inherit;white-space:normal}progress{vertical-align:baseline}[type=number]::-webkit-inner-spin-button,[type=number]::-webkit-outer-spin-button{height:auto}[type=search]{outline-offset:-2px;-webkit-appearance:none}[type=search]::-webkit-search-cancel-button,[type=search]::-webkit-search-decoration{-webkit-appearance:none}::-webkit-file-upload-button{font:inherit;-webkit-appearance:button}output{display:inline-block}summary{display:list-item;cursor:pointer}template{display:none}[hidden]{display:none!important}.h1,.h2,.h3,.h4,.h5,.h6,h1,h2,h3,h4,h5,h6{margin-bottom:.5rem;font-family:inherit;font-weight:500;line-height:1.2;color:inherit}.h1,h1{font-size:2.25rem}.h2,h2{font-size:1.8rem}.h3,h3{font-size:1.575rem}.h4,h4{font-size:1.35rem}.h5,h5{font-size:1.125rem}.h6,h6{font-size:.9rem}.lead{font-size:1.125rem;font-weight:300}.display-1{font-size:6rem}.display-1,.display-2{font-weight:300;line-height:1.2}.display-2{font-size:5.5rem}.display-3{font-size:4.5rem}.display-3,.display-4{font-weight:300;line-height:1.2}.display-4{font-size:3.5rem}hr{margin-top:1rem;margin-bottom:1rem;border:0;border-top:1px solid rgba(0,0,0,.1)}.small,small{font-size:80%;font-weight:400}.mark,mark{padding:.2em;background-color:#fcf8e3}.list-inline,.list-unstyled{padding-left:0;list-style:none}.list-inline-item{display:inline-block}.list-inline-item:not(:last-child){margin-right:.5rem}.initialism{font-size:90%;text-transform:uppercase}.blockquote{margin-bottom:1rem;font-size:1.125rem}.blockquote-footer{display:block;font-size:80%;color:#6c757d}.blockquote-footer:before{content:"\2014\A0"}.img-fluid,.img-thumbnail{max-width:100%;height:auto}.img-thumbnail{padding:.25rem;background-color:#f8fafc;border:1px solid #dee2e6;border-radius:.25rem}.figure{display:inline-block}.figure-img{margin-bottom:.5rem;line-height:1}.figure-caption{font-size:90%;color:#6c757d}code{font-size:87.5%;color:#f66d9b;word-break:break-word}a>code{color:inherit}kbd{padding:.2rem .4rem;font-size:87.5%;color:#fff;background-color:#212529;border-radius:.2rem}kbd kbd{padding:0;font-size:100%;font-weight:700}pre{display:block;font-size:87.5%;color:#212529}pre code{font-size:inherit;color:inherit;word-break:normal}.pre-scrollable{max-height:340px;overflow-y:scroll}.container{width:100%;padding-right:15px;padding-left:15px;margin-right:auto;margin-left:auto}@media (min-width:576px){.container{max-width:540px}}@media (min-width:768px){.container{max-width:720px}}@media (min-width:992px){.container{max-width:960px}}@media (min-width:1200px){.container{max-width:1140px}}.container-fluid{width:100%;padding-right:15px;padding-left:15px;margin-right:auto;margin-left:auto}.row{display:flex;flex-wrap:wrap;margin-right:-15px;margin-left:-15px}.no-gutters{margin-right:0;margin-left:0}.no-gutters>.col,.no-gutters>[class*=col-]{padding-right:0;padding-left:0}.col,.col-1,.col-2,.col-3,.col-4,.col-5,.col-6,.col-7,.col-8,.col-9,.col-10,.col-11,.col-12,.col-auto,.col-lg,.col-lg-1,.col-lg-2,.col-lg-3,.col-lg-4,.col-lg-5,.col-lg-6,.col-lg-7,.col-lg-8,.col-lg-9,.col-lg-10,.col-lg-11,.col-lg-12,.col-lg-auto,.col-md,.col-md-1,.col-md-2,.col-md-3,.col-md-4,.col-md-5,.col-md-6,.col-md-7,.col-md-8,.col-md-9,.col-md-10,.col-md-11,.col-md-12,.col-md-auto,.col-sm,.col-sm-1,.col-sm-2,.col-sm-3,.col-sm-4,.col-sm-5,.col-sm-6,.col-sm-7,.col-sm-8,.col-sm-9,.col-sm-10,.col-sm-11,.col-sm-12,.col-sm-auto,.col-xl,.col-xl-1,.col-xl-2,.col-xl-3,.col-xl-4,.col-xl-5,.col-xl-6,.col-xl-7,.col-xl-8,.col-xl-9,.col-xl-10,.col-xl-11,.col-xl-12,.col-xl-auto{position:relative;width:100%;min-height:1px;padding-right:15px;padding-left:15px}.col{flex-basis:0;flex-grow:1;max-width:100%}.col-auto{flex:0 0 auto;width:auto;max-width:none}.col-1{flex:0 0 8.3333333333%;max-width:8.3333333333%}.col-2{flex:0 0 16.6666666667%;max-width:16.6666666667%}.col-3{flex:0 0 25%;max-width:25%}.col-4{flex:0 0 33.3333333333%;max-width:33.3333333333%}.col-5{flex:0 0 41.6666666667%;max-width:41.6666666667%}.col-6{flex:0 0 50%;max-width:50%}.col-7{flex:0 0 58.3333333333%;max-width:58.3333333333%}.col-8{flex:0 0 66.6666666667%;max-width:66.6666666667%}.col-9{flex:0 0 75%;max-width:75%}.col-10{flex:0 0 83.3333333333%;max-width:83.3333333333%}.col-11{flex:0 0 91.6666666667%;max-width:91.6666666667%}.col-12{flex:0 0 100%;max-width:100%}.order-first{order:-1}.order-last{order:13}.order-0{order:0}.order-1{order:1}.order-2{order:2}.order-3{order:3}.order-4{order:4}.order-5{order:5}.order-6{order:6}.order-7{order:7}.order-8{order:8}.order-9{order:9}.order-10{order:10}.order-11{order:11}.order-12{order:12}.offset-1{margin-left:8.3333333333%}.offset-2{margin-left:16.6666666667%}.offset-3{margin-left:25%}.offset-4{margin-left:33.3333333333%}.offset-5{margin-left:41.6666666667%}.offset-6{margin-left:50%}.offset-7{margin-left:58.3333333333%}.offset-8{margin-left:66.6666666667%}.offset-9{margin-left:75%}.offset-10{margin-left:83.3333333333%}.offset-11{margin-left:91.6666666667%}@media (min-width:576px){.col-sm{flex-basis:0;flex-grow:1;max-width:100%}.col-sm-auto{flex:0 0 auto;width:auto;max-width:none}.col-sm-1{flex:0 0 8.3333333333%;max-width:8.3333333333%}.col-sm-2{flex:0 0 16.6666666667%;max-width:16.6666666667%}.col-sm-3{flex:0 0 25%;max-width:25%}.col-sm-4{flex:0 0 33.3333333333%;max-width:33.3333333333%}.col-sm-5{flex:0 0 41.6666666667%;max-width:41.6666666667%}.col-sm-6{flex:0 0 50%;max-width:50%}.col-sm-7{flex:0 0 58.3333333333%;max-width:58.3333333333%}.col-sm-8{flex:0 0 66.6666666667%;max-width:66.6666666667%}.col-sm-9{flex:0 0 75%;max-width:75%}.col-sm-10{flex:0 0 83.3333333333%;max-width:83.3333333333%}.col-sm-11{flex:0 0 91.6666666667%;max-width:91.6666666667%}.col-sm-12{flex:0 0 100%;max-width:100%}.order-sm-first{order:-1}.order-sm-last{order:13}.order-sm-0{order:0}.order-sm-1{order:1}.order-sm-2{order:2}.order-sm-3{order:3}.order-sm-4{order:4}.order-sm-5{order:5}.order-sm-6{order:6}.order-sm-7{order:7}.order-sm-8{order:8}.order-sm-9{order:9}.order-sm-10{order:10}.order-sm-11{order:11}.order-sm-12{order:12}.offset-sm-0{margin-left:0}.offset-sm-1{margin-left:8.3333333333%}.offset-sm-2{margin-left:16.6666666667%}.offset-sm-3{margin-left:25%}.offset-sm-4{margin-left:33.3333333333%}.offset-sm-5{margin-left:41.6666666667%}.offset-sm-6{margin-left:50%}.offset-sm-7{margin-left:58.3333333333%}.offset-sm-8{margin-left:66.6666666667%}.offset-sm-9{margin-left:75%}.offset-sm-10{margin-left:83.3333333333%}.offset-sm-11{margin-left:91.6666666667%}}@media (min-width:768px){.col-md{flex-basis:0;flex-grow:1;max-width:100%}.col-md-auto{flex:0 0 auto;width:auto;max-width:none}.col-md-1{flex:0 0 8.3333333333%;max-width:8.3333333333%}.col-md-2{flex:0 0 16.6666666667%;max-width:16.6666666667%}.col-md-3{flex:0 0 25%;max-width:25%}.col-md-4{flex:0 0 33.3333333333%;max-width:33.3333333333%}.col-md-5{flex:0 0 41.6666666667%;max-width:41.6666666667%}.col-md-6{flex:0 0 50%;max-width:50%}.col-md-7{flex:0 0 58.3333333333%;max-width:58.3333333333%}.col-md-8{flex:0 0 66.6666666667%;max-width:66.6666666667%}.col-md-9{flex:0 0 75%;max-width:75%}.col-md-10{flex:0 0 83.3333333333%;max-width:83.3333333333%}.col-md-11{flex:0 0 91.6666666667%;max-width:91.6666666667%}.col-md-12{flex:0 0 100%;max-width:100%}.order-md-first{order:-1}.order-md-last{order:13}.order-md-0{order:0}.order-md-1{order:1}.order-md-2{order:2}.order-md-3{order:3}.order-md-4{order:4}.order-md-5{order:5}.order-md-6{order:6}.order-md-7{order:7}.order-md-8{order:8}.order-md-9{order:9}.order-md-10{order:10}.order-md-11{order:11}.order-md-12{order:12}.offset-md-0{margin-left:0}.offset-md-1{margin-left:8.3333333333%}.offset-md-2{margin-left:16.6666666667%}.offset-md-3{margin-left:25%}.offset-md-4{margin-left:33.3333333333%}.offset-md-5{margin-left:41.6666666667%}.offset-md-6{margin-left:50%}.offset-md-7{margin-left:58.3333333333%}.offset-md-8{margin-left:66.6666666667%}.offset-md-9{margin-left:75%}.offset-md-10{margin-left:83.3333333333%}.offset-md-11{margin-left:91.6666666667%}}@media (min-width:992px){.col-lg{flex-basis:0;flex-grow:1;max-width:100%}.col-lg-auto{flex:0 0 auto;width:auto;max-width:none}.col-lg-1{flex:0 0 8.3333333333%;max-width:8.3333333333%}.col-lg-2{flex:0 0 16.6666666667%;max-width:16.6666666667%}.col-lg-3{flex:0 0 25%;max-width:25%}.col-lg-4{flex:0 0 33.3333333333%;max-width:33.3333333333%}.col-lg-5{flex:0 0 41.6666666667%;max-width:41.6666666667%}.col-lg-6{flex:0 0 50%;max-width:50%}.col-lg-7{flex:0 0 58.3333333333%;max-width:58.3333333333%}.col-lg-8{flex:0 0 66.6666666667%;max-width:66.6666666667%}.col-lg-9{flex:0 0 75%;max-width:75%}.col-lg-10{flex:0 0 83.3333333333%;max-width:83.3333333333%}.col-lg-11{flex:0 0 91.6666666667%;max-width:91.6666666667%}.col-lg-12{flex:0 0 100%;max-width:100%}.order-lg-first{order:-1}.order-lg-last{order:13}.order-lg-0{order:0}.order-lg-1{order:1}.order-lg-2{order:2}.order-lg-3{order:3}.order-lg-4{order:4}.order-lg-5{order:5}.order-lg-6{order:6}.order-lg-7{order:7}.order-lg-8{order:8}.order-lg-9{order:9}.order-lg-10{order:10}.order-lg-11{order:11}.order-lg-12{order:12}.offset-lg-0{margin-left:0}.offset-lg-1{margin-left:8.3333333333%}.offset-lg-2{margin-left:16.6666666667%}.offset-lg-3{margin-left:25%}.offset-lg-4{margin-left:33.3333333333%}.offset-lg-5{margin-left:41.6666666667%}.offset-lg-6{margin-left:50%}.offset-lg-7{margin-left:58.3333333333%}.offset-lg-8{margin-left:66.6666666667%}.offset-lg-9{margin-left:75%}.offset-lg-10{margin-left:83.3333333333%}.offset-lg-11{margin-left:91.6666666667%}}@media (min-width:1200px){.col-xl{flex-basis:0;flex-grow:1;max-width:100%}.col-xl-auto{flex:0 0 auto;width:auto;max-width:none}.col-xl-1{flex:0 0 8.3333333333%;max-width:8.3333333333%}.col-xl-2{flex:0 0 16.6666666667%;max-width:16.6666666667%}.col-xl-3{flex:0 0 25%;max-width:25%}.col-xl-4{flex:0 0 33.3333333333%;max-width:33.3333333333%}.col-xl-5{flex:0 0 41.6666666667%;max-width:41.6666666667%}.col-xl-6{flex:0 0 50%;max-width:50%}.col-xl-7{flex:0 0 58.3333333333%;max-width:58.3333333333%}.col-xl-8{flex:0 0 66.6666666667%;max-width:66.6666666667%}.col-xl-9{flex:0 0 75%;max-width:75%}.col-xl-10{flex:0 0 83.3333333333%;max-width:83.3333333333%}.col-xl-11{flex:0 0 91.6666666667%;max-width:91.6666666667%}.col-xl-12{flex:0 0 100%;max-width:100%}.order-xl-first{order:-1}.order-xl-last{order:13}.order-xl-0{order:0}.order-xl-1{order:1}.order-xl-2{order:2}.order-xl-3{order:3}.order-xl-4{order:4}.order-xl-5{order:5}.order-xl-6{order:6}.order-xl-7{order:7}.order-xl-8{order:8}.order-xl-9{order:9}.order-xl-10{order:10}.order-xl-11{order:11}.order-xl-12{order:12}.offset-xl-0{margin-left:0}.offset-xl-1{margin-left:8.3333333333%}.offset-xl-2{margin-left:16.6666666667%}.offset-xl-3{margin-left:25%}.offset-xl-4{margin-left:33.3333333333%}.offset-xl-5{margin-left:41.6666666667%}.offset-xl-6{margin-left:50%}.offset-xl-7{margin-left:58.3333333333%}.offset-xl-8{margin-left:66.6666666667%}.offset-xl-9{margin-left:75%}.offset-xl-10{margin-left:83.3333333333%}.offset-xl-11{margin-left:91.6666666667%}}.table{width:100%;margin-bottom:1rem;background-color:transparent}.table td,.table th{padding:.75rem;vertical-align:top;border-top:1px solid #dee2e6}.table thead th{vertical-align:bottom;border-bottom:2px solid #dee2e6}.table tbody+tbody{border-top:2px solid #dee2e6}.table .table{background-color:#f8fafc}.table-sm td,.table-sm th{padding:.3rem}.table-bordered,.table-bordered td,.table-bordered th{border:1px solid #dee2e6}.table-bordered thead td,.table-bordered thead th{border-bottom-width:2px}.table-borderless tbody+tbody,.table-borderless td,.table-borderless th,.table-borderless thead th{border:0}.table-striped tbody tr:nth-of-type(odd){background-color:rgba(0,0,0,.05)}.table-hover tbody tr:hover{background-color:rgba(0,0,0,.075)}.table-primary,.table-primary>td,.table-primary>th{background-color:#c6e0f5}.table-hover .table-primary:hover,.table-hover .table-primary:hover>td,.table-hover .table-primary:hover>th{background-color:#b0d4f1}.table-secondary,.table-secondary>td,.table-secondary>th{background-color:#d6d8db}.table-hover .table-secondary:hover,.table-hover .table-secondary:hover>td,.table-hover .table-secondary:hover>th{background-color:#c8cbcf}.table-success,.table-success>td,.table-success>th{background-color:#c7eed8}.table-hover .table-success:hover,.table-hover .table-success:hover>td,.table-hover .table-success:hover>th{background-color:#b3e8ca}.table-info,.table-info>td,.table-info>th{background-color:#d6e9f9}.table-hover .table-info:hover,.table-hover .table-info:hover>td,.table-hover .table-info:hover>th{background-color:#c0ddf6}.table-warning,.table-warning>td,.table-warning>th{background-color:#fffacc}.table-hover .table-warning:hover,.table-hover .table-warning:hover>td,.table-hover .table-warning:hover>th{background-color:#fff8b3}.table-danger,.table-danger>td,.table-danger>th{background-color:#f7c6c5}.table-hover .table-danger:hover,.table-hover .table-danger:hover>td,.table-hover .table-danger:hover>th{background-color:#f4b0af}.table-light,.table-light>td,.table-light>th{background-color:#fdfdfe}.table-hover .table-light:hover,.table-hover .table-light:hover>td,.table-hover .table-light:hover>th{background-color:#ececf6}.table-dark,.table-dark>td,.table-dark>th{background-color:#c6c8ca}.table-hover .table-dark:hover,.table-hover .table-dark:hover>td,.table-hover .table-dark:hover>th{background-color:#b9bbbe}.table-active,.table-active>td,.table-active>th,.table-hover .table-active:hover,.table-hover .table-active:hover>td,.table-hover .table-active:hover>th{background-color:rgba(0,0,0,.075)}.table .thead-dark th{color:#f8fafc;background-color:#212529;border-color:#32383e}.table .thead-light th{color:#495057;background-color:#e9ecef;border-color:#dee2e6}.table-dark{color:#f8fafc;background-color:#212529}.table-dark td,.table-dark th,.table-dark thead th{border-color:#32383e}.table-dark.table-bordered{border:0}.table-dark.table-striped tbody tr:nth-of-type(odd){background-color:hsla(0,0%,100%,.05)}.table-dark.table-hover tbody tr:hover{background-color:hsla(0,0%,100%,.075)}@media (max-width:575.98px){.table-responsive-sm{display:block;width:100%;overflow-x:auto;-webkit-overflow-scrolling:touch;-ms-overflow-style:-ms-autohiding-scrollbar}.table-responsive-sm>.table-bordered{border:0}}@media (max-width:767.98px){.table-responsive-md{display:block;width:100%;overflow-x:auto;-webkit-overflow-scrolling:touch;-ms-overflow-style:-ms-autohiding-scrollbar}.table-responsive-md>.table-bordered{border:0}}@media (max-width:991.98px){.table-responsive-lg{display:block;width:100%;overflow-x:auto;-webkit-overflow-scrolling:touch;-ms-overflow-style:-ms-autohiding-scrollbar}.table-responsive-lg>.table-bordered{border:0}}@media (max-width:1199.98px){.table-responsive-xl{display:block;width:100%;overflow-x:auto;-webkit-overflow-scrolling:touch;-ms-overflow-style:-ms-autohiding-scrollbar}.table-responsive-xl>.table-bordered{border:0}}.table-responsive{display:block;width:100%;overflow-x:auto;-webkit-overflow-scrolling:touch;-ms-overflow-style:-ms-autohiding-scrollbar}.table-responsive>.table-bordered{border:0}.form-control{display:block;width:100%;height:calc(2.19rem + 2px);padding:.375rem .75rem;font-size:.9rem;line-height:1.6;color:#495057;background-color:#fff;background-clip:padding-box;border:1px solid #ced4da;border-radius:.25rem;transition:border-color .15s ease-in-out,box-shadow .15s ease-in-out}@media screen and (prefers-reduced-motion:reduce){.form-control{transition:none}}.form-control::-ms-expand{background-color:transparent;border:0}.form-control:focus{color:#495057;background-color:#fff;border-color:#a1cbef;outline:0;box-shadow:0 0 0 .2rem rgba(52,144,220,.25)}.form-control::-webkit-input-placeholder{color:#6c757d;opacity:1}.form-control:-ms-input-placeholder{color:#6c757d;opacity:1}.form-control::-ms-input-placeholder{color:#6c757d;opacity:1}.form-control::placeholder{color:#6c757d;opacity:1}.form-control:disabled,.form-control[readonly]{background-color:#e9ecef;opacity:1}select.form-control:focus::-ms-value{color:#495057;background-color:#fff}.form-control-file,.form-control-range{display:block;width:100%}.col-form-label{padding-top:calc(.375rem + 1px);padding-bottom:calc(.375rem + 1px);margin-bottom:0;font-size:inherit;line-height:1.6}.col-form-label-lg{padding-top:calc(.5rem + 1px);padding-bottom:calc(.5rem + 1px);font-size:1.125rem;line-height:1.5}.col-form-label-sm{padding-top:calc(.25rem + 1px);padding-bottom:calc(.25rem + 1px);font-size:.7875rem;line-height:1.5}.form-control-plaintext{display:block;width:100%;padding-top:.375rem;padding-bottom:.375rem;margin-bottom:0;line-height:1.6;color:#212529;background-color:transparent;border:solid transparent;border-width:1px 0}.form-control-plaintext.form-control-lg,.form-control-plaintext.form-control-sm{padding-right:0;padding-left:0}.form-control-sm{height:calc(1.68125rem + 2px);padding:.25rem .5rem;font-size:.7875rem;line-height:1.5;border-radius:.2rem}.form-control-lg{height:calc(2.6875rem + 2px);padding:.5rem 1rem;font-size:1.125rem;line-height:1.5;border-radius:.3rem}select.form-control[multiple],select.form-control[size],textarea.form-control{height:auto}.form-group{margin-bottom:1rem}.form-text{display:block;margin-top:.25rem}.form-row{display:flex;flex-wrap:wrap;margin-right:-5px;margin-left:-5px}.form-row>.col,.form-row>[class*=col-]{padding-right:5px;padding-left:5px}.form-check{position:relative;display:block;padding-left:1.25rem}.form-check-input{position:absolute;margin-top:.3rem;margin-left:-1.25rem}.form-check-input:disabled~.form-check-label{color:#6c757d}.form-check-label{margin-bottom:0}.form-check-inline{display:inline-flex;align-items:center;padding-left:0;margin-right:.75rem}.form-check-inline .form-check-input{position:static;margin-top:0;margin-right:.3125rem;margin-left:0}.valid-feedback{display:none;width:100%;margin-top:.25rem;font-size:80%;color:#38c172}.valid-tooltip{position:absolute;top:100%;z-index:5;display:none;max-width:100%;padding:.25rem .5rem;margin-top:.1rem;font-size:.7875rem;line-height:1.6;color:#fff;background-color:rgba(56,193,114,.9);border-radius:.25rem}.custom-select.is-valid,.form-control.is-valid,.was-validated .custom-select:valid,.was-validated .form-control:valid{border-color:#38c172}.custom-select.is-valid:focus,.form-control.is-valid:focus,.was-validated .custom-select:valid:focus,.was-validated .form-control:valid:focus{border-color:#38c172;box-shadow:0 0 0 .2rem rgba(56,193,114,.25)}.custom-select.is-valid~.valid-feedback,.custom-select.is-valid~.valid-tooltip,.form-control-file.is-valid~.valid-feedback,.form-control-file.is-valid~.valid-tooltip,.form-control.is-valid~.valid-feedback,.form-control.is-valid~.valid-tooltip,.was-validated .custom-select:valid~.valid-feedback,.was-validated .custom-select:valid~.valid-tooltip,.was-validated .form-control-file:valid~.valid-feedback,.was-validated .form-control-file:valid~.valid-tooltip,.was-validated .form-control:valid~.valid-feedback,.was-validated .form-control:valid~.valid-tooltip{display:block}.form-check-input.is-valid~.form-check-label,.was-validated .form-check-input:valid~.form-check-label{color:#38c172}.form-check-input.is-valid~.valid-feedback,.form-check-input.is-valid~.valid-tooltip,.was-validated .form-check-input:valid~.valid-feedback,.was-validated .form-check-input:valid~.valid-tooltip{display:block}.custom-control-input.is-valid~.custom-control-label,.was-validated .custom-control-input:valid~.custom-control-label{color:#38c172}.custom-control-input.is-valid~.custom-control-label:before,.was-validated .custom-control-input:valid~.custom-control-label:before{background-color:#98e1b7}.custom-control-input.is-valid~.valid-feedback,.custom-control-input.is-valid~.valid-tooltip,.was-validated .custom-control-input:valid~.valid-feedback,.was-validated .custom-control-input:valid~.valid-tooltip{display:block}.custom-control-input.is-valid:checked~.custom-control-label:before,.was-validated .custom-control-input:valid:checked~.custom-control-label:before{background-color:#5cd08d}.custom-control-input.is-valid:focus~.custom-control-label:before,.was-validated .custom-control-input:valid:focus~.custom-control-label:before{box-shadow:0 0 0 1px #f8fafc,0 0 0 .2rem rgba(56,193,114,.25)}.custom-file-input.is-valid~.custom-file-label,.was-validated .custom-file-input:valid~.custom-file-label{border-color:#38c172}.custom-file-input.is-valid~.custom-file-label:after,.was-validated .custom-file-input:valid~.custom-file-label:after{border-color:inherit}.custom-file-input.is-valid~.valid-feedback,.custom-file-input.is-valid~.valid-tooltip,.was-validated .custom-file-input:valid~.valid-feedback,.was-validated .custom-file-input:valid~.valid-tooltip{display:block}.custom-file-input.is-valid:focus~.custom-file-label,.was-validated .custom-file-input:valid:focus~.custom-file-label{box-shadow:0 0 0 .2rem rgba(56,193,114,.25)}.invalid-feedback{display:none;width:100%;margin-top:.25rem;font-size:80%;color:#e3342f}.invalid-tooltip{position:absolute;top:100%;z-index:5;display:none;max-width:100%;padding:.25rem .5rem;margin-top:.1rem;font-size:.7875rem;line-height:1.6;color:#fff;background-color:rgba(227,52,47,.9);border-radius:.25rem}.custom-select.is-invalid,.form-control.is-invalid,.was-validated .custom-select:invalid,.was-validated .form-control:invalid{border-color:#e3342f}.custom-select.is-invalid:focus,.form-control.is-invalid:focus,.was-validated .custom-select:invalid:focus,.was-validated .form-control:invalid:focus{border-color:#e3342f;box-shadow:0 0 0 .2rem rgba(227,52,47,.25)}.custom-select.is-invalid~.invalid-feedback,.custom-select.is-invalid~.invalid-tooltip,.form-control-file.is-invalid~.invalid-feedback,.form-control-file.is-invalid~.invalid-tooltip,.form-control.is-invalid~.invalid-feedback,.form-control.is-invalid~.invalid-tooltip,.was-validated .custom-select:invalid~.invalid-feedback,.was-validated .custom-select:invalid~.invalid-tooltip,.was-validated .form-control-file:invalid~.invalid-feedback,.was-validated .form-control-file:invalid~.invalid-tooltip,.was-validated .form-control:invalid~.invalid-feedback,.was-validated .form-control:invalid~.invalid-tooltip{display:block}.form-check-input.is-invalid~.form-check-label,.was-validated .form-check-input:invalid~.form-check-label{color:#e3342f}.form-check-input.is-invalid~.invalid-feedback,.form-check-input.is-invalid~.invalid-tooltip,.was-validated .form-check-input:invalid~.invalid-feedback,.was-validated .form-check-input:invalid~.invalid-tooltip{display:block}.custom-control-input.is-invalid~.custom-control-label,.was-validated .custom-control-input:invalid~.custom-control-label{color:#e3342f}.custom-control-input.is-invalid~.custom-control-label:before,.was-validated .custom-control-input:invalid~.custom-control-label:before{background-color:#f2a29f}.custom-control-input.is-invalid~.invalid-feedback,.custom-control-input.is-invalid~.invalid-tooltip,.was-validated .custom-control-input:invalid~.invalid-feedback,.was-validated .custom-control-input:invalid~.invalid-tooltip{display:block}.custom-control-input.is-invalid:checked~.custom-control-label:before,.was-validated .custom-control-input:invalid:checked~.custom-control-label:before{background-color:#e9605c}.custom-control-input.is-invalid:focus~.custom-control-label:before,.was-validated .custom-control-input:invalid:focus~.custom-control-label:before{box-shadow:0 0 0 1px #f8fafc,0 0 0 .2rem rgba(227,52,47,.25)}.custom-file-input.is-invalid~.custom-file-label,.was-validated .custom-file-input:invalid~.custom-file-label{border-color:#e3342f}.custom-file-input.is-invalid~.custom-file-label:after,.was-validated .custom-file-input:invalid~.custom-file-label:after{border-color:inherit}.custom-file-input.is-invalid~.invalid-feedback,.custom-file-input.is-invalid~.invalid-tooltip,.was-validated .custom-file-input:invalid~.invalid-feedback,.was-validated .custom-file-input:invalid~.invalid-tooltip{display:block}.custom-file-input.is-invalid:focus~.custom-file-label,.was-validated .custom-file-input:invalid:focus~.custom-file-label{box-shadow:0 0 0 .2rem rgba(227,52,47,.25)}.form-inline{display:flex;flex-flow:row wrap;align-items:center}.form-inline .form-check{width:100%}@media (min-width:576px){.form-inline label{justify-content:center}.form-inline .form-group,.form-inline label{display:flex;align-items:center;margin-bottom:0}.form-inline .form-group{flex:0 0 auto;flex-flow:row wrap}.form-inline .form-control{display:inline-block;width:auto;vertical-align:middle}.form-inline .form-control-plaintext{display:inline-block}.form-inline .custom-select,.form-inline .input-group{width:auto}.form-inline .form-check{display:flex;align-items:center;justify-content:center;width:auto;padding-left:0}.form-inline .form-check-input{position:relative;margin-top:0;margin-right:.25rem;margin-left:0}.form-inline .custom-control{align-items:center;justify-content:center}.form-inline .custom-control-label{margin-bottom:0}}.btn{display:inline-block;font-weight:400;text-align:center;white-space:nowrap;vertical-align:middle;-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;border:1px solid transparent;padding:.375rem .75rem;font-size:.9rem;line-height:1.6;border-radius:.25rem;transition:color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out}@media screen and (prefers-reduced-motion:reduce){.btn{transition:none}}.btn:focus,.btn:hover{text-decoration:none}.btn.focus,.btn:focus{outline:0;box-shadow:0 0 0 .2rem rgba(52,144,220,.25)}.btn.disabled,.btn:disabled{opacity:.65}.btn:not(:disabled):not(.disabled){cursor:pointer}a.btn.disabled,fieldset:disabled a.btn{pointer-events:none}.btn-primary{color:#fff;background-color:#3490dc;border-color:#3490dc}.btn-primary:hover{color:#fff;background-color:#227dc7;border-color:#2176bd}.btn-primary.focus,.btn-primary:focus{box-shadow:0 0 0 .2rem rgba(52,144,220,.5)}.btn-primary.disabled,.btn-primary:disabled{color:#fff;background-color:#3490dc;border-color:#3490dc}.btn-primary:not(:disabled):not(.disabled).active,.btn-primary:not(:disabled):not(.disabled):active,.show>.btn-primary.dropdown-toggle{color:#fff;background-color:#2176bd;border-color:#1f6fb2}.btn-primary:not(:disabled):not(.disabled).active:focus,.btn-primary:not(:disabled):not(.disabled):active:focus,.show>.btn-primary.dropdown-toggle:focus{box-shadow:0 0 0 .2rem rgba(52,144,220,.5)}.btn-secondary{color:#fff;background-color:#6c757d;border-color:#6c757d}.btn-secondary:hover{color:#fff;background-color:#5a6268;border-color:#545b62}.btn-secondary.focus,.btn-secondary:focus{box-shadow:0 0 0 .2rem rgba(108,117,125,.5)}.btn-secondary.disabled,.btn-secondary:disabled{color:#fff;background-color:#6c757d;border-color:#6c757d}.btn-secondary:not(:disabled):not(.disabled).active,.btn-secondary:not(:disabled):not(.disabled):active,.show>.btn-secondary.dropdown-toggle{color:#fff;background-color:#545b62;border-color:#4e555b}.btn-secondary:not(:disabled):not(.disabled).active:focus,.btn-secondary:not(:disabled):not(.disabled):active:focus,.show>.btn-secondary.dropdown-toggle:focus{box-shadow:0 0 0 .2rem rgba(108,117,125,.5)}.btn-success{color:#fff;background-color:#38c172;border-color:#38c172}.btn-success:hover{color:#fff;background-color:#2fa360;border-color:#2d995b}.btn-success.focus,.btn-success:focus{box-shadow:0 0 0 .2rem rgba(56,193,114,.5)}.btn-success.disabled,.btn-success:disabled{color:#fff;background-color:#38c172;border-color:#38c172}.btn-success:not(:disabled):not(.disabled).active,.btn-success:not(:disabled):not(.disabled):active,.show>.btn-success.dropdown-toggle{color:#fff;background-color:#2d995b;border-color:#2a9055}.btn-success:not(:disabled):not(.disabled).active:focus,.btn-success:not(:disabled):not(.disabled):active:focus,.show>.btn-success.dropdown-toggle:focus{box-shadow:0 0 0 .2rem rgba(56,193,114,.5)}.btn-info{color:#212529;background-color:#6cb2eb;border-color:#6cb2eb}.btn-info:hover{color:#fff;background-color:#4aa0e6;border-color:#3f9ae5}.btn-info.focus,.btn-info:focus{box-shadow:0 0 0 .2rem rgba(108,178,235,.5)}.btn-info.disabled,.btn-info:disabled{color:#212529;background-color:#6cb2eb;border-color:#6cb2eb}.btn-info:not(:disabled):not(.disabled).active,.btn-info:not(:disabled):not(.disabled):active,.show>.btn-info.dropdown-toggle{color:#fff;background-color:#3f9ae5;border-color:#3495e3}.btn-info:not(:disabled):not(.disabled).active:focus,.btn-info:not(:disabled):not(.disabled):active:focus,.show>.btn-info.dropdown-toggle:focus{box-shadow:0 0 0 .2rem rgba(108,178,235,.5)}.btn-warning{color:#212529;background-color:#ffed4a;border-color:#ffed4a}.btn-warning:hover{color:#212529;background-color:#ffe924;border-color:#ffe817}.btn-warning.focus,.btn-warning:focus{box-shadow:0 0 0 .2rem rgba(255,237,74,.5)}.btn-warning.disabled,.btn-warning:disabled{color:#212529;background-color:#ffed4a;border-color:#ffed4a}.btn-warning:not(:disabled):not(.disabled).active,.btn-warning:not(:disabled):not(.disabled):active,.show>.btn-warning.dropdown-toggle{color:#212529;background-color:#ffe817;border-color:#ffe70a}.btn-warning:not(:disabled):not(.disabled).active:focus,.btn-warning:not(:disabled):not(.disabled):active:focus,.show>.btn-warning.dropdown-toggle:focus{box-shadow:0 0 0 .2rem rgba(255,237,74,.5)}.btn-danger{color:#fff;background-color:#e3342f;border-color:#e3342f}.btn-danger:hover{color:#fff;background-color:#d0211c;border-color:#c51f1a}.btn-danger.focus,.btn-danger:focus{box-shadow:0 0 0 .2rem rgba(227,52,47,.5)}.btn-danger.disabled,.btn-danger:disabled{color:#fff;background-color:#e3342f;border-color:#e3342f}.btn-danger:not(:disabled):not(.disabled).active,.btn-danger:not(:disabled):not(.disabled):active,.show>.btn-danger.dropdown-toggle{color:#fff;background-color:#c51f1a;border-color:#b91d19}.btn-danger:not(:disabled):not(.disabled).active:focus,.btn-danger:not(:disabled):not(.disabled):active:focus,.show>.btn-danger.dropdown-toggle:focus{box-shadow:0 0 0 .2rem rgba(227,52,47,.5)}.btn-light{color:#212529;background-color:#f8f9fa;border-color:#f8f9fa}.btn-light:hover{color:#212529;background-color:#e2e6ea;border-color:#dae0e5}.btn-light.focus,.btn-light:focus{box-shadow:0 0 0 .2rem rgba(248,249,250,.5)}.btn-light.disabled,.btn-light:disabled{color:#212529;background-color:#f8f9fa;border-color:#f8f9fa}.btn-light:not(:disabled):not(.disabled).active,.btn-light:not(:disabled):not(.disabled):active,.show>.btn-light.dropdown-toggle{color:#212529;background-color:#dae0e5;border-color:#d3d9df}.btn-light:not(:disabled):not(.disabled).active:focus,.btn-light:not(:disabled):not(.disabled):active:focus,.show>.btn-light.dropdown-toggle:focus{box-shadow:0 0 0 .2rem rgba(248,249,250,.5)}.btn-dark{color:#fff;background-color:#343a40;border-color:#343a40}.btn-dark:hover{color:#fff;background-color:#23272b;border-color:#1d2124}.btn-dark.focus,.btn-dark:focus{box-shadow:0 0 0 .2rem rgba(52,58,64,.5)}.btn-dark.disabled,.btn-dark:disabled{color:#fff;background-color:#343a40;border-color:#343a40}.btn-dark:not(:disabled):not(.disabled).active,.btn-dark:not(:disabled):not(.disabled):active,.show>.btn-dark.dropdown-toggle{color:#fff;background-color:#1d2124;border-color:#171a1d}.btn-dark:not(:disabled):not(.disabled).active:focus,.btn-dark:not(:disabled):not(.disabled):active:focus,.show>.btn-dark.dropdown-toggle:focus{box-shadow:0 0 0 .2rem rgba(52,58,64,.5)}.btn-outline-primary{color:#3490dc;background-color:transparent;background-image:none;border-color:#3490dc}.btn-outline-primary:hover{color:#fff;background-color:#3490dc;border-color:#3490dc}.btn-outline-primary.focus,.btn-outline-primary:focus{box-shadow:0 0 0 .2rem rgba(52,144,220,.5)}.btn-outline-primary.disabled,.btn-outline-primary:disabled{color:#3490dc;background-color:transparent}.btn-outline-primary:not(:disabled):not(.disabled).active,.btn-outline-primary:not(:disabled):not(.disabled):active,.show>.btn-outline-primary.dropdown-toggle{color:#fff;background-color:#3490dc;border-color:#3490dc}.btn-outline-primary:not(:disabled):not(.disabled).active:focus,.btn-outline-primary:not(:disabled):not(.disabled):active:focus,.show>.btn-outline-primary.dropdown-toggle:focus{box-shadow:0 0 0 .2rem rgba(52,144,220,.5)}.btn-outline-secondary{color:#6c757d;background-color:transparent;background-image:none;border-color:#6c757d}.btn-outline-secondary:hover{color:#fff;background-color:#6c757d;border-color:#6c757d}.btn-outline-secondary.focus,.btn-outline-secondary:focus{box-shadow:0 0 0 .2rem rgba(108,117,125,.5)}.btn-outline-secondary.disabled,.btn-outline-secondary:disabled{color:#6c757d;background-color:transparent}.btn-outline-secondary:not(:disabled):not(.disabled).active,.btn-outline-secondary:not(:disabled):not(.disabled):active,.show>.btn-outline-secondary.dropdown-toggle{color:#fff;background-color:#6c757d;border-color:#6c757d}.btn-outline-secondary:not(:disabled):not(.disabled).active:focus,.btn-outline-secondary:not(:disabled):not(.disabled):active:focus,.show>.btn-outline-secondary.dropdown-toggle:focus{box-shadow:0 0 0 .2rem rgba(108,117,125,.5)}.btn-outline-success{color:#38c172;background-color:transparent;background-image:none;border-color:#38c172}.btn-outline-success:hover{color:#fff;background-color:#38c172;border-color:#38c172}.btn-outline-success.focus,.btn-outline-success:focus{box-shadow:0 0 0 .2rem rgba(56,193,114,.5)}.btn-outline-success.disabled,.btn-outline-success:disabled{color:#38c172;background-color:transparent}.btn-outline-success:not(:disabled):not(.disabled).active,.btn-outline-success:not(:disabled):not(.disabled):active,.show>.btn-outline-success.dropdown-toggle{color:#fff;background-color:#38c172;border-color:#38c172}.btn-outline-success:not(:disabled):not(.disabled).active:focus,.btn-outline-success:not(:disabled):not(.disabled):active:focus,.show>.btn-outline-success.dropdown-toggle:focus{box-shadow:0 0 0 .2rem rgba(56,193,114,.5)}.btn-outline-info{color:#6cb2eb;background-color:transparent;background-image:none;border-color:#6cb2eb}.btn-outline-info:hover{color:#212529;background-color:#6cb2eb;border-color:#6cb2eb}.btn-outline-info.focus,.btn-outline-info:focus{box-shadow:0 0 0 .2rem rgba(108,178,235,.5)}.btn-outline-info.disabled,.btn-outline-info:disabled{color:#6cb2eb;background-color:transparent}.btn-outline-info:not(:disabled):not(.disabled).active,.btn-outline-info:not(:disabled):not(.disabled):active,.show>.btn-outline-info.dropdown-toggle{color:#212529;background-color:#6cb2eb;border-color:#6cb2eb}.btn-outline-info:not(:disabled):not(.disabled).active:focus,.btn-outline-info:not(:disabled):not(.disabled):active:focus,.show>.btn-outline-info.dropdown-toggle:focus{box-shadow:0 0 0 .2rem rgba(108,178,235,.5)}.btn-outline-warning{color:#ffed4a;background-color:transparent;background-image:none;border-color:#ffed4a}.btn-outline-warning:hover{color:#212529;background-color:#ffed4a;border-color:#ffed4a}.btn-outline-warning.focus,.btn-outline-warning:focus{box-shadow:0 0 0 .2rem rgba(255,237,74,.5)}.btn-outline-warning.disabled,.btn-outline-warning:disabled{color:#ffed4a;background-color:transparent}.btn-outline-warning:not(:disabled):not(.disabled).active,.btn-outline-warning:not(:disabled):not(.disabled):active,.show>.btn-outline-warning.dropdown-toggle{color:#212529;background-color:#ffed4a;border-color:#ffed4a}.btn-outline-warning:not(:disabled):not(.disabled).active:focus,.btn-outline-warning:not(:disabled):not(.disabled):active:focus,.show>.btn-outline-warning.dropdown-toggle:focus{box-shadow:0 0 0 .2rem rgba(255,237,74,.5)}.btn-outline-danger{color:#e3342f;background-color:transparent;background-image:none;border-color:#e3342f}.btn-outline-danger:hover{color:#fff;background-color:#e3342f;border-color:#e3342f}.btn-outline-danger.focus,.btn-outline-danger:focus{box-shadow:0 0 0 .2rem rgba(227,52,47,.5)}.btn-outline-danger.disabled,.btn-outline-danger:disabled{color:#e3342f;background-color:transparent}.btn-outline-danger:not(:disabled):not(.disabled).active,.btn-outline-danger:not(:disabled):not(.disabled):active,.show>.btn-outline-danger.dropdown-toggle{color:#fff;background-color:#e3342f;border-color:#e3342f}.btn-outline-danger:not(:disabled):not(.disabled).active:focus,.btn-outline-danger:not(:disabled):not(.disabled):active:focus,.show>.btn-outline-danger.dropdown-toggle:focus{box-shadow:0 0 0 .2rem rgba(227,52,47,.5)}.btn-outline-light{color:#f8f9fa;background-color:transparent;background-image:none;border-color:#f8f9fa}.btn-outline-light:hover{color:#212529;background-color:#f8f9fa;border-color:#f8f9fa}.btn-outline-light.focus,.btn-outline-light:focus{box-shadow:0 0 0 .2rem rgba(248,249,250,.5)}.btn-outline-light.disabled,.btn-outline-light:disabled{color:#f8f9fa;background-color:transparent}.btn-outline-light:not(:disabled):not(.disabled).active,.btn-outline-light:not(:disabled):not(.disabled):active,.show>.btn-outline-light.dropdown-toggle{color:#212529;background-color:#f8f9fa;border-color:#f8f9fa}.btn-outline-light:not(:disabled):not(.disabled).active:focus,.btn-outline-light:not(:disabled):not(.disabled):active:focus,.show>.btn-outline-light.dropdown-toggle:focus{box-shadow:0 0 0 .2rem rgba(248,249,250,.5)}.btn-outline-dark{color:#343a40;background-color:transparent;background-image:none;border-color:#343a40}.btn-outline-dark:hover{color:#fff;background-color:#343a40;border-color:#343a40}.btn-outline-dark.focus,.btn-outline-dark:focus{box-shadow:0 0 0 .2rem rgba(52,58,64,.5)}.btn-outline-dark.disabled,.btn-outline-dark:disabled{color:#343a40;background-color:transparent}.btn-outline-dark:not(:disabled):not(.disabled).active,.btn-outline-dark:not(:disabled):not(.disabled):active,.show>.btn-outline-dark.dropdown-toggle{color:#fff;background-color:#343a40;border-color:#343a40}.btn-outline-dark:not(:disabled):not(.disabled).active:focus,.btn-outline-dark:not(:disabled):not(.disabled):active:focus,.show>.btn-outline-dark.dropdown-toggle:focus{box-shadow:0 0 0 .2rem rgba(52,58,64,.5)}.btn-link{font-weight:400;color:#3490dc;background-color:transparent}.btn-link:hover{color:#1d68a7;background-color:transparent}.btn-link.focus,.btn-link:focus,.btn-link:hover{text-decoration:underline;border-color:transparent}.btn-link.focus,.btn-link:focus{box-shadow:none}.btn-link.disabled,.btn-link:disabled{color:#6c757d;pointer-events:none}.btn-group-lg>.btn,.btn-lg{padding:.5rem 1rem;font-size:1.125rem;line-height:1.5;border-radius:.3rem}.btn-group-sm>.btn,.btn-sm{padding:.25rem .5rem;font-size:.7875rem;line-height:1.5;border-radius:.2rem}.btn-block{display:block;width:100%}.btn-block+.btn-block{margin-top:.5rem}input[type=button].btn-block,input[type=reset].btn-block,input[type=submit].btn-block{width:100%}.fade{transition:opacity .15s linear}@media screen and (prefers-reduced-motion:reduce){.fade{transition:none}}.fade:not(.show){opacity:0}.collapse:not(.show){display:none}.collapsing{position:relative;height:0;overflow:hidden;transition:height .35s ease}@media screen and (prefers-reduced-motion:reduce){.collapsing{transition:none}}.dropdown,.dropleft,.dropright,.dropup{position:relative}.dropdown-toggle:after{display:inline-block;width:0;height:0;margin-left:.255em;vertical-align:.255em;content:"";border-top:.3em solid;border-right:.3em solid transparent;border-bottom:0;border-left:.3em solid transparent}.dropdown-toggle:empty:after{margin-left:0}.dropdown-menu{position:absolute;top:100%;left:0;z-index:1000;display:none;float:left;min-width:10rem;padding:.5rem 0;margin:.125rem 0 0;font-size:.9rem;color:#212529;text-align:left;list-style:none;background-color:#fff;background-clip:padding-box;border:1px solid rgba(0,0,0,.15);border-radius:.25rem}.dropdown-menu-right{right:0;left:auto}.dropup .dropdown-menu{top:auto;bottom:100%;margin-top:0;margin-bottom:.125rem}.dropup .dropdown-toggle:after{display:inline-block;width:0;height:0;margin-left:.255em;vertical-align:.255em;content:"";border-top:0;border-right:.3em solid transparent;border-bottom:.3em solid;border-left:.3em solid transparent}.dropup .dropdown-toggle:empty:after{margin-left:0}.dropright .dropdown-menu{top:0;right:auto;left:100%;margin-top:0;margin-left:.125rem}.dropright .dropdown-toggle:after{display:inline-block;width:0;height:0;margin-left:.255em;vertical-align:.255em;content:"";border-top:.3em solid transparent;border-right:0;border-bottom:.3em solid transparent;border-left:.3em solid}.dropright .dropdown-toggle:empty:after{margin-left:0}.dropright .dropdown-toggle:after{vertical-align:0}.dropleft .dropdown-menu{top:0;right:100%;left:auto;margin-top:0;margin-right:.125rem}.dropleft .dropdown-toggle:after{display:inline-block;width:0;height:0;margin-left:.255em;vertical-align:.255em;content:"";display:none}.dropleft .dropdown-toggle:before{display:inline-block;width:0;height:0;margin-right:.255em;vertical-align:.255em;content:"";border-top:.3em solid transparent;border-right:.3em solid;border-bottom:.3em solid transparent}.dropleft .dropdown-toggle:empty:after{margin-left:0}.dropleft .dropdown-toggle:before{vertical-align:0}.dropdown-menu[x-placement^=bottom],.dropdown-menu[x-placement^=left],.dropdown-menu[x-placement^=right],.dropdown-menu[x-placement^=top]{right:auto;bottom:auto}.dropdown-divider{height:0;margin:.5rem 0;overflow:hidden;border-top:1px solid #e9ecef}.dropdown-item{display:block;width:100%;padding:.25rem 1.5rem;clear:both;font-weight:400;color:#212529;text-align:inherit;white-space:nowrap;background-color:transparent;border:0}.dropdown-item:focus,.dropdown-item:hover{color:#16181b;text-decoration:none;background-color:#f8f9fa}.dropdown-item.active,.dropdown-item:active{color:#fff;text-decoration:none;background-color:#3490dc}.dropdown-item.disabled,.dropdown-item:disabled{color:#6c757d;background-color:transparent}.dropdown-menu.show{display:block}.dropdown-header{display:block;padding:.5rem 1.5rem;margin-bottom:0;font-size:.7875rem;color:#6c757d;white-space:nowrap}.dropdown-item-text{display:block;padding:.25rem 1.5rem;color:#212529}.btn-group,.btn-group-vertical{position:relative;display:inline-flex;vertical-align:middle}.btn-group-vertical>.btn,.btn-group>.btn{position:relative;flex:0 1 auto}.btn-group-vertical>.btn.active,.btn-group-vertical>.btn:active,.btn-group-vertical>.btn:focus,.btn-group-vertical>.btn:hover,.btn-group>.btn.active,.btn-group>.btn:active,.btn-group>.btn:focus,.btn-group>.btn:hover{z-index:1}.btn-group-vertical .btn+.btn,.btn-group-vertical .btn+.btn-group,.btn-group-vertical .btn-group+.btn,.btn-group-vertical .btn-group+.btn-group,.btn-group .btn+.btn,.btn-group .btn+.btn-group,.btn-group .btn-group+.btn,.btn-group .btn-group+.btn-group{margin-left:-1px}.btn-toolbar{display:flex;flex-wrap:wrap;justify-content:flex-start}.btn-toolbar .input-group{width:auto}.btn-group>.btn:first-child{margin-left:0}.btn-group>.btn-group:not(:last-child)>.btn,.btn-group>.btn:not(:last-child):not(.dropdown-toggle){border-top-right-radius:0;border-bottom-right-radius:0}.btn-group>.btn-group:not(:first-child)>.btn,.btn-group>.btn:not(:first-child){border-top-left-radius:0;border-bottom-left-radius:0}.dropdown-toggle-split{padding-right:.5625rem;padding-left:.5625rem}.dropdown-toggle-split:after,.dropright .dropdown-toggle-split:after,.dropup .dropdown-toggle-split:after{margin-left:0}.dropleft .dropdown-toggle-split:before{margin-right:0}.btn-group-sm>.btn+.dropdown-toggle-split,.btn-sm+.dropdown-toggle-split{padding-right:.375rem;padding-left:.375rem}.btn-group-lg>.btn+.dropdown-toggle-split,.btn-lg+.dropdown-toggle-split{padding-right:.75rem;padding-left:.75rem}.btn-group-vertical{flex-direction:column;align-items:flex-start;justify-content:center}.btn-group-vertical .btn,.btn-group-vertical .btn-group{width:100%}.btn-group-vertical>.btn+.btn,.btn-group-vertical>.btn+.btn-group,.btn-group-vertical>.btn-group+.btn,.btn-group-vertical>.btn-group+.btn-group{margin-top:-1px;margin-left:0}.btn-group-vertical>.btn-group:not(:last-child)>.btn,.btn-group-vertical>.btn:not(:last-child):not(.dropdown-toggle){border-bottom-right-radius:0;border-bottom-left-radius:0}.btn-group-vertical>.btn-group:not(:first-child)>.btn,.btn-group-vertical>.btn:not(:first-child){border-top-left-radius:0;border-top-right-radius:0}.btn-group-toggle>.btn,.btn-group-toggle>.btn-group>.btn{margin-bottom:0}.btn-group-toggle>.btn-group>.btn input[type=checkbox],.btn-group-toggle>.btn-group>.btn input[type=radio],.btn-group-toggle>.btn input[type=checkbox],.btn-group-toggle>.btn input[type=radio]{position:absolute;clip:rect(0,0,0,0);pointer-events:none}.input-group{position:relative;display:flex;flex-wrap:wrap;align-items:stretch;width:100%}.input-group>.custom-file,.input-group>.custom-select,.input-group>.form-control{position:relative;flex:1 1 auto;width:1%;margin-bottom:0}.input-group>.custom-file+.custom-file,.input-group>.custom-file+.custom-select,.input-group>.custom-file+.form-control,.input-group>.custom-select+.custom-file,.input-group>.custom-select+.custom-select,.input-group>.custom-select+.form-control,.input-group>.form-control+.custom-file,.input-group>.form-control+.custom-select,.input-group>.form-control+.form-control{margin-left:-1px}.input-group>.custom-file .custom-file-input:focus~.custom-file-label,.input-group>.custom-select:focus,.input-group>.form-control:focus{z-index:3}.input-group>.custom-file .custom-file-input:focus{z-index:4}.input-group>.custom-select:not(:last-child),.input-group>.form-control:not(:last-child){border-top-right-radius:0;border-bottom-right-radius:0}.input-group>.custom-select:not(:first-child),.input-group>.form-control:not(:first-child){border-top-left-radius:0;border-bottom-left-radius:0}.input-group>.custom-file{display:flex;align-items:center}.input-group>.custom-file:not(:last-child) .custom-file-label,.input-group>.custom-file:not(:last-child) .custom-file-label:after{border-top-right-radius:0;border-bottom-right-radius:0}.input-group>.custom-file:not(:first-child) .custom-file-label{border-top-left-radius:0;border-bottom-left-radius:0}.input-group-append,.input-group-prepend{display:flex}.input-group-append .btn,.input-group-prepend .btn{position:relative;z-index:2}.input-group-append .btn+.btn,.input-group-append .btn+.input-group-text,.input-group-append .input-group-text+.btn,.input-group-append .input-group-text+.input-group-text,.input-group-prepend .btn+.btn,.input-group-prepend .btn+.input-group-text,.input-group-prepend .input-group-text+.btn,.input-group-prepend .input-group-text+.input-group-text{margin-left:-1px}.input-group-prepend{margin-right:-1px}.input-group-append{margin-left:-1px}.input-group-text{display:flex;align-items:center;padding:.375rem .75rem;margin-bottom:0;font-size:.9rem;font-weight:400;line-height:1.6;color:#495057;text-align:center;white-space:nowrap;background-color:#e9ecef;border:1px solid #ced4da;border-radius:.25rem}.input-group-text input[type=checkbox],.input-group-text input[type=radio]{margin-top:0}.input-group-lg>.form-control,.input-group-lg>.input-group-append>.btn,.input-group-lg>.input-group-append>.input-group-text,.input-group-lg>.input-group-prepend>.btn,.input-group-lg>.input-group-prepend>.input-group-text{height:calc(2.6875rem + 2px);padding:.5rem 1rem;font-size:1.125rem;line-height:1.5;border-radius:.3rem}.input-group-sm>.form-control,.input-group-sm>.input-group-append>.btn,.input-group-sm>.input-group-append>.input-group-text,.input-group-sm>.input-group-prepend>.btn,.input-group-sm>.input-group-prepend>.input-group-text{height:calc(1.68125rem + 2px);padding:.25rem .5rem;font-size:.7875rem;line-height:1.5;border-radius:.2rem}.input-group>.input-group-append:last-child>.btn:not(:last-child):not(.dropdown-toggle),.input-group>.input-group-append:last-child>.input-group-text:not(:last-child),.input-group>.input-group-append:not(:last-child)>.btn,.input-group>.input-group-append:not(:last-child)>.input-group-text,.input-group>.input-group-prepend>.btn,.input-group>.input-group-prepend>.input-group-text{border-top-right-radius:0;border-bottom-right-radius:0}.input-group>.input-group-append>.btn,.input-group>.input-group-append>.input-group-text,.input-group>.input-group-prepend:first-child>.btn:not(:first-child),.input-group>.input-group-prepend:first-child>.input-group-text:not(:first-child),.input-group>.input-group-prepend:not(:first-child)>.btn,.input-group>.input-group-prepend:not(:first-child)>.input-group-text{border-top-left-radius:0;border-bottom-left-radius:0}.custom-control{position:relative;display:block;min-height:1.44rem;padding-left:1.5rem}.custom-control-inline{display:inline-flex;margin-right:1rem}.custom-control-input{position:absolute;z-index:-1;opacity:0}.custom-control-input:checked~.custom-control-label:before{color:#fff;background-color:#3490dc}.custom-control-input:focus~.custom-control-label:before{box-shadow:0 0 0 1px #f8fafc,0 0 0 .2rem rgba(52,144,220,.25)}.custom-control-input:active~.custom-control-label:before{color:#fff;background-color:#cce3f6}.custom-control-input:disabled~.custom-control-label{color:#6c757d}.custom-control-input:disabled~.custom-control-label:before{background-color:#e9ecef}.custom-control-label{position:relative;margin-bottom:0}.custom-control-label:before{pointer-events:none;-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;background-color:#dee2e6}.custom-control-label:after,.custom-control-label:before{position:absolute;top:.22rem;left:-1.5rem;display:block;width:1rem;height:1rem;content:""}.custom-control-label:after{background-repeat:no-repeat;background-position:50%;background-size:50% 50%}.custom-checkbox .custom-control-label:before{border-radius:.25rem}.custom-checkbox .custom-control-input:checked~.custom-control-label:before{background-color:#3490dc}.custom-checkbox .custom-control-input:checked~.custom-control-label:after{background-image:url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 8 8'%3E%3Cpath fill='%23fff' d='M6.564.75l-3.59 3.612-1.538-1.55L0 4.26 2.974 7.25 8 2.193z'/%3E%3C/svg%3E")}.custom-checkbox .custom-control-input:indeterminate~.custom-control-label:before{background-color:#3490dc}.custom-checkbox .custom-control-input:indeterminate~.custom-control-label:after{background-image:url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 4 4'%3E%3Cpath stroke='%23fff' d='M0 2h4'/%3E%3C/svg%3E")}.custom-checkbox .custom-control-input:disabled:checked~.custom-control-label:before{background-color:rgba(52,144,220,.5)}.custom-checkbox .custom-control-input:disabled:indeterminate~.custom-control-label:before{background-color:rgba(52,144,220,.5)}.custom-radio .custom-control-label:before{border-radius:50%}.custom-radio .custom-control-input:checked~.custom-control-label:before{background-color:#3490dc}.custom-radio .custom-control-input:checked~.custom-control-label:after{background-image:url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='-4 -4 8 8'%3E%3Ccircle r='3' fill='%23fff'/%3E%3C/svg%3E")}.custom-radio .custom-control-input:disabled:checked~.custom-control-label:before{background-color:rgba(52,144,220,.5)}.custom-select{display:inline-block;width:100%;height:calc(2.19rem + 2px);padding:.375rem 1.75rem .375rem .75rem;line-height:1.6;color:#495057;vertical-align:middle;background:#fff url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 4 5'%3E%3Cpath fill='%23343a40' d='M2 0L0 2h4zm0 5L0 3h4z'/%3E%3C/svg%3E") no-repeat right .75rem center;background-size:8px 10px;border:1px solid #ced4da;border-radius:.25rem;-webkit-appearance:none;-moz-appearance:none;appearance:none}.custom-select:focus{border-color:#a1cbef;outline:0;box-shadow:0 0 0 .2rem rgba(161,203,239,.5)}.custom-select:focus::-ms-value{color:#495057;background-color:#fff}.custom-select[multiple],.custom-select[size]:not([size="1"]){height:auto;padding-right:.75rem;background-image:none}.custom-select:disabled{color:#6c757d;background-color:#e9ecef}.custom-select::-ms-expand{opacity:0}.custom-select-sm{height:calc(1.68125rem + 2px);font-size:75%}.custom-select-lg,.custom-select-sm{padding-top:.375rem;padding-bottom:.375rem}.custom-select-lg{height:calc(2.6875rem + 2px);font-size:125%}.custom-file{display:inline-block;margin-bottom:0}.custom-file,.custom-file-input{position:relative;width:100%;height:calc(2.19rem + 2px)}.custom-file-input{z-index:2;margin:0;opacity:0}.custom-file-input:focus~.custom-file-label{border-color:#a1cbef;box-shadow:0 0 0 .2rem rgba(52,144,220,.25)}.custom-file-input:focus~.custom-file-label:after{border-color:#a1cbef}.custom-file-input:disabled~.custom-file-label{background-color:#e9ecef}.custom-file-input:lang(en)~.custom-file-label:after{content:"Browse"}.custom-file-label{left:0;z-index:1;height:calc(2.19rem + 2px);background-color:#fff;border:1px solid #ced4da;border-radius:.25rem}.custom-file-label,.custom-file-label:after{position:absolute;top:0;right:0;padding:.375rem .75rem;line-height:1.6;color:#495057}.custom-file-label:after{bottom:0;z-index:3;display:block;height:2.19rem;content:"Browse";background-color:#e9ecef;border-left:1px solid #ced4da;border-radius:0 .25rem .25rem 0}.custom-range{width:100%;padding-left:0;background-color:transparent;-webkit-appearance:none;-moz-appearance:none;appearance:none}.custom-range:focus{outline:none}.custom-range:focus::-webkit-slider-thumb{box-shadow:0 0 0 1px #f8fafc,0 0 0 .2rem rgba(52,144,220,.25)}.custom-range:focus::-moz-range-thumb{box-shadow:0 0 0 1px #f8fafc,0 0 0 .2rem rgba(52,144,220,.25)}.custom-range:focus::-ms-thumb{box-shadow:0 0 0 1px #f8fafc,0 0 0 .2rem rgba(52,144,220,.25)}.custom-range::-moz-focus-outer{border:0}.custom-range::-webkit-slider-thumb{width:1rem;height:1rem;margin-top:-.25rem;background-color:#3490dc;border:0;border-radius:1rem;transition:background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;-webkit-appearance:none;appearance:none}@media screen and (prefers-reduced-motion:reduce){.custom-range::-webkit-slider-thumb{transition:none}}.custom-range::-webkit-slider-thumb:active{background-color:#cce3f6}.custom-range::-webkit-slider-runnable-track{width:100%;height:.5rem;color:transparent;cursor:pointer;background-color:#dee2e6;border-color:transparent;border-radius:1rem}.custom-range::-moz-range-thumb{width:1rem;height:1rem;background-color:#3490dc;border:0;border-radius:1rem;transition:background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;-moz-appearance:none;appearance:none}@media screen and (prefers-reduced-motion:reduce){.custom-range::-moz-range-thumb{transition:none}}.custom-range::-moz-range-thumb:active{background-color:#cce3f6}.custom-range::-moz-range-track{width:100%;height:.5rem;color:transparent;cursor:pointer;background-color:#dee2e6;border-color:transparent;border-radius:1rem}.custom-range::-ms-thumb{width:1rem;height:1rem;margin-top:0;margin-right:.2rem;margin-left:.2rem;background-color:#3490dc;border:0;border-radius:1rem;transition:background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;appearance:none}@media screen and (prefers-reduced-motion:reduce){.custom-range::-ms-thumb{transition:none}}.custom-range::-ms-thumb:active{background-color:#cce3f6}.custom-range::-ms-track{width:100%;height:.5rem;color:transparent;cursor:pointer;background-color:transparent;border-color:transparent;border-width:.5rem}.custom-range::-ms-fill-lower,.custom-range::-ms-fill-upper{background-color:#dee2e6;border-radius:1rem}.custom-range::-ms-fill-upper{margin-right:15px}.custom-control-label:before,.custom-file-label,.custom-select{transition:background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out}@media screen and (prefers-reduced-motion:reduce){.custom-control-label:before,.custom-file-label,.custom-select{transition:none}}.nav{display:flex;flex-wrap:wrap;padding-left:0;margin-bottom:0;list-style:none}.nav-link{display:block;padding:.5rem 1rem}.nav-link:focus,.nav-link:hover{text-decoration:none}.nav-link.disabled{color:#6c757d}.nav-tabs{border-bottom:1px solid #dee2e6}.nav-tabs .nav-item{margin-bottom:-1px}.nav-tabs .nav-link{border:1px solid transparent;border-top-left-radius:.25rem;border-top-right-radius:.25rem}.nav-tabs .nav-link:focus,.nav-tabs .nav-link:hover{border-color:#e9ecef #e9ecef #dee2e6}.nav-tabs .nav-link.disabled{color:#6c757d;background-color:transparent;border-color:transparent}.nav-tabs .nav-item.show .nav-link,.nav-tabs .nav-link.active{color:#495057;background-color:#f8fafc;border-color:#dee2e6 #dee2e6 #f8fafc}.nav-tabs .dropdown-menu{margin-top:-1px;border-top-left-radius:0;border-top-right-radius:0}.nav-pills .nav-link{border-radius:.25rem}.nav-pills .nav-link.active,.nav-pills .show>.nav-link{color:#fff;background-color:#3490dc}.nav-fill .nav-item{flex:1 1 auto;text-align:center}.nav-justified .nav-item{flex-basis:0;flex-grow:1;text-align:center}.tab-content>.tab-pane{display:none}.tab-content>.active{display:block}.navbar{position:relative;padding:.5rem 1rem}.navbar,.navbar>.container,.navbar>.container-fluid{display:flex;flex-wrap:wrap;align-items:center;justify-content:space-between}.navbar-brand{display:inline-block;padding-top:.32rem;padding-bottom:.32rem;margin-right:1rem;font-size:1.125rem;line-height:inherit;white-space:nowrap}.navbar-brand:focus,.navbar-brand:hover{text-decoration:none}.navbar-nav{display:flex;flex-direction:column;padding-left:0;margin-bottom:0;list-style:none}.navbar-nav .nav-link{padding-right:0;padding-left:0}.navbar-nav .dropdown-menu{position:static;float:none}.navbar-text{display:inline-block;padding-top:.5rem;padding-bottom:.5rem}.navbar-collapse{flex-basis:100%;flex-grow:1;align-items:center}.navbar-toggler{padding:.25rem .75rem;font-size:1.125rem;line-height:1;background-color:transparent;border:1px solid transparent;border-radius:.25rem}.navbar-toggler:focus,.navbar-toggler:hover{text-decoration:none}.navbar-toggler:not(:disabled):not(.disabled){cursor:pointer}.navbar-toggler-icon{display:inline-block;width:1.5em;height:1.5em;vertical-align:middle;content:"";background:no-repeat 50%;background-size:100% 100%}@media (max-width:575.98px){.navbar-expand-sm>.container,.navbar-expand-sm>.container-fluid{padding-right:0;padding-left:0}}@media (min-width:576px){.navbar-expand-sm{flex-flow:row nowrap;justify-content:flex-start}.navbar-expand-sm .navbar-nav{flex-direction:row}.navbar-expand-sm .navbar-nav .dropdown-menu{position:absolute}.navbar-expand-sm .navbar-nav .nav-link{padding-right:.5rem;padding-left:.5rem}.navbar-expand-sm>.container,.navbar-expand-sm>.container-fluid{flex-wrap:nowrap}.navbar-expand-sm .navbar-collapse{display:flex!important;flex-basis:auto}.navbar-expand-sm .navbar-toggler{display:none}}@media (max-width:767.98px){.navbar-expand-md>.container,.navbar-expand-md>.container-fluid{padding-right:0;padding-left:0}}@media (min-width:768px){.navbar-expand-md{flex-flow:row nowrap;justify-content:flex-start}.navbar-expand-md .navbar-nav{flex-direction:row}.navbar-expand-md .navbar-nav .dropdown-menu{position:absolute}.navbar-expand-md .navbar-nav .nav-link{padding-right:.5rem;padding-left:.5rem}.navbar-expand-md>.container,.navbar-expand-md>.container-fluid{flex-wrap:nowrap}.navbar-expand-md .navbar-collapse{display:flex!important;flex-basis:auto}.navbar-expand-md .navbar-toggler{display:none}}@media (max-width:991.98px){.navbar-expand-lg>.container,.navbar-expand-lg>.container-fluid{padding-right:0;padding-left:0}}@media (min-width:992px){.navbar-expand-lg{flex-flow:row nowrap;justify-content:flex-start}.navbar-expand-lg .navbar-nav{flex-direction:row}.navbar-expand-lg .navbar-nav .dropdown-menu{position:absolute}.navbar-expand-lg .navbar-nav .nav-link{padding-right:.5rem;padding-left:.5rem}.navbar-expand-lg>.container,.navbar-expand-lg>.container-fluid{flex-wrap:nowrap}.navbar-expand-lg .navbar-collapse{display:flex!important;flex-basis:auto}.navbar-expand-lg .navbar-toggler{display:none}}@media (max-width:1199.98px){.navbar-expand-xl>.container,.navbar-expand-xl>.container-fluid{padding-right:0;padding-left:0}}@media (min-width:1200px){.navbar-expand-xl{flex-flow:row nowrap;justify-content:flex-start}.navbar-expand-xl .navbar-nav{flex-direction:row}.navbar-expand-xl .navbar-nav .dropdown-menu{position:absolute}.navbar-expand-xl .navbar-nav .nav-link{padding-right:.5rem;padding-left:.5rem}.navbar-expand-xl>.container,.navbar-expand-xl>.container-fluid{flex-wrap:nowrap}.navbar-expand-xl .navbar-collapse{display:flex!important;flex-basis:auto}.navbar-expand-xl .navbar-toggler{display:none}}.navbar-expand{flex-flow:row nowrap;justify-content:flex-start}.navbar-expand>.container,.navbar-expand>.container-fluid{padding-right:0;padding-left:0}.navbar-expand .navbar-nav{flex-direction:row}.navbar-expand .navbar-nav .dropdown-menu{position:absolute}.navbar-expand .navbar-nav .nav-link{padding-right:.5rem;padding-left:.5rem}.navbar-expand>.container,.navbar-expand>.container-fluid{flex-wrap:nowrap}.navbar-expand .navbar-collapse{display:flex!important;flex-basis:auto}.navbar-expand .navbar-toggler{display:none}.navbar-light .navbar-brand,.navbar-light .navbar-brand:focus,.navbar-light .navbar-brand:hover{color:rgba(0,0,0,.9)}.navbar-light .navbar-nav .nav-link{color:rgba(0,0,0,.5)}.navbar-light .navbar-nav .nav-link:focus,.navbar-light .navbar-nav .nav-link:hover{color:rgba(0,0,0,.7)}.navbar-light .navbar-nav .nav-link.disabled{color:rgba(0,0,0,.3)}.navbar-light .navbar-nav .active>.nav-link,.navbar-light .navbar-nav .nav-link.active,.navbar-light .navbar-nav .nav-link.show,.navbar-light .navbar-nav .show>.nav-link{color:rgba(0,0,0,.9)}.navbar-light .navbar-toggler{color:rgba(0,0,0,.5);border-color:rgba(0,0,0,.1)}.navbar-light .navbar-toggler-icon{background-image:url("data:image/svg+xml;charset=utf8,%3Csvg viewBox='0 0 30 30' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath stroke='rgba(0, 0, 0, 0.5)' stroke-width='2' stroke-linecap='round' stroke-miterlimit='10' d='M4 7h22M4 15h22M4 23h22'/%3E%3C/svg%3E")}.navbar-light .navbar-text{color:rgba(0,0,0,.5)}.navbar-light .navbar-text a,.navbar-light .navbar-text a:focus,.navbar-light .navbar-text a:hover{color:rgba(0,0,0,.9)}.navbar-dark .navbar-brand,.navbar-dark .navbar-brand:focus,.navbar-dark .navbar-brand:hover{color:#fff}.navbar-dark .navbar-nav .nav-link{color:hsla(0,0%,100%,.5)}.navbar-dark .navbar-nav .nav-link:focus,.navbar-dark .navbar-nav .nav-link:hover{color:hsla(0,0%,100%,.75)}.navbar-dark .navbar-nav .nav-link.disabled{color:hsla(0,0%,100%,.25)}.navbar-dark .navbar-nav .active>.nav-link,.navbar-dark .navbar-nav .nav-link.active,.navbar-dark .navbar-nav .nav-link.show,.navbar-dark .navbar-nav .show>.nav-link{color:#fff}.navbar-dark .navbar-toggler{color:hsla(0,0%,100%,.5);border-color:hsla(0,0%,100%,.1)}.navbar-dark .navbar-toggler-icon{background-image:url("data:image/svg+xml;charset=utf8,%3Csvg viewBox='0 0 30 30' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath stroke='rgba(255, 255, 255, 0.5)' stroke-width='2' stroke-linecap='round' stroke-miterlimit='10' d='M4 7h22M4 15h22M4 23h22'/%3E%3C/svg%3E")}.navbar-dark .navbar-text{color:hsla(0,0%,100%,.5)}.navbar-dark .navbar-text a,.navbar-dark .navbar-text a:focus,.navbar-dark .navbar-text a:hover{color:#fff}.card{position:relative;display:flex;flex-direction:column;min-width:0;word-wrap:break-word;background-color:#fff;background-clip:border-box;border:1px solid rgba(0,0,0,.125);border-radius:.25rem}.card>hr{margin-right:0;margin-left:0}.card>.list-group:first-child .list-group-item:first-child{border-top-left-radius:.25rem;border-top-right-radius:.25rem}.card>.list-group:last-child .list-group-item:last-child{border-bottom-right-radius:.25rem;border-bottom-left-radius:.25rem}.card-body{flex:1 1 auto;padding:1.25rem}.card-title{margin-bottom:.75rem}.card-subtitle{margin-top:-.375rem}.card-subtitle,.card-text:last-child{margin-bottom:0}.card-link:hover{text-decoration:none}.card-link+.card-link{margin-left:1.25rem}.card-header{padding:.75rem 1.25rem;margin-bottom:0;background-color:rgba(0,0,0,.03);border-bottom:1px solid rgba(0,0,0,.125)}.card-header:first-child{border-radius:calc(.25rem - 1px) calc(.25rem - 1px) 0 0}.card-header+.list-group .list-group-item:first-child{border-top:0}.card-footer{padding:.75rem 1.25rem;background-color:rgba(0,0,0,.03);border-top:1px solid rgba(0,0,0,.125)}.card-footer:last-child{border-radius:0 0 calc(.25rem - 1px) calc(.25rem - 1px)}.card-header-tabs{margin-bottom:-.75rem;border-bottom:0}.card-header-pills,.card-header-tabs{margin-right:-.625rem;margin-left:-.625rem}.card-img-overlay{position:absolute;top:0;right:0;bottom:0;left:0;padding:1.25rem}.card-img{width:100%;border-radius:calc(.25rem - 1px)}.card-img-top{width:100%;border-top-left-radius:calc(.25rem - 1px);border-top-right-radius:calc(.25rem - 1px)}.card-img-bottom{width:100%;border-bottom-right-radius:calc(.25rem - 1px);border-bottom-left-radius:calc(.25rem - 1px)}.card-deck{display:flex;flex-direction:column}.card-deck .card{margin-bottom:15px}@media (min-width:576px){.card-deck{flex-flow:row wrap;margin-right:-15px;margin-left:-15px}.card-deck .card{display:flex;flex:1 0 0%;flex-direction:column;margin-right:15px;margin-bottom:0;margin-left:15px}}.card-group{display:flex;flex-direction:column}.card-group>.card{margin-bottom:15px}@media (min-width:576px){.card-group{flex-flow:row wrap}.card-group>.card{flex:1 0 0%;margin-bottom:0}.card-group>.card+.card{margin-left:0;border-left:0}.card-group>.card:first-child{border-top-right-radius:0;border-bottom-right-radius:0}.card-group>.card:first-child .card-header,.card-group>.card:first-child .card-img-top{border-top-right-radius:0}.card-group>.card:first-child .card-footer,.card-group>.card:first-child .card-img-bottom{border-bottom-right-radius:0}.card-group>.card:last-child{border-top-left-radius:0;border-bottom-left-radius:0}.card-group>.card:last-child .card-header,.card-group>.card:last-child .card-img-top{border-top-left-radius:0}.card-group>.card:last-child .card-footer,.card-group>.card:last-child .card-img-bottom{border-bottom-left-radius:0}.card-group>.card:only-child{border-radius:.25rem}.card-group>.card:only-child .card-header,.card-group>.card:only-child .card-img-top{border-top-left-radius:.25rem;border-top-right-radius:.25rem}.card-group>.card:only-child .card-footer,.card-group>.card:only-child .card-img-bottom{border-bottom-right-radius:.25rem;border-bottom-left-radius:.25rem}.card-group>.card:not(:first-child):not(:last-child):not(:only-child),.card-group>.card:not(:first-child):not(:last-child):not(:only-child) .card-footer,.card-group>.card:not(:first-child):not(:last-child):not(:only-child) .card-header,.card-group>.card:not(:first-child):not(:last-child):not(:only-child) .card-img-bottom,.card-group>.card:not(:first-child):not(:last-child):not(:only-child) .card-img-top{border-radius:0}}.card-columns .card{margin-bottom:.75rem}@media (min-width:576px){.card-columns{-webkit-column-count:3;column-count:3;-webkit-column-gap:1.25rem;column-gap:1.25rem;orphans:1;widows:1}.card-columns .card{display:inline-block;width:100%}}.accordion .card:not(:first-of-type):not(:last-of-type){border-bottom:0;border-radius:0}.accordion .card:not(:first-of-type) .card-header:first-child{border-radius:0}.accordion .card:first-of-type{border-bottom:0;border-bottom-right-radius:0;border-bottom-left-radius:0}.accordion .card:last-of-type{border-top-left-radius:0;border-top-right-radius:0}.breadcrumb{display:flex;flex-wrap:wrap;padding:.75rem 1rem;margin-bottom:1rem;list-style:none;background-color:#e9ecef;border-radius:.25rem}.breadcrumb-item+.breadcrumb-item{padding-left:.5rem}.breadcrumb-item+.breadcrumb-item:before{display:inline-block;padding-right:.5rem;color:#6c757d;content:"/"}.breadcrumb-item+.breadcrumb-item:hover:before{text-decoration:underline;text-decoration:none}.breadcrumb-item.active{color:#6c757d}.pagination{display:flex;padding-left:0;list-style:none;border-radius:.25rem}.page-link{position:relative;display:block;padding:.5rem .75rem;margin-left:-1px;line-height:1.25;color:#3490dc;background-color:#fff;border:1px solid #dee2e6}.page-link:hover{z-index:2;color:#1d68a7;text-decoration:none;background-color:#e9ecef;border-color:#dee2e6}.page-link:focus{z-index:2;outline:0;box-shadow:0 0 0 .2rem rgba(52,144,220,.25)}.page-link:not(:disabled):not(.disabled){cursor:pointer}.page-item:first-child .page-link{margin-left:0;border-top-left-radius:.25rem;border-bottom-left-radius:.25rem}.page-item:last-child .page-link{border-top-right-radius:.25rem;border-bottom-right-radius:.25rem}.page-item.active .page-link{z-index:1;color:#fff;background-color:#3490dc;border-color:#3490dc}.page-item.disabled .page-link{color:#6c757d;pointer-events:none;cursor:auto;background-color:#fff;border-color:#dee2e6}.pagination-lg .page-link{padding:.75rem 1.5rem;font-size:1.125rem;line-height:1.5}.pagination-lg .page-item:first-child .page-link{border-top-left-radius:.3rem;border-bottom-left-radius:.3rem}.pagination-lg .page-item:last-child .page-link{border-top-right-radius:.3rem;border-bottom-right-radius:.3rem}.pagination-sm .page-link{padding:.25rem .5rem;font-size:.7875rem;line-height:1.5}.pagination-sm .page-item:first-child .page-link{border-top-left-radius:.2rem;border-bottom-left-radius:.2rem}.pagination-sm .page-item:last-child .page-link{border-top-right-radius:.2rem;border-bottom-right-radius:.2rem}.badge{display:inline-block;padding:.25em .4em;font-size:75%;font-weight:700;line-height:1;text-align:center;white-space:nowrap;vertical-align:baseline;border-radius:.25rem}.badge:empty{display:none}.btn .badge{position:relative;top:-1px}.badge-pill{padding-right:.6em;padding-left:.6em;border-radius:10rem}.badge-primary{color:#fff;background-color:#3490dc}.badge-primary[href]:focus,.badge-primary[href]:hover{color:#fff;text-decoration:none;background-color:#2176bd}.badge-secondary{color:#fff;background-color:#6c757d}.badge-secondary[href]:focus,.badge-secondary[href]:hover{color:#fff;text-decoration:none;background-color:#545b62}.badge-success{color:#fff;background-color:#38c172}.badge-success[href]:focus,.badge-success[href]:hover{color:#fff;text-decoration:none;background-color:#2d995b}.badge-info{color:#212529;background-color:#6cb2eb}.badge-info[href]:focus,.badge-info[href]:hover{color:#212529;text-decoration:none;background-color:#3f9ae5}.badge-warning{color:#212529;background-color:#ffed4a}.badge-warning[href]:focus,.badge-warning[href]:hover{color:#212529;text-decoration:none;background-color:#ffe817}.badge-danger{color:#fff;background-color:#e3342f}.badge-danger[href]:focus,.badge-danger[href]:hover{color:#fff;text-decoration:none;background-color:#c51f1a}.badge-light{color:#212529;background-color:#f8f9fa}.badge-light[href]:focus,.badge-light[href]:hover{color:#212529;text-decoration:none;background-color:#dae0e5}.badge-dark{color:#fff;background-color:#343a40}.badge-dark[href]:focus,.badge-dark[href]:hover{color:#fff;text-decoration:none;background-color:#1d2124}.jumbotron{padding:2rem 1rem;margin-bottom:2rem;background-color:#e9ecef;border-radius:.3rem}@media (min-width:576px){.jumbotron{padding:4rem 2rem}}.jumbotron-fluid{padding-right:0;padding-left:0;border-radius:0}.alert{position:relative;padding:.75rem 1.25rem;margin-bottom:1rem;border:1px solid transparent;border-radius:.25rem}.alert-heading{color:inherit}.alert-link{font-weight:700}.alert-dismissible{padding-right:3.85rem}.alert-dismissible .close{position:absolute;top:0;right:0;padding:.75rem 1.25rem;color:inherit}.alert-primary{color:#1b4b72;background-color:#d6e9f8;border-color:#c6e0f5}.alert-primary hr{border-top-color:#b0d4f1}.alert-primary .alert-link{color:#113049}.alert-secondary{color:#383d41;background-color:#e2e3e5;border-color:#d6d8db}.alert-secondary hr{border-top-color:#c8cbcf}.alert-secondary .alert-link{color:#202326}.alert-success{color:#1d643b;background-color:#d7f3e3;border-color:#c7eed8}.alert-success hr{border-top-color:#b3e8ca}.alert-success .alert-link{color:#123c24}.alert-info{color:#385d7a;background-color:#e2f0fb;border-color:#d6e9f9}.alert-info hr{border-top-color:#c0ddf6}.alert-info .alert-link{color:#284257}.alert-warning{color:#857b26;background-color:#fffbdb;border-color:#fffacc}.alert-warning hr{border-top-color:#fff8b3}.alert-warning .alert-link{color:#5d561b}.alert-danger{color:#761b18;background-color:#f9d6d5;border-color:#f7c6c5}.alert-danger hr{border-top-color:#f4b0af}.alert-danger .alert-link{color:#4c110f}.alert-light{color:#818182;background-color:#fefefe;border-color:#fdfdfe}.alert-light hr{border-top-color:#ececf6}.alert-light .alert-link{color:#686868}.alert-dark{color:#1b1e21;background-color:#d6d8d9;border-color:#c6c8ca}.alert-dark hr{border-top-color:#b9bbbe}.alert-dark .alert-link{color:#040505}@-webkit-keyframes progress-bar-stripes{0%{background-position:1rem 0}to{background-position:0 0}}@keyframes progress-bar-stripes{0%{background-position:1rem 0}to{background-position:0 0}}.progress{display:flex;height:1rem;overflow:hidden;font-size:.675rem;background-color:#e9ecef;border-radius:.25rem}.progress-bar{display:flex;flex-direction:column;justify-content:center;color:#fff;text-align:center;white-space:nowrap;background-color:#3490dc;transition:width .6s ease}@media screen and (prefers-reduced-motion:reduce){.progress-bar{transition:none}}.progress-bar-striped{background-image:linear-gradient(45deg,hsla(0,0%,100%,.15) 25%,transparent 0,transparent 50%,hsla(0,0%,100%,.15) 0,hsla(0,0%,100%,.15) 75%,transparent 0,transparent);background-size:1rem 1rem}.progress-bar-animated{-webkit-animation:progress-bar-stripes 1s linear infinite;animation:progress-bar-stripes 1s linear infinite}.media{display:flex;align-items:flex-start}.media-body{flex:1}.list-group{display:flex;flex-direction:column;padding-left:0;margin-bottom:0}.list-group-item-action{width:100%;color:#495057;text-align:inherit}.list-group-item-action:focus,.list-group-item-action:hover{color:#495057;text-decoration:none;background-color:#f8f9fa}.list-group-item-action:active{color:#212529;background-color:#e9ecef}.list-group-item{position:relative;display:block;padding:.75rem 1.25rem;margin-bottom:-1px;background-color:#fff;border:1px solid rgba(0,0,0,.125)}.list-group-item:first-child{border-top-left-radius:.25rem;border-top-right-radius:.25rem}.list-group-item:last-child{margin-bottom:0;border-bottom-right-radius:.25rem;border-bottom-left-radius:.25rem}.list-group-item:focus,.list-group-item:hover{z-index:1;text-decoration:none}.list-group-item.disabled,.list-group-item:disabled{color:#6c757d;background-color:#fff}.list-group-item.active{z-index:2;color:#fff;background-color:#3490dc;border-color:#3490dc}.list-group-flush .list-group-item{border-right:0;border-left:0;border-radius:0}.list-group-flush:first-child .list-group-item:first-child{border-top:0}.list-group-flush:last-child .list-group-item:last-child{border-bottom:0}.list-group-item-primary{color:#1b4b72;background-color:#c6e0f5}.list-group-item-primary.list-group-item-action:focus,.list-group-item-primary.list-group-item-action:hover{color:#1b4b72;background-color:#b0d4f1}.list-group-item-primary.list-group-item-action.active{color:#fff;background-color:#1b4b72;border-color:#1b4b72}.list-group-item-secondary{color:#383d41;background-color:#d6d8db}.list-group-item-secondary.list-group-item-action:focus,.list-group-item-secondary.list-group-item-action:hover{color:#383d41;background-color:#c8cbcf}.list-group-item-secondary.list-group-item-action.active{color:#fff;background-color:#383d41;border-color:#383d41}.list-group-item-success{color:#1d643b;background-color:#c7eed8}.list-group-item-success.list-group-item-action:focus,.list-group-item-success.list-group-item-action:hover{color:#1d643b;background-color:#b3e8ca}.list-group-item-success.list-group-item-action.active{color:#fff;background-color:#1d643b;border-color:#1d643b}.list-group-item-info{color:#385d7a;background-color:#d6e9f9}.list-group-item-info.list-group-item-action:focus,.list-group-item-info.list-group-item-action:hover{color:#385d7a;background-color:#c0ddf6}.list-group-item-info.list-group-item-action.active{color:#fff;background-color:#385d7a;border-color:#385d7a}.list-group-item-warning{color:#857b26;background-color:#fffacc}.list-group-item-warning.list-group-item-action:focus,.list-group-item-warning.list-group-item-action:hover{color:#857b26;background-color:#fff8b3}.list-group-item-warning.list-group-item-action.active{color:#fff;background-color:#857b26;border-color:#857b26}.list-group-item-danger{color:#761b18;background-color:#f7c6c5}.list-group-item-danger.list-group-item-action:focus,.list-group-item-danger.list-group-item-action:hover{color:#761b18;background-color:#f4b0af}.list-group-item-danger.list-group-item-action.active{color:#fff;background-color:#761b18;border-color:#761b18}.list-group-item-light{color:#818182;background-color:#fdfdfe}.list-group-item-light.list-group-item-action:focus,.list-group-item-light.list-group-item-action:hover{color:#818182;background-color:#ececf6}.list-group-item-light.list-group-item-action.active{color:#fff;background-color:#818182;border-color:#818182}.list-group-item-dark{color:#1b1e21;background-color:#c6c8ca}.list-group-item-dark.list-group-item-action:focus,.list-group-item-dark.list-group-item-action:hover{color:#1b1e21;background-color:#b9bbbe}.list-group-item-dark.list-group-item-action.active{color:#fff;background-color:#1b1e21;border-color:#1b1e21}.close{float:right;font-size:1.35rem;font-weight:700;line-height:1;color:#000;text-shadow:0 1px 0 #fff;opacity:.5}.close:not(:disabled):not(.disabled){cursor:pointer}.close:not(:disabled):not(.disabled):focus,.close:not(:disabled):not(.disabled):hover{color:#000;text-decoration:none;opacity:.75}button.close{padding:0;background-color:transparent;border:0;-webkit-appearance:none}.modal-open{overflow:hidden}.modal-open .modal{overflow-x:hidden;overflow-y:auto}.modal{position:fixed;top:0;right:0;bottom:0;left:0;z-index:1050;display:none;overflow:hidden;outline:0}.modal-dialog{position:relative;width:auto;margin:.5rem;pointer-events:none}.modal.fade .modal-dialog{transition:-webkit-transform .3s ease-out;transition:transform .3s ease-out;transition:transform .3s ease-out,-webkit-transform .3s ease-out;-webkit-transform:translateY(-25%);transform:translateY(-25%)}@media screen and (prefers-reduced-motion:reduce){.modal.fade .modal-dialog{transition:none}}.modal.show .modal-dialog{-webkit-transform:translate(0);transform:translate(0)}.modal-dialog-centered{display:flex;align-items:center;min-height:calc(100% - 1rem)}.modal-dialog-centered:before{display:block;height:calc(100vh - 1rem);content:""}.modal-content{position:relative;display:flex;flex-direction:column;width:100%;pointer-events:auto;background-color:#fff;background-clip:padding-box;border:1px solid rgba(0,0,0,.2);border-radius:.3rem;outline:0}.modal-backdrop{position:fixed;top:0;right:0;bottom:0;left:0;z-index:1040;background-color:#000}.modal-backdrop.fade{opacity:0}.modal-backdrop.show{opacity:.5}.modal-header{display:flex;align-items:flex-start;justify-content:space-between;padding:1rem;border-bottom:1px solid #e9ecef;border-top-left-radius:.3rem;border-top-right-radius:.3rem}.modal-header .close{padding:1rem;margin:-1rem -1rem -1rem auto}.modal-title{margin-bottom:0;line-height:1.6}.modal-body{position:relative;flex:1 1 auto;padding:1rem}.modal-footer{display:flex;align-items:center;justify-content:flex-end;padding:1rem;border-top:1px solid #e9ecef}.modal-footer>:not(:first-child){margin-left:.25rem}.modal-footer>:not(:last-child){margin-right:.25rem}.modal-scrollbar-measure{position:absolute;top:-9999px;width:50px;height:50px;overflow:scroll}@media (min-width:576px){.modal-dialog{max-width:500px;margin:1.75rem auto}.modal-dialog-centered{min-height:calc(100% - 3.5rem)}.modal-dialog-centered:before{height:calc(100vh - 3.5rem)}.modal-sm{max-width:300px}}@media (min-width:992px){.modal-lg{max-width:800px}}.tooltip{position:absolute;z-index:1070;display:block;margin:0;font-family:Nunito,sans-serif;font-style:normal;font-weight:400;line-height:1.6;text-align:left;text-align:start;text-decoration:none;text-shadow:none;text-transform:none;letter-spacing:normal;word-break:normal;word-spacing:normal;white-space:normal;line-break:auto;font-size:.7875rem;word-wrap:break-word;opacity:0}.tooltip.show{opacity:.9}.tooltip .arrow{position:absolute;display:block;width:.8rem;height:.4rem}.tooltip .arrow:before{position:absolute;content:"";border-color:transparent;border-style:solid}.bs-tooltip-auto[x-placement^=top],.bs-tooltip-top{padding:.4rem 0}.bs-tooltip-auto[x-placement^=top] .arrow,.bs-tooltip-top .arrow{bottom:0}.bs-tooltip-auto[x-placement^=top] .arrow:before,.bs-tooltip-top .arrow:before{top:0;border-width:.4rem .4rem 0;border-top-color:#000}.bs-tooltip-auto[x-placement^=right],.bs-tooltip-right{padding:0 .4rem}.bs-tooltip-auto[x-placement^=right] .arrow,.bs-tooltip-right .arrow{left:0;width:.4rem;height:.8rem}.bs-tooltip-auto[x-placement^=right] .arrow:before,.bs-tooltip-right .arrow:before{right:0;border-width:.4rem .4rem .4rem 0;border-right-color:#000}.bs-tooltip-auto[x-placement^=bottom],.bs-tooltip-bottom{padding:.4rem 0}.bs-tooltip-auto[x-placement^=bottom] .arrow,.bs-tooltip-bottom .arrow{top:0}.bs-tooltip-auto[x-placement^=bottom] .arrow:before,.bs-tooltip-bottom .arrow:before{bottom:0;border-width:0 .4rem .4rem;border-bottom-color:#000}.bs-tooltip-auto[x-placement^=left],.bs-tooltip-left{padding:0 .4rem}.bs-tooltip-auto[x-placement^=left] .arrow,.bs-tooltip-left .arrow{right:0;width:.4rem;height:.8rem}.bs-tooltip-auto[x-placement^=left] .arrow:before,.bs-tooltip-left .arrow:before{left:0;border-width:.4rem 0 .4rem .4rem;border-left-color:#000}.tooltip-inner{max-width:200px;padding:.25rem .5rem;color:#fff;text-align:center;background-color:#000;border-radius:.25rem}.popover{top:0;left:0;z-index:1060;max-width:276px;font-family:Nunito,sans-serif;font-style:normal;font-weight:400;line-height:1.6;text-align:left;text-align:start;text-decoration:none;text-shadow:none;text-transform:none;letter-spacing:normal;word-break:normal;word-spacing:normal;white-space:normal;line-break:auto;font-size:.7875rem;word-wrap:break-word;background-color:#fff;background-clip:padding-box;border:1px solid rgba(0,0,0,.2);border-radius:.3rem}.popover,.popover .arrow{position:absolute;display:block}.popover .arrow{width:1rem;height:.5rem;margin:0 .3rem}.popover .arrow:after,.popover .arrow:before{position:absolute;display:block;content:"";border-color:transparent;border-style:solid}.bs-popover-auto[x-placement^=top],.bs-popover-top{margin-bottom:.5rem}.bs-popover-auto[x-placement^=top] .arrow,.bs-popover-top .arrow{bottom:calc(-.5rem + -1px)}.bs-popover-auto[x-placement^=top] .arrow:after,.bs-popover-auto[x-placement^=top] .arrow:before,.bs-popover-top .arrow:after,.bs-popover-top .arrow:before{border-width:.5rem .5rem 0}.bs-popover-auto[x-placement^=top] .arrow:before,.bs-popover-top .arrow:before{bottom:0;border-top-color:rgba(0,0,0,.25)}.bs-popover-auto[x-placement^=top] .arrow:after,.bs-popover-top .arrow:after{bottom:1px;border-top-color:#fff}.bs-popover-auto[x-placement^=right],.bs-popover-right{margin-left:.5rem}.bs-popover-auto[x-placement^=right] .arrow,.bs-popover-right .arrow{left:calc(-.5rem + -1px);width:.5rem;height:1rem;margin:.3rem 0}.bs-popover-auto[x-placement^=right] .arrow:after,.bs-popover-auto[x-placement^=right] .arrow:before,.bs-popover-right .arrow:after,.bs-popover-right .arrow:before{border-width:.5rem .5rem .5rem 0}.bs-popover-auto[x-placement^=right] .arrow:before,.bs-popover-right .arrow:before{left:0;border-right-color:rgba(0,0,0,.25)}.bs-popover-auto[x-placement^=right] .arrow:after,.bs-popover-right .arrow:after{left:1px;border-right-color:#fff}.bs-popover-auto[x-placement^=bottom],.bs-popover-bottom{margin-top:.5rem}.bs-popover-auto[x-placement^=bottom] .arrow,.bs-popover-bottom .arrow{top:calc(-.5rem + -1px)}.bs-popover-auto[x-placement^=bottom] .arrow:after,.bs-popover-auto[x-placement^=bottom] .arrow:before,.bs-popover-bottom .arrow:after,.bs-popover-bottom .arrow:before{border-width:0 .5rem .5rem}.bs-popover-auto[x-placement^=bottom] .arrow:before,.bs-popover-bottom .arrow:before{top:0;border-bottom-color:rgba(0,0,0,.25)}.bs-popover-auto[x-placement^=bottom] .arrow:after,.bs-popover-bottom .arrow:after{top:1px;border-bottom-color:#fff}.bs-popover-auto[x-placement^=bottom] .popover-header:before,.bs-popover-bottom .popover-header:before{position:absolute;top:0;left:50%;display:block;width:1rem;margin-left:-.5rem;content:"";border-bottom:1px solid #f7f7f7}.bs-popover-auto[x-placement^=left],.bs-popover-left{margin-right:.5rem}.bs-popover-auto[x-placement^=left] .arrow,.bs-popover-left .arrow{right:calc(-.5rem + -1px);width:.5rem;height:1rem;margin:.3rem 0}.bs-popover-auto[x-placement^=left] .arrow:after,.bs-popover-auto[x-placement^=left] .arrow:before,.bs-popover-left .arrow:after,.bs-popover-left .arrow:before{border-width:.5rem 0 .5rem .5rem}.bs-popover-auto[x-placement^=left] .arrow:before,.bs-popover-left .arrow:before{right:0;border-left-color:rgba(0,0,0,.25)}.bs-popover-auto[x-placement^=left] .arrow:after,.bs-popover-left .arrow:after{right:1px;border-left-color:#fff}.popover-header{padding:.5rem .75rem;margin-bottom:0;font-size:.9rem;color:inherit;background-color:#f7f7f7;border-bottom:1px solid #ebebeb;border-top-left-radius:calc(.3rem - 1px);border-top-right-radius:calc(.3rem - 1px)}.popover-header:empty{display:none}.popover-body{padding:.5rem .75rem;color:#212529}.carousel{position:relative}.carousel-inner{position:relative;width:100%;overflow:hidden}.carousel-item{position:relative;display:none;align-items:center;width:100%;-webkit-backface-visibility:hidden;backface-visibility:hidden;-webkit-perspective:1000px;perspective:1000px}.carousel-item-next,.carousel-item-prev,.carousel-item.active{display:block;transition:-webkit-transform .6s ease;transition:transform .6s ease;transition:transform .6s ease,-webkit-transform .6s ease}@media screen and (prefers-reduced-motion:reduce){.carousel-item-next,.carousel-item-prev,.carousel-item.active{transition:none}}.carousel-item-next,.carousel-item-prev{position:absolute;top:0}.carousel-item-next.carousel-item-left,.carousel-item-prev.carousel-item-right{-webkit-transform:translateX(0);transform:translateX(0)}@supports ((-webkit-transform-style:preserve-3d) or (transform-style:preserve-3d)){.carousel-item-next.carousel-item-left,.carousel-item-prev.carousel-item-right{-webkit-transform:translateZ(0);transform:translateZ(0)}}.active.carousel-item-right,.carousel-item-next{-webkit-transform:translateX(100%);transform:translateX(100%)}@supports ((-webkit-transform-style:preserve-3d) or (transform-style:preserve-3d)){.active.carousel-item-right,.carousel-item-next{-webkit-transform:translate3d(100%,0,0);transform:translate3d(100%,0,0)}}.active.carousel-item-left,.carousel-item-prev{-webkit-transform:translateX(-100%);transform:translateX(-100%)}@supports ((-webkit-transform-style:preserve-3d) or (transform-style:preserve-3d)){.active.carousel-item-left,.carousel-item-prev{-webkit-transform:translate3d(-100%,0,0);transform:translate3d(-100%,0,0)}}.carousel-fade .carousel-item{opacity:0;transition-duration:.6s;transition-property:opacity}.carousel-fade .carousel-item-next.carousel-item-left,.carousel-fade .carousel-item-prev.carousel-item-right,.carousel-fade .carousel-item.active{opacity:1}.carousel-fade .active.carousel-item-left,.carousel-fade .active.carousel-item-right{opacity:0}.carousel-fade .active.carousel-item-left,.carousel-fade .active.carousel-item-prev,.carousel-fade .carousel-item-next,.carousel-fade .carousel-item-prev,.carousel-fade .carousel-item.active{-webkit-transform:translateX(0);transform:translateX(0)}@supports ((-webkit-transform-style:preserve-3d) or (transform-style:preserve-3d)){.carousel-fade .active.carousel-item-left,.carousel-fade .active.carousel-item-prev,.carousel-fade .carousel-item-next,.carousel-fade .carousel-item-prev,.carousel-fade .carousel-item.active{-webkit-transform:translateZ(0);transform:translateZ(0)}}.carousel-control-next,.carousel-control-prev{position:absolute;top:0;bottom:0;display:flex;align-items:center;justify-content:center;width:15%;color:#fff;text-align:center;opacity:.5}.carousel-control-next:focus,.carousel-control-next:hover,.carousel-control-prev:focus,.carousel-control-prev:hover{color:#fff;text-decoration:none;outline:0;opacity:.9}.carousel-control-prev{left:0}.carousel-control-next{right:0}.carousel-control-next-icon,.carousel-control-prev-icon{display:inline-block;width:20px;height:20px;background:transparent no-repeat 50%;background-size:100% 100%}.carousel-control-prev-icon{background-image:url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='%23fff' viewBox='0 0 8 8'%3E%3Cpath d='M5.25 0l-4 4 4 4 1.5-1.5-2.5-2.5 2.5-2.5-1.5-1.5z'/%3E%3C/svg%3E")}.carousel-control-next-icon{background-image:url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='%23fff' viewBox='0 0 8 8'%3E%3Cpath d='M2.75 0l-1.5 1.5 2.5 2.5-2.5 2.5 1.5 1.5 4-4-4-4z'/%3E%3C/svg%3E")}.carousel-indicators{position:absolute;right:0;bottom:10px;left:0;z-index:15;display:flex;justify-content:center;padding-left:0;margin-right:15%;margin-left:15%;list-style:none}.carousel-indicators li{position:relative;flex:0 1 auto;width:30px;height:3px;margin-right:3px;margin-left:3px;text-indent:-999px;cursor:pointer;background-color:hsla(0,0%,100%,.5)}.carousel-indicators li:before{top:-10px}.carousel-indicators li:after,.carousel-indicators li:before{position:absolute;left:0;display:inline-block;width:100%;height:10px;content:""}.carousel-indicators li:after{bottom:-10px}.carousel-indicators .active{background-color:#fff}.carousel-caption{position:absolute;right:15%;bottom:20px;left:15%;z-index:10;padding-top:20px;padding-bottom:20px;color:#fff;text-align:center}.align-baseline{vertical-align:baseline!important}.align-top{vertical-align:top!important}.align-middle{vertical-align:middle!important}.align-bottom{vertical-align:bottom!important}.align-text-bottom{vertical-align:text-bottom!important}.align-text-top{vertical-align:text-top!important}.bg-primary{background-color:#3490dc!important}a.bg-primary:focus,a.bg-primary:hover,button.bg-primary:focus,button.bg-primary:hover{background-color:#2176bd!important}.bg-secondary{background-color:#6c757d!important}a.bg-secondary:focus,a.bg-secondary:hover,button.bg-secondary:focus,button.bg-secondary:hover{background-color:#545b62!important}.bg-success{background-color:#38c172!important}a.bg-success:focus,a.bg-success:hover,button.bg-success:focus,button.bg-success:hover{background-color:#2d995b!important}.bg-info{background-color:#6cb2eb!important}a.bg-info:focus,a.bg-info:hover,button.bg-info:focus,button.bg-info:hover{background-color:#3f9ae5!important}.bg-warning{background-color:#ffed4a!important}a.bg-warning:focus,a.bg-warning:hover,button.bg-warning:focus,button.bg-warning:hover{background-color:#ffe817!important}.bg-danger{background-color:#e3342f!important}a.bg-danger:focus,a.bg-danger:hover,button.bg-danger:focus,button.bg-danger:hover{background-color:#c51f1a!important}.bg-light{background-color:#f8f9fa!important}a.bg-light:focus,a.bg-light:hover,button.bg-light:focus,button.bg-light:hover{background-color:#dae0e5!important}.bg-dark{background-color:#343a40!important}a.bg-dark:focus,a.bg-dark:hover,button.bg-dark:focus,button.bg-dark:hover{background-color:#1d2124!important}.bg-white{background-color:#fff!important}.bg-transparent{background-color:transparent!important}.border{border:1px solid #dee2e6!important}.border-top{border-top:1px solid #dee2e6!important}.border-right{border-right:1px solid #dee2e6!important}.border-bottom{border-bottom:1px solid #dee2e6!important}.border-left{border-left:1px solid #dee2e6!important}.border-0{border:0!important}.border-top-0{border-top:0!important}.border-right-0{border-right:0!important}.border-bottom-0{border-bottom:0!important}.border-left-0{border-left:0!important}.border-primary{border-color:#3490dc!important}.border-secondary{border-color:#6c757d!important}.border-success{border-color:#38c172!important}.border-info{border-color:#6cb2eb!important}.border-warning{border-color:#ffed4a!important}.border-danger{border-color:#e3342f!important}.border-light{border-color:#f8f9fa!important}.border-dark{border-color:#343a40!important}.border-white{border-color:#fff!important}.rounded{border-radius:.25rem!important}.rounded-top{border-top-left-radius:.25rem!important}.rounded-right,.rounded-top{border-top-right-radius:.25rem!important}.rounded-bottom,.rounded-right{border-bottom-right-radius:.25rem!important}.rounded-bottom,.rounded-left{border-bottom-left-radius:.25rem!important}.rounded-left{border-top-left-radius:.25rem!important}.rounded-circle{border-radius:50%!important}.rounded-0{border-radius:0!important}.clearfix:after{display:block;clear:both;content:""}.d-none{display:none!important}.d-inline{display:inline!important}.d-inline-block{display:inline-block!important}.d-block{display:block!important}.d-table{display:table!important}.d-table-row{display:table-row!important}.d-table-cell{display:table-cell!important}.d-flex{display:flex!important}.d-inline-flex{display:inline-flex!important}@media (min-width:576px){.d-sm-none{display:none!important}.d-sm-inline{display:inline!important}.d-sm-inline-block{display:inline-block!important}.d-sm-block{display:block!important}.d-sm-table{display:table!important}.d-sm-table-row{display:table-row!important}.d-sm-table-cell{display:table-cell!important}.d-sm-flex{display:flex!important}.d-sm-inline-flex{display:inline-flex!important}}@media (min-width:768px){.d-md-none{display:none!important}.d-md-inline{display:inline!important}.d-md-inline-block{display:inline-block!important}.d-md-block{display:block!important}.d-md-table{display:table!important}.d-md-table-row{display:table-row!important}.d-md-table-cell{display:table-cell!important}.d-md-flex{display:flex!important}.d-md-inline-flex{display:inline-flex!important}}@media (min-width:992px){.d-lg-none{display:none!important}.d-lg-inline{display:inline!important}.d-lg-inline-block{display:inline-block!important}.d-lg-block{display:block!important}.d-lg-table{display:table!important}.d-lg-table-row{display:table-row!important}.d-lg-table-cell{display:table-cell!important}.d-lg-flex{display:flex!important}.d-lg-inline-flex{display:inline-flex!important}}@media (min-width:1200px){.d-xl-none{display:none!important}.d-xl-inline{display:inline!important}.d-xl-inline-block{display:inline-block!important}.d-xl-block{display:block!important}.d-xl-table{display:table!important}.d-xl-table-row{display:table-row!important}.d-xl-table-cell{display:table-cell!important}.d-xl-flex{display:flex!important}.d-xl-inline-flex{display:inline-flex!important}}@media print{.d-print-none{display:none!important}.d-print-inline{display:inline!important}.d-print-inline-block{display:inline-block!important}.d-print-block{display:block!important}.d-print-table{display:table!important}.d-print-table-row{display:table-row!important}.d-print-table-cell{display:table-cell!important}.d-print-flex{display:flex!important}.d-print-inline-flex{display:inline-flex!important}}.embed-responsive{position:relative;display:block;width:100%;padding:0;overflow:hidden}.embed-responsive:before{display:block;content:""}.embed-responsive .embed-responsive-item,.embed-responsive embed,.embed-responsive iframe,.embed-responsive object,.embed-responsive video{position:absolute;top:0;bottom:0;left:0;width:100%;height:100%;border:0}.embed-responsive-21by9:before{padding-top:42.8571428571%}.embed-responsive-16by9:before{padding-top:56.25%}.embed-responsive-4by3:before{padding-top:75%}.embed-responsive-1by1:before{padding-top:100%}.flex-row{flex-direction:row!important}.flex-column{flex-direction:column!important}.flex-row-reverse{flex-direction:row-reverse!important}.flex-column-reverse{flex-direction:column-reverse!important}.flex-wrap{flex-wrap:wrap!important}.flex-nowrap{flex-wrap:nowrap!important}.flex-wrap-reverse{flex-wrap:wrap-reverse!important}.flex-fill{flex:1 1 auto!important}.flex-grow-0{flex-grow:0!important}.flex-grow-1{flex-grow:1!important}.flex-shrink-0{flex-shrink:0!important}.flex-shrink-1{flex-shrink:1!important}.justify-content-start{justify-content:flex-start!important}.justify-content-end{justify-content:flex-end!important}.justify-content-center{justify-content:center!important}.justify-content-between{justify-content:space-between!important}.justify-content-around{justify-content:space-around!important}.align-items-start{align-items:flex-start!important}.align-items-end{align-items:flex-end!important}.align-items-center{align-items:center!important}.align-items-baseline{align-items:baseline!important}.align-items-stretch{align-items:stretch!important}.align-content-start{align-content:flex-start!important}.align-content-end{align-content:flex-end!important}.align-content-center{align-content:center!important}.align-content-between{align-content:space-between!important}.align-content-around{align-content:space-around!important}.align-content-stretch{align-content:stretch!important}.align-self-auto{align-self:auto!important}.align-self-start{align-self:flex-start!important}.align-self-end{align-self:flex-end!important}.align-self-center{align-self:center!important}.align-self-baseline{align-self:baseline!important}.align-self-stretch{align-self:stretch!important}@media (min-width:576px){.flex-sm-row{flex-direction:row!important}.flex-sm-column{flex-direction:column!important}.flex-sm-row-reverse{flex-direction:row-reverse!important}.flex-sm-column-reverse{flex-direction:column-reverse!important}.flex-sm-wrap{flex-wrap:wrap!important}.flex-sm-nowrap{flex-wrap:nowrap!important}.flex-sm-wrap-reverse{flex-wrap:wrap-reverse!important}.flex-sm-fill{flex:1 1 auto!important}.flex-sm-grow-0{flex-grow:0!important}.flex-sm-grow-1{flex-grow:1!important}.flex-sm-shrink-0{flex-shrink:0!important}.flex-sm-shrink-1{flex-shrink:1!important}.justify-content-sm-start{justify-content:flex-start!important}.justify-content-sm-end{justify-content:flex-end!important}.justify-content-sm-center{justify-content:center!important}.justify-content-sm-between{justify-content:space-between!important}.justify-content-sm-around{justify-content:space-around!important}.align-items-sm-start{align-items:flex-start!important}.align-items-sm-end{align-items:flex-end!important}.align-items-sm-center{align-items:center!important}.align-items-sm-baseline{align-items:baseline!important}.align-items-sm-stretch{align-items:stretch!important}.align-content-sm-start{align-content:flex-start!important}.align-content-sm-end{align-content:flex-end!important}.align-content-sm-center{align-content:center!important}.align-content-sm-between{align-content:space-between!important}.align-content-sm-around{align-content:space-around!important}.align-content-sm-stretch{align-content:stretch!important}.align-self-sm-auto{align-self:auto!important}.align-self-sm-start{align-self:flex-start!important}.align-self-sm-end{align-self:flex-end!important}.align-self-sm-center{align-self:center!important}.align-self-sm-baseline{align-self:baseline!important}.align-self-sm-stretch{align-self:stretch!important}}@media (min-width:768px){.flex-md-row{flex-direction:row!important}.flex-md-column{flex-direction:column!important}.flex-md-row-reverse{flex-direction:row-reverse!important}.flex-md-column-reverse{flex-direction:column-reverse!important}.flex-md-wrap{flex-wrap:wrap!important}.flex-md-nowrap{flex-wrap:nowrap!important}.flex-md-wrap-reverse{flex-wrap:wrap-reverse!important}.flex-md-fill{flex:1 1 auto!important}.flex-md-grow-0{flex-grow:0!important}.flex-md-grow-1{flex-grow:1!important}.flex-md-shrink-0{flex-shrink:0!important}.flex-md-shrink-1{flex-shrink:1!important}.justify-content-md-start{justify-content:flex-start!important}.justify-content-md-end{justify-content:flex-end!important}.justify-content-md-center{justify-content:center!important}.justify-content-md-between{justify-content:space-between!important}.justify-content-md-around{justify-content:space-around!important}.align-items-md-start{align-items:flex-start!important}.align-items-md-end{align-items:flex-end!important}.align-items-md-center{align-items:center!important}.align-items-md-baseline{align-items:baseline!important}.align-items-md-stretch{align-items:stretch!important}.align-content-md-start{align-content:flex-start!important}.align-content-md-end{align-content:flex-end!important}.align-content-md-center{align-content:center!important}.align-content-md-between{align-content:space-between!important}.align-content-md-around{align-content:space-around!important}.align-content-md-stretch{align-content:stretch!important}.align-self-md-auto{align-self:auto!important}.align-self-md-start{align-self:flex-start!important}.align-self-md-end{align-self:flex-end!important}.align-self-md-center{align-self:center!important}.align-self-md-baseline{align-self:baseline!important}.align-self-md-stretch{align-self:stretch!important}}@media (min-width:992px){.flex-lg-row{flex-direction:row!important}.flex-lg-column{flex-direction:column!important}.flex-lg-row-reverse{flex-direction:row-reverse!important}.flex-lg-column-reverse{flex-direction:column-reverse!important}.flex-lg-wrap{flex-wrap:wrap!important}.flex-lg-nowrap{flex-wrap:nowrap!important}.flex-lg-wrap-reverse{flex-wrap:wrap-reverse!important}.flex-lg-fill{flex:1 1 auto!important}.flex-lg-grow-0{flex-grow:0!important}.flex-lg-grow-1{flex-grow:1!important}.flex-lg-shrink-0{flex-shrink:0!important}.flex-lg-shrink-1{flex-shrink:1!important}.justify-content-lg-start{justify-content:flex-start!important}.justify-content-lg-end{justify-content:flex-end!important}.justify-content-lg-center{justify-content:center!important}.justify-content-lg-between{justify-content:space-between!important}.justify-content-lg-around{justify-content:space-around!important}.align-items-lg-start{align-items:flex-start!important}.align-items-lg-end{align-items:flex-end!important}.align-items-lg-center{align-items:center!important}.align-items-lg-baseline{align-items:baseline!important}.align-items-lg-stretch{align-items:stretch!important}.align-content-lg-start{align-content:flex-start!important}.align-content-lg-end{align-content:flex-end!important}.align-content-lg-center{align-content:center!important}.align-content-lg-between{align-content:space-between!important}.align-content-lg-around{align-content:space-around!important}.align-content-lg-stretch{align-content:stretch!important}.align-self-lg-auto{align-self:auto!important}.align-self-lg-start{align-self:flex-start!important}.align-self-lg-end{align-self:flex-end!important}.align-self-lg-center{align-self:center!important}.align-self-lg-baseline{align-self:baseline!important}.align-self-lg-stretch{align-self:stretch!important}}@media (min-width:1200px){.flex-xl-row{flex-direction:row!important}.flex-xl-column{flex-direction:column!important}.flex-xl-row-reverse{flex-direction:row-reverse!important}.flex-xl-column-reverse{flex-direction:column-reverse!important}.flex-xl-wrap{flex-wrap:wrap!important}.flex-xl-nowrap{flex-wrap:nowrap!important}.flex-xl-wrap-reverse{flex-wrap:wrap-reverse!important}.flex-xl-fill{flex:1 1 auto!important}.flex-xl-grow-0{flex-grow:0!important}.flex-xl-grow-1{flex-grow:1!important}.flex-xl-shrink-0{flex-shrink:0!important}.flex-xl-shrink-1{flex-shrink:1!important}.justify-content-xl-start{justify-content:flex-start!important}.justify-content-xl-end{justify-content:flex-end!important}.justify-content-xl-center{justify-content:center!important}.justify-content-xl-between{justify-content:space-between!important}.justify-content-xl-around{justify-content:space-around!important}.align-items-xl-start{align-items:flex-start!important}.align-items-xl-end{align-items:flex-end!important}.align-items-xl-center{align-items:center!important}.align-items-xl-baseline{align-items:baseline!important}.align-items-xl-stretch{align-items:stretch!important}.align-content-xl-start{align-content:flex-start!important}.align-content-xl-end{align-content:flex-end!important}.align-content-xl-center{align-content:center!important}.align-content-xl-between{align-content:space-between!important}.align-content-xl-around{align-content:space-around!important}.align-content-xl-stretch{align-content:stretch!important}.align-self-xl-auto{align-self:auto!important}.align-self-xl-start{align-self:flex-start!important}.align-self-xl-end{align-self:flex-end!important}.align-self-xl-center{align-self:center!important}.align-self-xl-baseline{align-self:baseline!important}.align-self-xl-stretch{align-self:stretch!important}}.float-left{float:left!important}.float-right{float:right!important}.float-none{float:none!important}@media (min-width:576px){.float-sm-left{float:left!important}.float-sm-right{float:right!important}.float-sm-none{float:none!important}}@media (min-width:768px){.float-md-left{float:left!important}.float-md-right{float:right!important}.float-md-none{float:none!important}}@media (min-width:992px){.float-lg-left{float:left!important}.float-lg-right{float:right!important}.float-lg-none{float:none!important}}@media (min-width:1200px){.float-xl-left{float:left!important}.float-xl-right{float:right!important}.float-xl-none{float:none!important}}.position-static{position:static!important}.position-relative{position:relative!important}.position-absolute{position:absolute!important}.position-fixed{position:fixed!important}.position-sticky{position:-webkit-sticky!important;position:sticky!important}.fixed-top{top:0}.fixed-bottom,.fixed-top{position:fixed;right:0;left:0;z-index:1030}.fixed-bottom{bottom:0}@supports ((position:-webkit-sticky) or (position:sticky)){.sticky-top{position:-webkit-sticky;position:sticky;top:0;z-index:1020}}.sr-only{position:absolute;width:1px;height:1px;padding:0;overflow:hidden;clip:rect(0,0,0,0);white-space:nowrap;border:0}.sr-only-focusable:active,.sr-only-focusable:focus{position:static;width:auto;height:auto;overflow:visible;clip:auto;white-space:normal}.shadow-sm{box-shadow:0 .125rem .25rem rgba(0,0,0,.075)!important}.shadow{box-shadow:0 .5rem 1rem rgba(0,0,0,.15)!important}.shadow-lg{box-shadow:0 1rem 3rem rgba(0,0,0,.175)!important}.shadow-none{box-shadow:none!important}.w-25{width:25%!important}.w-50{width:50%!important}.w-75{width:75%!important}.w-100{width:100%!important}.w-auto{width:auto!important}.h-25{height:25%!important}.h-50{height:50%!important}.h-75{height:75%!important}.h-100{height:100%!important}.h-auto{height:auto!important}.mw-100{max-width:100%!important}.mh-100{max-height:100%!important}.m-0{margin:0!important}.mt-0,.my-0{margin-top:0!important}.mr-0,.mx-0{margin-right:0!important}.mb-0,.my-0{margin-bottom:0!important}.ml-0,.mx-0{margin-left:0!important}.m-1{margin:.25rem!important}.mt-1,.my-1{margin-top:.25rem!important}.mr-1,.mx-1{margin-right:.25rem!important}.mb-1,.my-1{margin-bottom:.25rem!important}.ml-1,.mx-1{margin-left:.25rem!important}.m-2{margin:.5rem!important}.mt-2,.my-2{margin-top:.5rem!important}.mr-2,.mx-2{margin-right:.5rem!important}.mb-2,.my-2{margin-bottom:.5rem!important}.ml-2,.mx-2{margin-left:.5rem!important}.m-3{margin:1rem!important}.mt-3,.my-3{margin-top:1rem!important}.mr-3,.mx-3{margin-right:1rem!important}.mb-3,.my-3{margin-bottom:1rem!important}.ml-3,.mx-3{margin-left:1rem!important}.m-4{margin:1.5rem!important}.mt-4,.my-4{margin-top:1.5rem!important}.mr-4,.mx-4{margin-right:1.5rem!important}.mb-4,.my-4{margin-bottom:1.5rem!important}.ml-4,.mx-4{margin-left:1.5rem!important}.m-5{margin:3rem!important}.mt-5,.my-5{margin-top:3rem!important}.mr-5,.mx-5{margin-right:3rem!important}.mb-5,.my-5{margin-bottom:3rem!important}.ml-5,.mx-5{margin-left:3rem!important}.p-0{padding:0!important}.pt-0,.py-0{padding-top:0!important}.pr-0,.px-0{padding-right:0!important}.pb-0,.py-0{padding-bottom:0!important}.pl-0,.px-0{padding-left:0!important}.p-1{padding:.25rem!important}.pt-1,.py-1{padding-top:.25rem!important}.pr-1,.px-1{padding-right:.25rem!important}.pb-1,.py-1{padding-bottom:.25rem!important}.pl-1,.px-1{padding-left:.25rem!important}.p-2{padding:.5rem!important}.pt-2,.py-2{padding-top:.5rem!important}.pr-2,.px-2{padding-right:.5rem!important}.pb-2,.py-2{padding-bottom:.5rem!important}.pl-2,.px-2{padding-left:.5rem!important}.p-3{padding:1rem!important}.pt-3,.py-3{padding-top:1rem!important}.pr-3,.px-3{padding-right:1rem!important}.pb-3,.py-3{padding-bottom:1rem!important}.pl-3,.px-3{padding-left:1rem!important}.p-4{padding:1.5rem!important}.pt-4,.py-4{padding-top:1.5rem!important}.pr-4,.px-4{padding-right:1.5rem!important}.pb-4,.py-4{padding-bottom:1.5rem!important}.pl-4,.px-4{padding-left:1.5rem!important}.p-5{padding:3rem!important}.pt-5,.py-5{padding-top:3rem!important}.pr-5,.px-5{padding-right:3rem!important}.pb-5,.py-5{padding-bottom:3rem!important}.pl-5,.px-5{padding-left:3rem!important}.m-auto{margin:auto!important}.mt-auto,.my-auto{margin-top:auto!important}.mr-auto,.mx-auto{margin-right:auto!important}.mb-auto,.my-auto{margin-bottom:auto!important}.ml-auto,.mx-auto{margin-left:auto!important}@media (min-width:576px){.m-sm-0{margin:0!important}.mt-sm-0,.my-sm-0{margin-top:0!important}.mr-sm-0,.mx-sm-0{margin-right:0!important}.mb-sm-0,.my-sm-0{margin-bottom:0!important}.ml-sm-0,.mx-sm-0{margin-left:0!important}.m-sm-1{margin:.25rem!important}.mt-sm-1,.my-sm-1{margin-top:.25rem!important}.mr-sm-1,.mx-sm-1{margin-right:.25rem!important}.mb-sm-1,.my-sm-1{margin-bottom:.25rem!important}.ml-sm-1,.mx-sm-1{margin-left:.25rem!important}.m-sm-2{margin:.5rem!important}.mt-sm-2,.my-sm-2{margin-top:.5rem!important}.mr-sm-2,.mx-sm-2{margin-right:.5rem!important}.mb-sm-2,.my-sm-2{margin-bottom:.5rem!important}.ml-sm-2,.mx-sm-2{margin-left:.5rem!important}.m-sm-3{margin:1rem!important}.mt-sm-3,.my-sm-3{margin-top:1rem!important}.mr-sm-3,.mx-sm-3{margin-right:1rem!important}.mb-sm-3,.my-sm-3{margin-bottom:1rem!important}.ml-sm-3,.mx-sm-3{margin-left:1rem!important}.m-sm-4{margin:1.5rem!important}.mt-sm-4,.my-sm-4{margin-top:1.5rem!important}.mr-sm-4,.mx-sm-4{margin-right:1.5rem!important}.mb-sm-4,.my-sm-4{margin-bottom:1.5rem!important}.ml-sm-4,.mx-sm-4{margin-left:1.5rem!important}.m-sm-5{margin:3rem!important}.mt-sm-5,.my-sm-5{margin-top:3rem!important}.mr-sm-5,.mx-sm-5{margin-right:3rem!important}.mb-sm-5,.my-sm-5{margin-bottom:3rem!important}.ml-sm-5,.mx-sm-5{margin-left:3rem!important}.p-sm-0{padding:0!important}.pt-sm-0,.py-sm-0{padding-top:0!important}.pr-sm-0,.px-sm-0{padding-right:0!important}.pb-sm-0,.py-sm-0{padding-bottom:0!important}.pl-sm-0,.px-sm-0{padding-left:0!important}.p-sm-1{padding:.25rem!important}.pt-sm-1,.py-sm-1{padding-top:.25rem!important}.pr-sm-1,.px-sm-1{padding-right:.25rem!important}.pb-sm-1,.py-sm-1{padding-bottom:.25rem!important}.pl-sm-1,.px-sm-1{padding-left:.25rem!important}.p-sm-2{padding:.5rem!important}.pt-sm-2,.py-sm-2{padding-top:.5rem!important}.pr-sm-2,.px-sm-2{padding-right:.5rem!important}.pb-sm-2,.py-sm-2{padding-bottom:.5rem!important}.pl-sm-2,.px-sm-2{padding-left:.5rem!important}.p-sm-3{padding:1rem!important}.pt-sm-3,.py-sm-3{padding-top:1rem!important}.pr-sm-3,.px-sm-3{padding-right:1rem!important}.pb-sm-3,.py-sm-3{padding-bottom:1rem!important}.pl-sm-3,.px-sm-3{padding-left:1rem!important}.p-sm-4{padding:1.5rem!important}.pt-sm-4,.py-sm-4{padding-top:1.5rem!important}.pr-sm-4,.px-sm-4{padding-right:1.5rem!important}.pb-sm-4,.py-sm-4{padding-bottom:1.5rem!important}.pl-sm-4,.px-sm-4{padding-left:1.5rem!important}.p-sm-5{padding:3rem!important}.pt-sm-5,.py-sm-5{padding-top:3rem!important}.pr-sm-5,.px-sm-5{padding-right:3rem!important}.pb-sm-5,.py-sm-5{padding-bottom:3rem!important}.pl-sm-5,.px-sm-5{padding-left:3rem!important}.m-sm-auto{margin:auto!important}.mt-sm-auto,.my-sm-auto{margin-top:auto!important}.mr-sm-auto,.mx-sm-auto{margin-right:auto!important}.mb-sm-auto,.my-sm-auto{margin-bottom:auto!important}.ml-sm-auto,.mx-sm-auto{margin-left:auto!important}}@media (min-width:768px){.m-md-0{margin:0!important}.mt-md-0,.my-md-0{margin-top:0!important}.mr-md-0,.mx-md-0{margin-right:0!important}.mb-md-0,.my-md-0{margin-bottom:0!important}.ml-md-0,.mx-md-0{margin-left:0!important}.m-md-1{margin:.25rem!important}.mt-md-1,.my-md-1{margin-top:.25rem!important}.mr-md-1,.mx-md-1{margin-right:.25rem!important}.mb-md-1,.my-md-1{margin-bottom:.25rem!important}.ml-md-1,.mx-md-1{margin-left:.25rem!important}.m-md-2{margin:.5rem!important}.mt-md-2,.my-md-2{margin-top:.5rem!important}.mr-md-2,.mx-md-2{margin-right:.5rem!important}.mb-md-2,.my-md-2{margin-bottom:.5rem!important}.ml-md-2,.mx-md-2{margin-left:.5rem!important}.m-md-3{margin:1rem!important}.mt-md-3,.my-md-3{margin-top:1rem!important}.mr-md-3,.mx-md-3{margin-right:1rem!important}.mb-md-3,.my-md-3{margin-bottom:1rem!important}.ml-md-3,.mx-md-3{margin-left:1rem!important}.m-md-4{margin:1.5rem!important}.mt-md-4,.my-md-4{margin-top:1.5rem!important}.mr-md-4,.mx-md-4{margin-right:1.5rem!important}.mb-md-4,.my-md-4{margin-bottom:1.5rem!important}.ml-md-4,.mx-md-4{margin-left:1.5rem!important}.m-md-5{margin:3rem!important}.mt-md-5,.my-md-5{margin-top:3rem!important}.mr-md-5,.mx-md-5{margin-right:3rem!important}.mb-md-5,.my-md-5{margin-bottom:3rem!important}.ml-md-5,.mx-md-5{margin-left:3rem!important}.p-md-0{padding:0!important}.pt-md-0,.py-md-0{padding-top:0!important}.pr-md-0,.px-md-0{padding-right:0!important}.pb-md-0,.py-md-0{padding-bottom:0!important}.pl-md-0,.px-md-0{padding-left:0!important}.p-md-1{padding:.25rem!important}.pt-md-1,.py-md-1{padding-top:.25rem!important}.pr-md-1,.px-md-1{padding-right:.25rem!important}.pb-md-1,.py-md-1{padding-bottom:.25rem!important}.pl-md-1,.px-md-1{padding-left:.25rem!important}.p-md-2{padding:.5rem!important}.pt-md-2,.py-md-2{padding-top:.5rem!important}.pr-md-2,.px-md-2{padding-right:.5rem!important}.pb-md-2,.py-md-2{padding-bottom:.5rem!important}.pl-md-2,.px-md-2{padding-left:.5rem!important}.p-md-3{padding:1rem!important}.pt-md-3,.py-md-3{padding-top:1rem!important}.pr-md-3,.px-md-3{padding-right:1rem!important}.pb-md-3,.py-md-3{padding-bottom:1rem!important}.pl-md-3,.px-md-3{padding-left:1rem!important}.p-md-4{padding:1.5rem!important}.pt-md-4,.py-md-4{padding-top:1.5rem!important}.pr-md-4,.px-md-4{padding-right:1.5rem!important}.pb-md-4,.py-md-4{padding-bottom:1.5rem!important}.pl-md-4,.px-md-4{padding-left:1.5rem!important}.p-md-5{padding:3rem!important}.pt-md-5,.py-md-5{padding-top:3rem!important}.pr-md-5,.px-md-5{padding-right:3rem!important}.pb-md-5,.py-md-5{padding-bottom:3rem!important}.pl-md-5,.px-md-5{padding-left:3rem!important}.m-md-auto{margin:auto!important}.mt-md-auto,.my-md-auto{margin-top:auto!important}.mr-md-auto,.mx-md-auto{margin-right:auto!important}.mb-md-auto,.my-md-auto{margin-bottom:auto!important}.ml-md-auto,.mx-md-auto{margin-left:auto!important}}@media (min-width:992px){.m-lg-0{margin:0!important}.mt-lg-0,.my-lg-0{margin-top:0!important}.mr-lg-0,.mx-lg-0{margin-right:0!important}.mb-lg-0,.my-lg-0{margin-bottom:0!important}.ml-lg-0,.mx-lg-0{margin-left:0!important}.m-lg-1{margin:.25rem!important}.mt-lg-1,.my-lg-1{margin-top:.25rem!important}.mr-lg-1,.mx-lg-1{margin-right:.25rem!important}.mb-lg-1,.my-lg-1{margin-bottom:.25rem!important}.ml-lg-1,.mx-lg-1{margin-left:.25rem!important}.m-lg-2{margin:.5rem!important}.mt-lg-2,.my-lg-2{margin-top:.5rem!important}.mr-lg-2,.mx-lg-2{margin-right:.5rem!important}.mb-lg-2,.my-lg-2{margin-bottom:.5rem!important}.ml-lg-2,.mx-lg-2{margin-left:.5rem!important}.m-lg-3{margin:1rem!important}.mt-lg-3,.my-lg-3{margin-top:1rem!important}.mr-lg-3,.mx-lg-3{margin-right:1rem!important}.mb-lg-3,.my-lg-3{margin-bottom:1rem!important}.ml-lg-3,.mx-lg-3{margin-left:1rem!important}.m-lg-4{margin:1.5rem!important}.mt-lg-4,.my-lg-4{margin-top:1.5rem!important}.mr-lg-4,.mx-lg-4{margin-right:1.5rem!important}.mb-lg-4,.my-lg-4{margin-bottom:1.5rem!important}.ml-lg-4,.mx-lg-4{margin-left:1.5rem!important}.m-lg-5{margin:3rem!important}.mt-lg-5,.my-lg-5{margin-top:3rem!important}.mr-lg-5,.mx-lg-5{margin-right:3rem!important}.mb-lg-5,.my-lg-5{margin-bottom:3rem!important}.ml-lg-5,.mx-lg-5{margin-left:3rem!important}.p-lg-0{padding:0!important}.pt-lg-0,.py-lg-0{padding-top:0!important}.pr-lg-0,.px-lg-0{padding-right:0!important}.pb-lg-0,.py-lg-0{padding-bottom:0!important}.pl-lg-0,.px-lg-0{padding-left:0!important}.p-lg-1{padding:.25rem!important}.pt-lg-1,.py-lg-1{padding-top:.25rem!important}.pr-lg-1,.px-lg-1{padding-right:.25rem!important}.pb-lg-1,.py-lg-1{padding-bottom:.25rem!important}.pl-lg-1,.px-lg-1{padding-left:.25rem!important}.p-lg-2{padding:.5rem!important}.pt-lg-2,.py-lg-2{padding-top:.5rem!important}.pr-lg-2,.px-lg-2{padding-right:.5rem!important}.pb-lg-2,.py-lg-2{padding-bottom:.5rem!important}.pl-lg-2,.px-lg-2{padding-left:.5rem!important}.p-lg-3{padding:1rem!important}.pt-lg-3,.py-lg-3{padding-top:1rem!important}.pr-lg-3,.px-lg-3{padding-right:1rem!important}.pb-lg-3,.py-lg-3{padding-bottom:1rem!important}.pl-lg-3,.px-lg-3{padding-left:1rem!important}.p-lg-4{padding:1.5rem!important}.pt-lg-4,.py-lg-4{padding-top:1.5rem!important}.pr-lg-4,.px-lg-4{padding-right:1.5rem!important}.pb-lg-4,.py-lg-4{padding-bottom:1.5rem!important}.pl-lg-4,.px-lg-4{padding-left:1.5rem!important}.p-lg-5{padding:3rem!important}.pt-lg-5,.py-lg-5{padding-top:3rem!important}.pr-lg-5,.px-lg-5{padding-right:3rem!important}.pb-lg-5,.py-lg-5{padding-bottom:3rem!important}.pl-lg-5,.px-lg-5{padding-left:3rem!important}.m-lg-auto{margin:auto!important}.mt-lg-auto,.my-lg-auto{margin-top:auto!important}.mr-lg-auto,.mx-lg-auto{margin-right:auto!important}.mb-lg-auto,.my-lg-auto{margin-bottom:auto!important}.ml-lg-auto,.mx-lg-auto{margin-left:auto!important}}@media (min-width:1200px){.m-xl-0{margin:0!important}.mt-xl-0,.my-xl-0{margin-top:0!important}.mr-xl-0,.mx-xl-0{margin-right:0!important}.mb-xl-0,.my-xl-0{margin-bottom:0!important}.ml-xl-0,.mx-xl-0{margin-left:0!important}.m-xl-1{margin:.25rem!important}.mt-xl-1,.my-xl-1{margin-top:.25rem!important}.mr-xl-1,.mx-xl-1{margin-right:.25rem!important}.mb-xl-1,.my-xl-1{margin-bottom:.25rem!important}.ml-xl-1,.mx-xl-1{margin-left:.25rem!important}.m-xl-2{margin:.5rem!important}.mt-xl-2,.my-xl-2{margin-top:.5rem!important}.mr-xl-2,.mx-xl-2{margin-right:.5rem!important}.mb-xl-2,.my-xl-2{margin-bottom:.5rem!important}.ml-xl-2,.mx-xl-2{margin-left:.5rem!important}.m-xl-3{margin:1rem!important}.mt-xl-3,.my-xl-3{margin-top:1rem!important}.mr-xl-3,.mx-xl-3{margin-right:1rem!important}.mb-xl-3,.my-xl-3{margin-bottom:1rem!important}.ml-xl-3,.mx-xl-3{margin-left:1rem!important}.m-xl-4{margin:1.5rem!important}.mt-xl-4,.my-xl-4{margin-top:1.5rem!important}.mr-xl-4,.mx-xl-4{margin-right:1.5rem!important}.mb-xl-4,.my-xl-4{margin-bottom:1.5rem!important}.ml-xl-4,.mx-xl-4{margin-left:1.5rem!important}.m-xl-5{margin:3rem!important}.mt-xl-5,.my-xl-5{margin-top:3rem!important}.mr-xl-5,.mx-xl-5{margin-right:3rem!important}.mb-xl-5,.my-xl-5{margin-bottom:3rem!important}.ml-xl-5,.mx-xl-5{margin-left:3rem!important}.p-xl-0{padding:0!important}.pt-xl-0,.py-xl-0{padding-top:0!important}.pr-xl-0,.px-xl-0{padding-right:0!important}.pb-xl-0,.py-xl-0{padding-bottom:0!important}.pl-xl-0,.px-xl-0{padding-left:0!important}.p-xl-1{padding:.25rem!important}.pt-xl-1,.py-xl-1{padding-top:.25rem!important}.pr-xl-1,.px-xl-1{padding-right:.25rem!important}.pb-xl-1,.py-xl-1{padding-bottom:.25rem!important}.pl-xl-1,.px-xl-1{padding-left:.25rem!important}.p-xl-2{padding:.5rem!important}.pt-xl-2,.py-xl-2{padding-top:.5rem!important}.pr-xl-2,.px-xl-2{padding-right:.5rem!important}.pb-xl-2,.py-xl-2{padding-bottom:.5rem!important}.pl-xl-2,.px-xl-2{padding-left:.5rem!important}.p-xl-3{padding:1rem!important}.pt-xl-3,.py-xl-3{padding-top:1rem!important}.pr-xl-3,.px-xl-3{padding-right:1rem!important}.pb-xl-3,.py-xl-3{padding-bottom:1rem!important}.pl-xl-3,.px-xl-3{padding-left:1rem!important}.p-xl-4{padding:1.5rem!important}.pt-xl-4,.py-xl-4{padding-top:1.5rem!important}.pr-xl-4,.px-xl-4{padding-right:1.5rem!important}.pb-xl-4,.py-xl-4{padding-bottom:1.5rem!important}.pl-xl-4,.px-xl-4{padding-left:1.5rem!important}.p-xl-5{padding:3rem!important}.pt-xl-5,.py-xl-5{padding-top:3rem!important}.pr-xl-5,.px-xl-5{padding-right:3rem!important}.pb-xl-5,.py-xl-5{padding-bottom:3rem!important}.pl-xl-5,.px-xl-5{padding-left:3rem!important}.m-xl-auto{margin:auto!important}.mt-xl-auto,.my-xl-auto{margin-top:auto!important}.mr-xl-auto,.mx-xl-auto{margin-right:auto!important}.mb-xl-auto,.my-xl-auto{margin-bottom:auto!important}.ml-xl-auto,.mx-xl-auto{margin-left:auto!important}}.text-monospace{font-family:SFMono-Regular,Menlo,Monaco,Consolas,Liberation Mono,Courier New,monospace}.text-justify{text-align:justify!important}.text-nowrap{white-space:nowrap!important}.text-truncate{overflow:hidden;text-overflow:ellipsis;white-space:nowrap}.text-left{text-align:left!important}.text-right{text-align:right!important}.text-center{text-align:center!important}@media (min-width:576px){.text-sm-left{text-align:left!important}.text-sm-right{text-align:right!important}.text-sm-center{text-align:center!important}}@media (min-width:768px){.text-md-left{text-align:left!important}.text-md-right{text-align:right!important}.text-md-center{text-align:center!important}}@media (min-width:992px){.text-lg-left{text-align:left!important}.text-lg-right{text-align:right!important}.text-lg-center{text-align:center!important}}@media (min-width:1200px){.text-xl-left{text-align:left!important}.text-xl-right{text-align:right!important}.text-xl-center{text-align:center!important}}.text-lowercase{text-transform:lowercase!important}.text-uppercase{text-transform:uppercase!important}.text-capitalize{text-transform:capitalize!important}.font-weight-light{font-weight:300!important}.font-weight-normal{font-weight:400!important}.font-weight-bold{font-weight:700!important}.font-italic{font-style:italic!important}.text-white{color:#fff!important}.text-primary{color:#3490dc!important}a.text-primary:focus,a.text-primary:hover{color:#2176bd!important}.text-secondary{color:#6c757d!important}a.text-secondary:focus,a.text-secondary:hover{color:#545b62!important}.text-success{color:#38c172!important}a.text-success:focus,a.text-success:hover{color:#2d995b!important}.text-info{color:#6cb2eb!important}a.text-info:focus,a.text-info:hover{color:#3f9ae5!important}.text-warning{color:#ffed4a!important}a.text-warning:focus,a.text-warning:hover{color:#ffe817!important}.text-danger{color:#e3342f!important}a.text-danger:focus,a.text-danger:hover{color:#c51f1a!important}.text-light{color:#f8f9fa!important}a.text-light:focus,a.text-light:hover{color:#dae0e5!important}.text-dark{color:#343a40!important}a.text-dark:focus,a.text-dark:hover{color:#1d2124!important}.text-body{color:#212529!important}.text-muted{color:#6c757d!important}.text-black-50{color:rgba(0,0,0,.5)!important}.text-white-50{color:hsla(0,0%,100%,.5)!important}.text-hide{font:0/0 a;color:transparent;text-shadow:none;background-color:transparent;border:0}.visible{visibility:visible!important}.invisible{visibility:hidden!important}@media print{*,:after,:before{text-shadow:none!important;box-shadow:none!important}a:not(.btn){text-decoration:underline}abbr[title]:after{content:" (" attr(title) ")"}pre{white-space:pre-wrap!important}blockquote,pre{border:1px solid #adb5bd;page-break-inside:avoid}thead{display:table-header-group}img,tr{page-break-inside:avoid}h2,h3,p{orphans:3;widows:3}h2,h3{page-break-after:avoid}@page{size:a3}.container,body{min-width:992px!important}.navbar{display:none}.badge{border:1px solid #000}.table{border-collapse:collapse!important}.table td,.table th{background-color:#fff!important}.table-bordered td,.table-bordered th{border:1px solid #dee2e6!important}.table-dark{color:inherit}.table-dark tbody+tbody,.table-dark td,.table-dark th,.table-dark thead th{border-color:#dee2e6}.table .thead-dark th{color:inherit;border-color:#dee2e6}}.navbar-laravel{background-color:#fff;box-shadow:0 2px 4px rgba(0,0,0,.04)}[m
\ No newline at end of file[m
[1mdiff --git a/public/favicon.ico b/public/favicon.ico[m
[1mnew file mode 100755[m
[1mindex 0000000..e69de29[m
[1mdiff --git a/public/index.php b/public/index.php[m
[1mnew file mode 100755[m
[1mindex 0000000..4584cbc[m
[1m--- /dev/null[m
[1m+++ b/public/index.php[m
[36m@@ -0,0 +1,60 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32m/**[m
[32m+[m[32m * Laravel - A PHP Framework For Web Artisans[m
[32m+[m[32m *[m
[32m+[m[32m * @package  Laravel[m
[32m+[m[32m * @author   Taylor Otwell <taylor@laravel.com>[m
[32m+[m[32m */[m
[32m+[m
[32m+[m[32mdefine('LARAVEL_START', microtime(true));[m
[32m+[m
[32m+[m[32m/*[m
[32m+[m[32m|--------------------------------------------------------------------------[m
[32m+[m[32m| Register The Auto Loader[m
[32m+[m[32m|--------------------------------------------------------------------------[m
[32m+[m[32m|[m
[32m+[m[32m| Composer provides a convenient, automatically generated class loader for[m
[32m+[m[32m| our application. We just need to utilize it! We'll simply require it[m
[32m+[m[32m| into the script here so that we don't have to worry about manual[m
[32m+[m[32m| loading any of our classes later on. It feels great to relax.[m
[32m+[m[32m|[m
[32m+[m[32m*/[m
[32m+[m
[32m+[m[32mrequire __DIR__.'/../vendor/autoload.php';[m
[32m+[m
[32m+[m[32m/*[m
[32m+[m[32m|--------------------------------------------------------------------------[m
[32m+[m[32m| Turn On The Lights[m
[32m+[m[32m|--------------------------------------------------------------------------[m
[32m+[m[32m|[m
[32m+[m[32m| We need to illuminate PHP development, so let us turn on the lights.[m
[32m+[m[32m| This bootstraps the framework and gets it ready for use, then it[m
[32m+[m[32m| will load up this application so that we can run it and send[m
[32m+[m[32m| the responses back to the browser and delight our users.[m
[32m+[m[32m|[m
[32m+[m[32m*/[m
[32m+[m
[32m+[m[32m$app = require_once __DIR__.'/../bootstrap/app.php';[m
[32m+[m
[32m+[m[32m/*[m
[32m+[m[32m|--------------------------------------------------------------------------[m
[32m+[m[32m| Run The Application[m
[32m+[m[32m|--------------------------------------------------------------------------[m
[32m+[m[32m|[m
[32m+[m[32m| Once we have the application, we can handle the incoming request[m
[32m+[m[32m| through the kernel, and send the associated response back to[m
[32m+[m[32m| the client's browser allowing them to enjoy the creative[m
[32m+[m[32m| and wonderful application we have prepared for them.[m
[32m+[m[32m|[m
[32m+[m[32m*/[m
[32m+[m
[32m+[m[32m$kernel = $app->make(Illuminate\Contracts\Http\Kernel::class);[m
[32m+[m
[32m+[m[32m$response = $kernel->handle([m
[32m+[m[32m    $request = Illuminate\Http\Request::capture()[m
[32m+[m[32m);[m
[32m+[m
[32m+[m[32m$response->send();[m
[32m+[m
[32m+[m[32m$kernel->terminate($request, $response);[m
[1mdiff --git a/public/js/app.js b/public/js/app.js[m
[1mnew file mode 100755[m
[1mindex 0000000..736d3c7[m
[1m--- /dev/null[m
[1m+++ b/public/js/app.js[m
[36m@@ -0,0 +1 @@[m
[1mdiff --git a/public/media/avatar/16045654586400/thumbs/1604565866.jpg b/public/media/avatar/16045654586400/thumbs/1604565866.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..fb617c6[m
Binary files /dev/null and b/public/media/avatar/16045654586400/thumbs/1604565866.jpg differ
[1mdiff --git a/public/media/avatar/16045654586400/thumbs/1604566101.jpg b/public/media/avatar/16045654586400/thumbs/1604566101.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..fb617c6[m
Binary files /dev/null and b/public/media/avatar/16045654586400/thumbs/1604566101.jpg differ
[1mdiff --git a/public/media/avatar/16045654586400/thumbs/1604566103.jpg b/public/media/avatar/16045654586400/thumbs/1604566103.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..fb617c6[m
Binary files /dev/null and b/public/media/avatar/16045654586400/thumbs/1604566103.jpg differ
[1mdiff --git a/public/media/avatar/16045654586400/thumbs/1604566104.jpg b/public/media/avatar/16045654586400/thumbs/1604566104.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..fb617c6[m
Binary files /dev/null and b/public/media/avatar/16045654586400/thumbs/1604566104.jpg differ
[1mdiff --git a/public/media/avatar/16045654586400/thumbs/1604566105.jpg b/public/media/avatar/16045654586400/thumbs/1604566105.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..fb617c6[m
Binary files /dev/null and b/public/media/avatar/16045654586400/thumbs/1604566105.jpg differ
[1mdiff --git a/public/robots.txt b/public/robots.txt[m
[1mnew file mode 100755[m
[1mindex 0000000..eb05362[m
[1m--- /dev/null[m
[1m+++ b/public/robots.txt[m
[36m@@ -0,0 +1,2 @@[m
[32m+[m[32mUser-agent: *[m
[32m+[m[32mDisallow:[m
[1mdiff --git a/public/web.config b/public/web.config[m
[1mnew file mode 100755[m
[1mindex 0000000..d3711d7[m
[1m--- /dev/null[m
[1m+++ b/public/web.config[m
[36m@@ -0,0 +1,28 @@[m
[32m+[m[32m<!--[m
[32m+[m[32m    Rewrites requires Microsoft URL Rewrite Module for IIS[m
[32m+[m[32m    Download: https://www.microsoft.com/en-us/download/details.aspx?id=47337[m
[32m+[m[32m    Debug Help: https://docs.microsoft.com/en-us/iis/extensions/url-rewrite-module/using-failed-request-tracing-to-trace-rewrite-rules[m
[32m+[m[32m-->[m
[32m+[m[32m<configuration>[m
[32m+[m[32m  <system.webServer>[m
[32m+[m[32m    <rewrite>[m
[32m+[m[32m      <rules>[m
[32m+[m[32m        <rule name="Imported Rule 1" stopProcessing="true">[m
[32m+[m[32m          <match url="^(.*)/$" ignoreCase="false" />[m
[32m+[m[32m          <conditions>[m
[32m+[m[32m            <add input="{REQUEST_FILENAME}" matchType="IsDirectory" ignoreCase="false" negate="true" />[m
[32m+[m[32m          </conditions>[m
[32m+[m[32m          <action type="Redirect" redirectType="Permanent" url="/{R:1}" />[m
[32m+[m[32m        </rule>[m
[32m+[m[32m        <rule name="Imported Rule 2" stopProcessing="true">[m
[32m+[m[32m          <match url="^" ignoreCase="false" />[m
[32m+[m[32m          <conditions>[m
[32m+[m[32m            <add input="{REQUEST_FILENAME}" matchType="IsDirectory" ignoreCase="false" negate="true" />[m
[32m+[m[32m            <add input="{REQUEST_FILENAME}" matchType="IsFile" ignoreCase="false" negate="true" />[m
[32m+[m[32m          </conditions>[m
[32m+[m[32m          <action type="Rewrite" url="index.php" />[m
[32m+[m[32m        </rule>[m
[32m+[m[32m      </rules>[m
[32m+[m[32m    </rewrite>[m
[32m+[m[32m  </system.webServer>[m
[32m+[m[32m</configuration>[m
[1mdiff --git a/readme.md b/readme.md[m
[1mnew file mode 100755[m
[1mindex 0000000..f769ac4[m
[1m--- /dev/null[m
[1m+++ b/readme.md[m
[36m@@ -0,0 +1,68 @@[m
[32m+[m[32m## Project Setup:[m
[32m+[m
[32m+[m[32m### 1. Clone the repo to htdocs or www folder[m
[32m+[m
[32m+[m[32m```[m
[32m+[m[32mgit clone ....[m
[32m+[m[32m```[m
[32m+[m
[32m+[m[32m### 2. go to the directory[m[41m [m
[32m+[m
[32m+[m[32m```[m
[32m+[m[32mcd ccKnowledgeBase[m
[32m+[m[32m```[m
[32m+[m
[32m+[m[32m### 3. Install Composer[m
[32m+[m[32m```[m
[32m+[m[32mcomposer install[m
[32m+[m[32m```[m
[32m+[m
[32m+[m[32m### 4. Enable Permission (for Linux User)[m
[32m+[m
[32m+[m[32m```[m
[32m+[m[32msudo chmod -R 777 storage[m
[32m+[m
[32m+[m[32m```[m
[32m+[m
[32m+[m[32m## 5. Database Section[m
[32m+[m
[32m+[m[32m```[m
[32m+[m[32mCreate db kbs[m
[32m+[m[32m```[m
[32m+[m[32m```[m
[32m+[m[32mphp artisan migrate[m
[32m+[m[32m```[m
[32m+[m[32m```[m
[32m+[m[32m php artisan db:seed --class=PermissionTableSeeder[m
[32m+[m[32m```[m
[32m+[m[32m```[m
[32m+[m[32m php artisan db:seed --class=RoleTableSeeder[m
[32m+[m[32m```[m
[32m+[m[32m```[m
[32m+[m[32m php artisan db:seed --class=UserTableSeeder[m
[32m+[m[32m```[m
[32m+[m
[32m+[m[32m## 6. Authentication[m
[32m+[m
[32m+[m[32m```[m
[32m+[m[32mphp artisan passport:install[m
[32m+[m[32m```[m
[32m+[m
[32m+[m[32m# Great ! Done![m[41m [m
[32m+[m
[32m+[m[32m## 7. From Browser[m
[32m+[m[32m```html[m
[32m+[m[32mhttp://localhost/ccKnowledgeBase/public[m
[32m+[m[32m```[m
[32m+[m
[32m+[m[32m### 8. From Postman ### post request[m
[32m+[m[32m```html[m
[32m+[m[32mhttp://localhost/ccKnowledgeBase/public/api/login[m
[32m+[m
[32m+[m[32mbody:[m[41m [m
[32m+[m[32m    username: admin[m
[32m+[m[32m    password: 123456[m
[32m+[m
[32m+[m[32m```[m
[32m+[m
[32m+[m
[1mdiff --git a/resources/js/app.js b/resources/js/app.js[m
[1mnew file mode 100755[m
[1mindex 0000000..a1efb5c[m
[1m--- /dev/null[m
[1m+++ b/resources/js/app.js[m
[36m@@ -0,0 +1,32 @@[m
[32m+[m[32m/**[m
[32m+[m[32m * First we will load all of this project's JavaScript dependencies which[m
[32m+[m[32m * includes Vue and other libraries. It is a great starting point when[m
[32m+[m[32m * building robust, powerful web applications using Vue and Laravel.[m
[32m+[m[32m */[m
[32m+[m
[32m+[m[32mrequire('./bootstrap');[m
[32m+[m
[32m+[m[32mwindow.Vue = require('vue');[m
[32m+[m
[32m+[m[32m/**[m
[32m+[m[32m * The following block of code may be used to automatically register your[m
[32m+[m[32m * Vue components. It will recursively scan this directory for the Vue[m
[32m+[m[32m * components and automatically register them with their "basename".[m
[32m+[m[32m *[m
[32m+[m[32m * Eg. ./components/ExampleComponent.vue -> <example-component></example-component>[m
[32m+[m[32m */[m
[32m+[m
[32m+[m[32m// const files = require.context('./', true, /\.vue$/i);[m
[32m+[m[32m// files.keys().map(key => Vue.component(key.split('/').pop().split('.')[0], files(key).default));[m
[32m+[m
[32m+[m[32mVue.component('example-component', require('./components/ExampleComponent.vue').default);[m
[32m+[m
[32m+[m[32m/**[m
[32m+[m[32m * Next, we will create a fresh Vue application instance and attach it to[m
[32m+[m[32m * the page. Then, you may begin adding components to this application[m
[32m+[m[32m * or customize the JavaScript scaffolding to fit your unique needs.[m
[32m+[m[32m */[m
[32m+[m
[32m+[m[32mconst app = new Vue({[m
[32m+[m[32m    el: '#app',[m
[32m+[m[32m});[m
[1mdiff --git a/resources/js/bootstrap.js b/resources/js/bootstrap.js[m
[1mnew file mode 100755[m
[1mindex 0000000..8eaba1b[m
[1m--- /dev/null[m
[1m+++ b/resources/js/bootstrap.js[m
[36m@@ -0,0 +1,41 @@[m
[32m+[m[32mwindow._ = require('lodash');[m
[32m+[m
[32m+[m[32m/**[m
[32m+[m[32m * We'll load jQuery and the Bootstrap jQuery plugin which provides support[m
[32m+[m[32m * for JavaScript based Bootstrap features such as modals and tabs. This[m
[32m+[m[32m * code may be modified to fit the specific needs of your application.[m
[32m+[m[32m */[m
[32m+[m
[32m+[m[32mtry {[m
[32m+[m[32m    window.Popper = require('popper.js').default;[m
[32m+[m[32m    window.$ = window.jQuery = require('jquery');[m
[32m+[m
[32m+[m[32m    require('bootstrap');[m
[32m+[m[32m} catch (e) {}[m
[32m+[m
[32m+[m[32m/**[m
[32m+[m[32m * We'll load the axios HTTP library which allows us to easily issue requests[m
[32m+[m[32m * to our Laravel back-end. This library automatically handles sending the[m
[32m+[m[32m * CSRF token as a header based on the value of the "XSRF" token cookie.[m
[32m+[m[32m */[m
[32m+[m
[32m+[m[32mwindow.axios = require('axios');[m
[32m+[m
[32m+[m[32mwindow.axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';[m
[32m+[m
[32m+[m[32m/**[m
[32m+[m[32m * Echo exposes an expressive API for subscribing to channels and listening[m
[32m+[m[32m * for events that are broadcast by Laravel. Echo and event broadcasting[m
[32m+[m[32m * allows your team to easily build robust real-time web applications.[m
[32m+[m[32m */[m
[32m+[m
[32m+[m[32m// import Echo from 'laravel-echo';[m
[32m+[m
[32m+[m[32m// window.Pusher = require('pusher-js');[m
[32m+[m
[32m+[m[32m// window.Echo = new Echo({[m
[32m+[m[32m//     broadcaster: 'pusher',[m
[32m+[m[32m//     key: process.env.MIX_PUSHER_APP_KEY,[m
[32m+[m[32m//     cluster: process.env.MIX_PUSHER_APP_CLUSTER,[m
[32m+[m[32m//     encrypted: true[m
[32m+[m[32m// });[m
[1mdiff --git a/resources/js/components/ExampleComponent.vue b/resources/js/components/ExampleComponent.vue[m
[1mnew file mode 100755[m
[1mindex 0000000..3fb9f9a[m
[1m--- /dev/null[m
[1m+++ b/resources/js/components/ExampleComponent.vue[m
[36m@@ -0,0 +1,23 @@[m
[32m+[m[32m<template>[m
[32m+[m[32m    <div class="container">[m
[32m+[m[32m        <div class="row justify-content-center">[m
[32m+[m[32m            <div class="col-md-8">[m
[32m+[m[32m                <div class="card">[m
[32m+[m[32m                    <div class="card-header">Example Component</div>[m
[32m+[m
[32m+[m[32m                    <div class="card-body">[m
[32m+[m[32m                        I'm an example component.[m
[32m+[m[32m                    </div>[m
[32m+[m[32m                </div>[m
[32m+[m[32m            </div>[m
[32m+[m[32m        </div>[m
[32m+[m[32m    </div>[m
[32m+[m[32m</template>[m
[32m+[m
[32m+[m[32m<script>[m
[32m+[m[32m    export default {[m
[32m+[m[32m        mounted() {[m
[32m+[m[32m            console.log('Component mounted.')[m
[32m+[m[32m        }[m
[32m+[m[32m    }[m
[32m+[m[32m</script>[m
[1mdiff --git a/resources/lang/en/auth.php b/resources/lang/en/auth.php[m
[1mnew file mode 100755[m
[1mindex 0000000..e5506df[m
[1m--- /dev/null[m
[1m+++ b/resources/lang/en/auth.php[m
[36m@@ -0,0 +1,19 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mreturn [[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Authentication Language Lines[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | The following language lines are used during authentication for various[m
[32m+[m[32m    | messages that we need to display to the user. You are free to modify[m
[32m+[m[32m    | these language lines according to your application's requirements.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'failed' => 'These credentials do not match our records.',[m
[32m+[m[32m    'throttle' => 'Too many login attempts. Please try again in :seconds seconds.',[m
[32m+[m
[32m+[m[32m];[m
[1mdiff --git a/resources/lang/en/pagination.php b/resources/lang/en/pagination.php[m
[1mnew file mode 100755[m
[1mindex 0000000..d481411[m
[1m--- /dev/null[m
[1m+++ b/resources/lang/en/pagination.php[m
[36m@@ -0,0 +1,19 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mreturn [[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Pagination Language Lines[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | The following language lines are used by the paginator library to build[m
[32m+[m[32m    | the simple pagination links. You are free to change them to anything[m
[32m+[m[32m    | you want to customize your views to better match your application.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'previous' => '&laquo; Previous',[m
[32m+[m[32m    'next' => 'Next &raquo;',[m
[32m+[m
[32m+[m[32m];[m
[1mdiff --git a/resources/lang/en/passwords.php b/resources/lang/en/passwords.php[m
[1mnew file mode 100755[m
[1mindex 0000000..bf6caf6[m
[1m--- /dev/null[m
[1m+++ b/resources/lang/en/passwords.php[m
[36m@@ -0,0 +1,22 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mreturn [[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Password Reset Language Lines[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | The following language lines are the default lines which match reasons[m
[32m+[m[32m    | that are given by the password broker for a password update attempt[m
[32m+[m[32m    | has failed, such as for an invalid token or invalid new password.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'password' => 'Passwords must be at least eight characters and match the confirmation.',[m
[32m+[m[32m    'reset' => 'Your password has been reset!',[m
[32m+[m[32m    'sent' => 'We have e-mailed your password reset link!',[m
[32m+[m[32m    'token' => 'This password reset token is invalid.',[m
[32m+[m[32m    'user' => "We can't find a user with that e-mail address.",[m
[32m+[m
[32m+[m[32m];[m
[1mdiff --git a/resources/lang/en/validation.php b/resources/lang/en/validation.php[m
[1mnew file mode 100755[m
[1mindex 0000000..e1d879f[m
[1m--- /dev/null[m
[1m+++ b/resources/lang/en/validation.php[m
[36m@@ -0,0 +1,150 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mreturn [[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Validation Language Lines[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | The following language lines contain the default error messages used by[m
[32m+[m[32m    | the validator class. Some of these rules have multiple versions such[m
[32m+[m[32m    | as the size rules. Feel free to tweak each of these messages here.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'accepted' => 'The :attribute must be accepted.',[m
[32m+[m[32m    'active_url' => 'The :attribute is not a valid URL.',[m
[32m+[m[32m    'after' => 'The :attribute must be a date after :date.',[m
[32m+[m[32m    'after_or_equal' => 'The :attribute must be a date after or equal to :date.',[m
[32m+[m[32m    'alpha' => 'The :attribute may only contain letters.',[m
[32m+[m[32m    'alpha_dash' => 'The :attribute may only contain letters, numbers, dashes and underscores.',[m
[32m+[m[32m    'alpha_num' => 'The :attribute may only contain letters and numbers.',[m
[32m+[m[32m    'array' => 'The :attribute must be an array.',[m
[32m+[m[32m    'before' => 'The :attribute must be a date before :date.',[m
[32m+[m[32m    'before_or_equal' => 'The :attribute must be a date before or equal to :date.',[m
[32m+[m[32m    'between' => [[m
[32m+[m[32m        'numeric' => 'The :attribute must be between :min and :max.',[m
[32m+[m[32m        'file' => 'The :attribute must be between :min and :max kilobytes.',[m
[32m+[m[32m        'string' => 'The :attribute must be between :min and :max characters.',[m
[32m+[m[32m        'array' => 'The :attribute must have between :min and :max items.',[m
[32m+[m[32m    ],[m
[32m+[m[32m    'boolean' => 'The :attribute field must be true or false.',[m
[32m+[m[32m    'confirmed' => 'The :attribute confirmation does not match.',[m
[32m+[m[32m    'date' => 'The :attribute is not a valid date.',[m
[32m+[m[32m    'date_equals' => 'The :attribute must be a date equal to :date.',[m
[32m+[m[32m    'date_format' => 'The :attribute does not match the format :format.',[m
[32m+[m[32m    'different' => 'The :attribute and :other must be different.',[m
[32m+[m[32m    'digits' => 'The :attribute must be :digits digits.',[m
[32m+[m[32m    'digits_between' => 'The :attribute must be between :min and :max digits.',[m
[32m+[m[32m    'dimensions' => 'The :attribute has invalid image dimensions.',[m
[32m+[m[32m    'distinct' => 'The :attribute field has a duplicate value.',[m
[32m+[m[32m    'email' => 'The :attribute must be a valid email address.',[m
[32m+[m[32m    'ends_with' => 'The :attribute must end with one of the following: :values',[m
[32m+[m[32m    'exists' => 'The selected :attribute is invalid.',[m
[32m+[m[32m    'file' => 'The :attribute must be a file.',[m
[32m+[m[32m    'filled' => 'The :attribute field must have a value.',[m
[32m+[m[32m    'gt' => [[m
[32m+[m[32m        'numeric' => 'The :attribute must be greater than :value.',[m
[32m+[m[32m        'file' => 'The :attribute must be greater than :value kilobytes.',[m
[32m+[m[32m        'string' => 'The :attribute must be greater than :value characters.',[m
[32m+[m[32m        'array' => 'The :attribute must have more than :value items.',[m
[32m+[m[32m    ],[m
[32m+[m[32m    'gte' => [[m
[32m+[m[32m        'numeric' => 'The :attribute must be greater than or equal :value.',[m
[32m+[m[32m        'file' => 'The :attribute must be greater than or equal :value kilobytes.',[m
[32m+[m[32m        'string' => 'The :attribute must be greater than or equal :value characters.',[m
[32m+[m[32m        'array' => 'The :attribute must have :value items or more.',[m
[32m+[m[32m    ],[m
[32m+[m[32m    'image' => 'The :attribute must be an image.',[m
[32m+[m[32m    'in' => 'The selected :attribute is invalid.',[m
[32m+[m[32m    'in_array' => 'The :attribute field does not exist in :other.',[m
[32m+[m[32m    'integer' => 'The :attribute must be an integer.',[m
[32m+[m[32m    'ip' => 'The :attribute must be a valid IP address.',[m
[32m+[m[32m    'ipv4' => 'The :attribute must be a valid IPv4 address.',[m
[32m+[m[32m    'ipv6' => 'The :attribute must be a valid IPv6 address.',[m
[32m+[m[32m    'json' => 'The :attribute must be a valid JSON string.',[m
[32m+[m[32m    'lt' => [[m
[32m+[m[32m        'numeric' => 'The :attribute must be less than :value.',[m
[32m+[m[32m        'file' => 'The :attribute must be less than :value kilobytes.',[m
[32m+[m[32m        'string' => 'The :attribute must be less than :value characters.',[m
[32m+[m[32m        'array' => 'The :attribute must have less than :value items.',[m
[32m+[m[32m    ],[m
[32m+[m[32m    'lte' => [[m
[32m+[m[32m        'numeric' => 'The :attribute must be less than or equal :value.',[m
[32m+[m[32m        'file' => 'The :attribute must be less than or equal :value kilobytes.',[m
[32m+[m[32m        'string' => 'The :attribute must be less than or equal :value characters.',[m
[32m+[m[32m        'array' => 'The :attribute must not have more than :value items.',[m
[32m+[m[32m    ],[m
[32m+[m[32m    'max' => [[m
[32m+[m[32m        'numeric' => 'The :attribute may not be greater than :max.',[m
[32m+[m[32m        'file' => 'The :attribute may not be greater than :max kilobytes.',[m
[32m+[m[32m        'string' => 'The :attribute may not be greater than :max characters.',[m
[32m+[m[32m        'array' => 'The :attribute may not have more than :max items.',[m
[32m+[m[32m    ],[m
[32m+[m[32m    'mimes' => 'The :attribute must be a file of type: :values.',[m
[32m+[m[32m    'mimetypes' => 'The :attribute must be a file of type: :values.',[m
[32m+[m[32m    'min' => [[m
[32m+[m[32m        'numeric' => 'The :attribute must be at least :min.',[m
[32m+[m[32m        'file' => 'The :attribute must be at least :min kilobytes.',[m
[32m+[m[32m        'string' => 'The :attribute must be at least :min characters.',[m
[32m+[m[32m        'array' => 'The :attribute must have at least :min items.',[m
[32m+[m[32m    ],[m
[32m+[m[32m    'not_in' => 'The selected :attribute is invalid.',[m
[32m+[m[32m    'not_regex' => 'The :attribute format is invalid.',[m
[32m+[m[32m    'numeric' => 'The :attribute must be a number.',[m
[32m+[m[32m    'present' => 'The :attribute field must be present.',[m
[32m+[m[32m    'regex' => 'The :attribute format is invalid.',[m
[32m+[m[32m    'required' => 'The :attribute field is required.',[m
[32m+[m[32m    'required_if' => 'The :attribute field is required when :other is :value.',[m
[32m+[m[32m    'required_unless' => 'The :attribute field is required unless :other is in :values.',[m
[32m+[m[32m    'required_with' => 'The :attribute field is required when :values is present.',[m
[32m+[m[32m    'required_with_all' => 'The :attribute field is required when :values are present.',[m
[32m+[m[32m    'required_without' => 'The :attribute field is required when :values is not present.',[m
[32m+[m[32m    'required_without_all' => 'The :attribute field is required when none of :values are present.',[m
[32m+[m[32m    'same' => 'The :attribute and :other must match.',[m
[32m+[m[32m    'size' => [[m
[32m+[m[32m        'numeric' => 'The :attribute must be :size.',[m
[32m+[m[32m        'file' => 'The :attribute must be :size kilobytes.',[m
[32m+[m[32m        'string' => 'The :attribute must be :size characters.',[m
[32m+[m[32m        'array' => 'The :attribute must contain :size items.',[m
[32m+[m[32m    ],[m
[32m+[m[32m    'starts_with' => 'The :attribute must start with one of the following: :values',[m
[32m+[m[32m    'string' => 'The :attribute must be a string.',[m
[32m+[m[32m    'timezone' => 'The :attribute must be a valid zone.',[m
[32m+[m[32m    'unique' => 'The :attribute has already been taken.',[m
[32m+[m[32m    'uploaded' => 'The :attribute failed to upload.',[m
[32m+[m[32m    'url' => 'The :attribute format is invalid.',[m
[32m+[m[32m    'uuid' => 'The :attribute must be a valid UUID.',[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Custom Validation Language Lines[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | Here you may specify custom validation messages for attributes using the[m
[32m+[m[32m    | convention "attribute.rule" to name the lines. This makes it quick to[m
[32m+[m[32m    | specify a specific custom language line for a given attribute rule.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'custom' => [[m
[32m+[m[32m        'attribute-name' => [[m
[32m+[m[32m            'rule-name' => 'custom-message',[m
[32m+[m[32m        ],[m
[32m+[m[32m    ],[m
[32m+[m
[32m+[m[32m    /*[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    | Custom Validation Attributes[m
[32m+[m[32m    |--------------------------------------------------------------------------[m
[32m+[m[32m    |[m
[32m+[m[32m    | The following language lines are used to swap our attribute placeholder[m
[32m+[m[32m    | with something more reader friendly such as "E-Mail Address" instead[m
[32m+[m[32m    | of "email". This simply helps us make our message more expressive.[m
[32m+[m[32m    |[m
[32m+[m[32m    */[m
[32m+[m
[32m+[m[32m    'attributes' => [],[m
[32m+[m
[32m+[m[32m];[m
[1mdiff --git a/resources/sass/_variables.scss b/resources/sass/_variables.scss[m
[1mnew file mode 100755[m
[1mindex 0000000..0407ab5[m
[1m--- /dev/null[m
[1m+++ b/resources/sass/_variables.scss[m
[36m@@ -0,0 +1,19 @@[m
[32m+[m[32m// Body[m
[32m+[m[32m$body-bg: #f8fafc;[m
[32m+[m
[32m+[m[32m// Typography[m
[32m+[m[32m$font-family-sans-serif: 'Nunito', sans-serif;[m
[32m+[m[32m$font-size-base: 0.9rem;[m
[32m+[m[32m$line-height-base: 1.6;[m
[32m+[m
[32m+[m[32m// Colors[m
[32m+[m[32m$blue: #3490dc;[m
[32m+[m[32m$indigo: #6574cd;[m
[32m+[m[32m$purple: #9561e2;[m
[32m+[m[32m$pink: #f66d9b;[m
[32m+[m[32m$red: #e3342f;[m
[32m+[m[32m$orange: #f6993f;[m
[32m+[m[32m$yellow: #ffed4a;[m
[32m+[m[32m$green: #38c172;[m
[32m+[m[32m$teal: #4dc0b5;[m
[32m+[m[32m$cyan: #6cb2eb;[m
[1mdiff --git a/resources/sass/app.scss b/resources/sass/app.scss[m
[1mnew file mode 100755[m
[1mindex 0000000..3193ffa[m
[1m--- /dev/null[m
[1m+++ b/resources/sass/app.scss[m
[36m@@ -0,0 +1,8 @@[m
[32m+[m[32m// Fonts[m
[32m+[m[32m@import url('https://fonts.googleapis.com/css?family=Nunito');[m
[32m+[m
[32m+[m[32m// Variables[m
[32m+[m[32m@import 'variables';[m
[32m+[m
[32m+[m[32m// Bootstrap[m
[32m+[m[32m@import '~bootstrap/scss/bootstrap';[m
[1mdiff --git a/resources/views/auth/login.blade.php b/resources/views/auth/login.blade.php[m
[1mnew file mode 100755[m
[1mindex 0000000..c12b97e[m
[1m--- /dev/null[m
[1m+++ b/resources/views/auth/login.blade.php[m
[36m@@ -0,0 +1,73 @@[m
[32m+[m[32m@extends('layouts.app')[m
[32m+[m
[32m+[m[32m@section('content')[m
[32m+[m[32m<div class="container">[m
[32m+[m[32m    <div class="row justify-content-center">[m
[32m+[m[32m        <div class="col-md-8">[m
[32m+[m[32m            <div class="card">[m
[32m+[m[32m                <div class="card-header">{{ __('Login') }}</div>[m
[32m+[m
[32m+[m[32m                <div class="card-body">[m
[32m+[m[32m                    <form method="POST" action="{{ route('login') }}">[m
[32m+[m[32m                        @csrf[m
[32m+[m
[32m+[m[32m                        <div class="form-group row">[m
[32m+[m[32m                            <label for="email" class="col-md-4 col-form-label text-md-right">{{ __('E-Mail Address') }}</label>[m
[32m+[m
[32m+[m[32m                            <div class="col-md-6">[m
[32m+[m[32m                                <input id="email" type="email" class="form-control @error('email') is-invalid @enderror" name="email" value="{{ old('email') }}" required autocomplete="email" autofocus>[m
[32m+[m
[32m+[m[32m                                @error('email')[m
[32m+[m[32m                                    <span class="invalid-feedback" role="alert">[m
[32m+[m[32m                                        <strong>{{ $message }}</strong>[m
[32m+[m[32m                                    </span>[m
[32m+[m[32m                                @enderror[m
[32m+[m[32m                            </div>[m
[32m+[m[32m                        </div>[m
[32m+[m
[32m+[m[32m                        <div class="form-group row">[m
[32m+[m[32m                            <label for="password" class="col-md-4 col-form-label text-md-right">{{ __('Password') }}</label>[m
[32m+[m
[32m+[m[32m                            <div class="col-md-6">[m
[32m+[m[32m                                <input id="password" type="password" class="form-control @error('password') is-invalid @enderror" name="password" required autocomplete="current-password">[m
[32m+[m
[32m+[m[32m                                @error('password')[m
[32m+[m[32m                                    <span class="invalid-feedback" role="alert">[m
[32m+[m[32m                                        <strong>{{ $message }}</strong>[m
[32m+[m[32m                                    </span>[m
[32m+[m[32m                                @enderror[m
[32m+[m[32m                            </div>[m
[32m+[m[32m                        </div>[m
[32m+[m
[32m+[m[32m                        <div class="form-group row">[m
[32m+[m[32m                            <div class="col-md-6 offset-md-4">[m
[32m+[m[32m                                <div class="form-check">[m
[32m+[m[32m                                    <input class="form-check-input" type="checkbox" name="remember" id="remember" {{ old('remember') ? 'checked' : '' }}>[m
[32m+[m
[32m+[m[32m                                    <label class="form-check-label" for="remember">[m
[32m+[m[32m                                        {{ __('Remember Me') }}[m
[32m+[m[32m                                    </label>[m
[32m+[m[32m                                </div>[m
[32m+[m[32m                            </div>[m
[32m+[m[32m                        </div>[m
[32m+[m
[32m+[m[32m                        <div class="form-group row mb-0">[m
[32m+[m[32m                            <div class="col-md-8 offset-md-4">[m
[32m+[m[32m                                <button type="submit" class="btn btn-primary">[m
[32m+[m[32m                                    {{ __('Login') }}[m
[32m+[m[32m                                </button>[m
[32m+[m
[32m+[m[32m                                @if (Route::has('password.request'))[m
[32m+[m[32m                                    <a class="btn btn-link" href="{{ route('password.request') }}">[m
[32m+[m[32m                                        {{ __('Forgot Your Password?') }}[m
[32m+[m[32m                                    </a>[m
[32m+[m[32m                                @endif[m
[32m+[m[32m                            </div>[m
[32m+[m[32m                        </div>[m
[32m+[m[32m                    </form>[m
[32m+[m[32m                </div>[m
[32m+[m[32m            </div>[m
[32m+[m[32m        </div>[m
[32m+[m[32m    </div>[m
[32m+[m[32m</div>[m
[32m+[m[32m@endsection[m
[1mdiff --git a/resources/views/auth/passwords/email.blade.php b/resources/views/auth/passwords/email.blade.php[m
[1mnew file mode 100755[m
[1mindex 0000000..1fea984[m
[1m--- /dev/null[m
[1m+++ b/resources/views/auth/passwords/email.blade.php[m
[36m@@ -0,0 +1,47 @@[m
[32m+[m[32m@extends('layouts.app')[m
[32m+[m
[32m+[m[32m@section('content')[m
[32m+[m[32m<div class="container">[m
[32m+[m[32m    <div class="row justify-content-center">[m
[32m+[m[32m        <div class="col-md-8">[m
[32m+[m[32m            <div class="card">[m
[32m+[m[32m                <div class="card-header">{{ __('Reset Password') }}</div>[m
[32m+[m
[32m+[m[32m                <div class="card-body">[m
[32m+[m[32m                    @if (session('status'))[m
[32m+[m[32m                        <div class="alert alert-success" role="alert">[m
[32m+[m[32m                            {{ session('status') }}[m
[32m+[m[32m                        </div>[m
[32m+[m[32m                    @endif[m
[32m+[m
[32m+[m[32m                    <form method="POST" action="{{ route('password.email') }}">[m
[32m+[m[32m                        @csrf[m
[32m+[m
[32m+[m[32m                        <div class="form-group row">[m
[32m+[m[32m                            <label for="email" class="col-md-4 col-form-label text-md-right">{{ __('E-Mail Address') }}</label>[m
[32m+[m
[32m+[m[32m                            <div class="col-md-6">[m
[32m+[m[32m                                <input id="email" type="email" class="form-control @error('email') is-invalid @enderror" name="email" value="{{ old('email') }}" required autocomplete="email" autofocus>[m
[32m+[m
[32m+[m[32m                                @error('email')[m
[32m+[m[32m                                    <span class="invalid-feedback" role="alert">[m
[32m+[m[32m                                        <strong>{{ $message }}</strong>[m
[32m+[m[32m                                    </span>[m
[32m+[m[32m                                @enderror[m
[32m+[m[32m                            </div>[m
[32m+[m[32m                        </div>[m
[32m+[m
[32m+[m[32m                        <div class="form-group row mb-0">[m
[32m+[m[32m                            <div class="col-md-6 offset-md-4">[m
[32m+[m[32m                                <button type="submit" class="btn btn-primary">[m
[32m+[m[32m                                    {{ __('Send Password Reset Link') }}[m
[32m+[m[32m                                </button>[m
[32m+[m[32m                            </div>[m
[32m+[m[32m                        </div>[m
[32m+[m[32m                    </form>[m
[32m+[m[32m                </div>[m
[32m+[m[32m            </div>[m
[32m+[m[32m        </div>[m
[32m+[m[32m    </div>[m
[32m+[m[32m</div>[m
[32m+[m[32m@endsection[m
[1mdiff --git a/resources/views/auth/passwords/reset.blade.php b/resources/views/auth/passwords/reset.blade.php[m
[1mnew file mode 100755[m
[1mindex 0000000..989931d[m
[1m--- /dev/null[m
[1m+++ b/resources/views/auth/passwords/reset.blade.php[m
[36m@@ -0,0 +1,65 @@[m
[32m+[m[32m@extends('layouts.app')[m
[32m+[m
[32m+[m[32m@section('content')[m
[32m+[m[32m<div class="container">[m
[32m+[m[32m    <div class="row justify-content-center">[m
[32m+[m[32m        <div class="col-md-8">[m
[32m+[m[32m            <div class="card">[m
[32m+[m[32m                <div class="card-header">{{ __('Reset Password') }}</div>[m
[32m+[m
[32m+[m[32m                <div class="card-body">[m
[32m+[m[32m                    <form method="POST" action="{{ route('password.update') }}">[m
[32m+[m[32m                        @csrf[m
[32m+[m
[32m+[m[32m                        <input type="hidden" name="token" value="{{ $token }}">[m
[32m+[m
[32m+[m[32m                        <div class="form-group row">[m
[32m+[m[32m                            <label for="email" class="col-md-4 col-form-label text-md-right">{{ __('E-Mail Address') }}</label>[m
[32m+[m
[32m+[m[32m                            <div class="col-md-6">[m
[32m+[m[32m                                <input id="email" type="email" class="form-control @error('email') is-invalid @enderror" name="email" value="{{ $email ?? old('email') }}" required autocomplete="email" autofocus>[m
[32m+[m
[32m+[m[32m                                @error('email')[m
[32m+[m[32m                                    <span class="invalid-feedback" role="alert">[m
[32m+[m[32m                                        <strong>{{ $message }}</strong>[m
[32m+[m[32m                                    </span>[m
[32m+[m[32m                                @enderror[m
[32m+[m[32m                            </div>[m
[32m+[m[32m                        </div>[m
[32m+[m
[32m+[m[32m                        <div class="form-group row">[m
[32m+[m[32m                            <label for="password" class="col-md-4 col-form-label text-md-right">{{ __('Password') }}</label>[m
[32m+[m
[32m+[m[32m                            <div class="col-md-6">[m
[32m+[m[32m                                <input id="password" type="password" class="form-control @error('password') is-invalid @enderror" name="password" required autocomplete="new-password">[m
[32m+[m
[32m+[m[32m                                @error('password')[m
[32m+[m[32m                                    <span class="invalid-feedback" role="alert">[m
[32m+[m[32m                                        <strong>{{ $message }}</strong>[m
[32m+[m[32m                                    </span>[m
[32m+[m[32m                                @enderror[m
[32m+[m[32m                            </div>[m
[32m+[m[32m                        </div>[m
[32m+[m
[32m+[m[32m                        <div class="form-group row">[m
[32m+[m[32m                            <label for="password-confirm" class="col-md-4 col-form-label text-md-right">{{ __('Confirm Password') }}</label>[m
[32m+[m
[32m+[m[32m                            <div class="col-md-6">[m
[32m+[m[32m                                <input id="password-confirm" type="password" class="form-control" name="password_confirmation" required autocomplete="new-password">[m
[32m+[m[32m                            </div>[m
[32m+[m[32m                        </div>[m
[32m+[m
[32m+[m[32m                        <div class="form-group row mb-0">[m
[32m+[m[32m                            <div class="col-md-6 offset-md-4">[m
[32m+[m[32m                                <button type="submit" class="btn btn-primary">[m
[32m+[m[32m                                    {{ __('Reset Password') }}[m
[32m+[m[32m                                </button>[m
[32m+[m[32m                            </div>[m
[32m+[m[32m                        </div>[m
[32m+[m[32m                    </form>[m
[32m+[m[32m                </div>[m
[32m+[m[32m            </div>[m
[32m+[m[32m        </div>[m
[32m+[m[32m    </div>[m
[32m+[m[32m</div>[m
[32m+[m[32m@endsection[m
[1mdiff --git a/resources/views/auth/register.blade.php b/resources/views/auth/register.blade.php[m
[1mnew file mode 100755[m
[1mindex 0000000..d236a48[m
[1m--- /dev/null[m
[1m+++ b/resources/views/auth/register.blade.php[m
[36m@@ -0,0 +1,77 @@[m
[32m+[m[32m@extends('layouts.app')[m
[32m+[m
[32m+[m[32m@section('content')[m
[32m+[m[32m<div class="container">[m
[32m+[m[32m    <div class="row justify-content-center">[m
[32m+[m[32m        <div class="col-md-8">[m
[32m+[m[32m            <div class="card">[m
[32m+[m[32m                <div class="card-header">{{ __('Register') }}</div>[m
[32m+[m
[32m+[m[32m                <div class="card-body">[m
[32m+[m[32m                    <form method="POST" action="{{ route('register') }}">[m
[32m+[m[32m                        @csrf[m
[32m+[m
[32m+[m[32m                        <div class="form-group row">[m
[32m+[m[32m                            <label for="name" class="col-md-4 col-form-label text-md-right">{{ __('Name') }}</label>[m
[32m+[m
[32m+[m[32m                            <div class="col-md-6">[m
[32m+[m[32m                                <input id="name" type="text" class="form-control @error('name') is-invalid @enderror" name="name" value="{{ old('name') }}" required autocomplete="name" autofocus>[m
[32m+[m
[32m+[m[32m                                @error('name')[m
[32m+[m[32m                                    <span class="invalid-feedback" role="alert">[m
[32m+[m[32m                                        <strong>{{ $message }}</strong>[m
[32m+[m[32m                                    </span>[m
[32m+[m[32m                                @enderror[m
[32m+[m[32m                            </div>[m
[32m+[m[32m                        </div>[m
[32m+[m
[32m+[m[32m                        <div class="form-group row">[m
[32m+[m[32m                            <label for="email" class="col-md-4 col-form-label text-md-right">{{ __('E-Mail Address') }}</label>[m
[32m+[m
[32m+[m[32m                            <div class="col-md-6">[m
[32m+[m[32m                                <input id="email" type="email" class="form-control @error('email') is-invalid @enderror" name="email" value="{{ old('email') }}" required autocomplete="email">[m
[32m+[m
[32m+[m[32m                                @error('email')[m
[32m+[m[32m                                    <span class="invalid-feedback" role="alert">[m
[32m+[m[32m                                        <strong>{{ $message }}</strong>[m
[32m+[m[32m                                    </span>[m
[32m+[m[32m                                @enderror[m
[32m+[m[32m                            </div>[m
[32m+[m[32m                        </div>[m
[32m+[m
[32m+[m[32m                        <div class="form-group row">[m
[32m+[m[32m                            <label for="password" class="col-md-4 col-form-label text-md-right">{{ __('Password') }}</label>[m
[32m+[m
[32m+[m[32m                            <div class="col-md-6">[m
[32m+[m[32m                                <input id="password" type="password" class="form-control @error('password') is-invalid @enderror" name="password" required autocomplete="new-password">[m
[32m+[m
[32m+[m[32m                                @error('password')[m
[32m+[m[32m                                    <span class="invalid-feedback" role="alert">[m
[32m+[m[32m                                        <strong>{{ $message }}</strong>[m
[32m+[m[32m                                    </span>[m
[32m+[m[32m                                @enderror[m
[32m+[m[32m                            </div>[m
[32m+[m[32m                        </div>[m
[32m+[m
[32m+[m[32m                        <div class="form-group row">[m
[32m+[m[32m                            <label for="password-confirm" class="col-md-4 col-form-label text-md-right">{{ __('Confirm Password') }}</label>[m
[32m+[m
[32m+[m[32m                            <div class="col-md-6">[m
[32m+[m[32m                                <input id="password-confirm" type="password" class="form-control" name="password_confirmation" required autocomplete="new-password">[m
[32m+[m[32m                            </div>[m
[32m+[m[32m                        </div>[m
[32m+[m
[32m+[m[32m                        <div class="form-group row mb-0">[m
[32m+[m[32m                            <div class="col-md-6 offset-md-4">[m
[32m+[m[32m                                <button type="submit" class="btn btn-primary">[m
[32m+[m[32m                                    {{ __('Register') }}[m
[32m+[m[32m                                </button>[m
[32m+[m[32m                            </div>[m
[32m+[m[32m                        </div>[m
[32m+[m[32m                    </form>[m
[32m+[m[32m                </div>[m
[32m+[m[32m            </div>[m
[32m+[m[32m        </div>[m
[32m+[m[32m    </div>[m
[32m+[m[32m</div>[m
[32m+[m[32m@endsection[m
[1mdiff --git a/resources/views/auth/verify.blade.php b/resources/views/auth/verify.blade.php[m
[1mnew file mode 100755[m
[1mindex 0000000..c742cb4[m
[1m--- /dev/null[m
[1m+++ b/resources/views/auth/verify.blade.php[m
[36m@@ -0,0 +1,24 @@[m
[32m+[m[32m@extends('layouts.app')[m
[32m+[m
[32m+[m[32m@section('content')[m
[32m+[m[32m<div class="container">[m
[32m+[m[32m    <div class="row justify-content-center">[m
[32m+[m[32m        <div class="col-md-8">[m
[32m+[m[32m            <div class="card">[m
[32m+[m[32m                <div class="card-header">{{ __('Verify Your Email Address') }}</div>[m
[32m+[m
[32m+[m[32m                <div class="card-body">[m
[32m+[m[32m                    @if (session('resent'))[m
[32m+[m[32m                        <div class="alert alert-success" role="alert">[m
[32m+[m[32m                            {{ __('A fresh verification link has been sent to your email address.') }}[m
[32m+[m[32m                        </div>[m
[32m+[m[32m                    @endif[m
[32m+[m
[32m+[m[32m                    {{ __('Before proceeding, please check your email for a verification link.') }}[m
[32m+[m[32m                    {{ __('If you did not receive the email') }}, <a href="{{ route('verification.resend') }}">{{ __('click here to request another') }}</a>.[m
[32m+[m[32m                </div>[m
[32m+[m[32m            </div>[m
[32m+[m[32m        </div>[m
[32m+[m[32m    </div>[m
[32m+[m[32m</div>[m
[32m+[m[32m@endsection[m
[1mdiff --git a/resources/views/home.blade.php b/resources/views/home.blade.php[m
[1mnew file mode 100755[m
[1mindex 0000000..05dfca9[m
[1m--- /dev/null[m
[1m+++ b/resources/views/home.blade.php[m
[36m@@ -0,0 +1,23 @@[m
[32m+[m[32m@extends('layouts.app')[m
[32m+[m
[32m+[m[32m@section('content')[m
[32m+[m[32m<div class="container">[m
[32m+[m[32m    <div class="row justify-content-center">[m
[32m+[m[32m        <div class="col-md-8">[m
[32m+[m[32m            <div class="card">[m
[32m+[m[32m                <div class="card-header">Dashboard</div>[m
[32m+[m
[32m+[m[32m                <div class="card-body">[m
[32m+[m[32m                    @if (session('status'))[m
[32m+[m[32m                        <div class="alert alert-success" role="alert">[m
[32m+[m[32m                            {{ session('status') }}[m
[32m+[m[32m                        </div>[m
[32m+[m[32m                    @endif[m
[32m+[m
[32m+[m[32m                    You are logged in![m
[32m+[m[32m                </div>[m
[32m+[m[32m            </div>[m
[32m+[m[32m        </div>[m
[32m+[m[32m    </div>[m
[32m+[m[32m</div>[m
[32m+[m[32m@endsection[m
[1mdiff --git a/resources/views/layouts/app.blade.php b/resources/views/layouts/app.blade.php[m
[1mnew file mode 100755[m
[1mindex 0000000..e2d2cbb[m
[1m--- /dev/null[m
[1m+++ b/resources/views/layouts/app.blade.php[m
[36m@@ -0,0 +1,80 @@[m
[32m+[m[32m<!DOCTYPE html>[m
[32m+[m[32m<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">[m
[32m+[m[32m<head>[m
[32m+[m[32m    <meta charset="utf-8">[m
[32m+[m[32m    <meta name="viewport" content="width=device-width, initial-scale=1">[m
[32m+[m
[32m+[m[32m    <!-- CSRF Token -->[m
[32m+[m[32m    <meta name="csrf-token" content="{{ csrf_token() }}">[m
[32m+[m
[32m+[m[32m    <title>{{ config('app.name', 'Laravel') }}</title>[m
[32m+[m
[32m+[m[32m    <!-- Scripts -->[m
[32m+[m[32m    <script src="{{ asset('js/app.js') }}" defer></script>[m
[32m+[m
[32m+[m[32m    <!-- Fonts -->[m
[32m+[m[32m    <link rel="dns-prefetch" href="//fonts.gstatic.com">[m
[32m+[m[32m    <link href="https://fonts.googleapis.com/css?family=Nunito" rel="stylesheet">[m
[32m+[m
[32m+[m[32m    <!-- Styles -->[m
[32m+[m[32m    <link href="{{ asset('css/app.css') }}" rel="stylesheet">[m
[32m+[m[32m</head>[m
[32m+[m[32m<body>[m
[32m+[m[32m    <div id="app">[m
[32m+[m[32m        <nav class="navbar navbar-expand-md navbar-light bg-white shadow-sm">[m
[32m+[m[32m            <div class="container">[m
[32m+[m[32m                <a class="navbar-brand" href="{{ url('/') }}">[m
[32m+[m[32m                    {{ config('app.name', 'Laravel') }}[m
[32m+[m[32m                </a>[m
[32m+[m[32m                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="{{ __('Toggle navigation') }}">[m
[32m+[m[32m                    <span class="navbar-toggler-icon"></span>[m
[32m+[m[32m                </button>[m
[32m+[m
[32m+[m[32m                <div class="collapse navbar-collapse" id="navbarSupportedContent">[m
[32m+[m[32m                    <!-- Left Side Of Navbar -->[m
[32m+[m[32m                    <ul class="navbar-nav mr-auto">[m
[32m+[m
[32m+[m[32m                    </ul>[m
[32m+[m
[32m+[m[32m                    <!-- Right Side Of Navbar -->[m
[32m+[m[32m                    <ul class="navbar-nav ml-auto">[m
[32m+[m[32m                        <!-- Authentication Links -->[m
[32m+[m[32m                        @guest[m
[32m+[m[32m                            <li class="nav-item">[m
[32m+[m[32m                                <a class="nav-link" href="{{ route('login') }}">{{ __('Login') }}</a>[m
[32m+[m[32m                            </li>[m
[32m+[m[32m                            @if (Route::has('register'))[m
[32m+[m[32m                                <li class="nav-item">[m
[32m+[m[32m                                    <a class="nav-link" href="{{ route('register') }}">{{ __('Register') }}</a>[m
[32m+[m[32m                                </li>[m
[32m+[m[32m                            @endif[m
[32m+[m[32m                        @else[m
[32m+[m[32m                            <li class="nav-item dropdown">[m
[32m+[m[32m                                <a id="navbarDropdown" class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" v-pre>[m
[32m+[m[32m                                    {{ Auth::user()->first_name }} <span class="caret"></span>[m
[32m+[m[32m                                </a>[m
[32m+[m
[32m+[m[32m                                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">[m
[32m+[m[32m                                    <a class="dropdown-item" href="{{ route('logout') }}"[m
[32m+[m[32m                                       onclick="event.preventDefault();[m
[32m+[m[32m                                                     document.getElementById('logout-form').submit();">[m
[32m+[m[32m                                        {{ __('Logout') }}[m
[32m+[m[32m                                    </a>[m
[32m+[m
[32m+[m[32m                                    <form id="logout-form" action="{{ route('logout') }}" method="POST" style="display: none;">[m
[32m+[m[32m                                        @csrf[m
[32m+[m[32m                                    </form>[m
[32m+[m[32m                                </div>[m
[32m+[m[32m                            </li>[m
[32m+[m[32m                        @endguest[m
[32m+[m[32m                    </ul>[m
[32m+[m[32m                </div>[m
[32m+[m[32m            </div>[m
[32m+[m[32m        </nav>[m
[32m+[m
[32m+[m[32m        <main class="py-4">[m
[32m+[m[32m            @yield('content')[m
[32m+[m[32m        </main>[m
[32m+[m[32m    </div>[m
[32m+[m[32m</body>[m
[32m+[m[32m</html>[m
[1mdiff --git a/resources/views/welcome.blade.php b/resources/views/welcome.blade.php[m
[1mnew file mode 100755[m
[1mindex 0000000..af1c02a[m
[1m--- /dev/null[m
[1m+++ b/resources/views/welcome.blade.php[m
[36m@@ -0,0 +1,99 @@[m
[32m+[m[32m<!DOCTYPE html>[m
[32m+[m[32m<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">[m
[32m+[m[32m    <head>[m
[32m+[m[32m        <meta charset="utf-8">[m
[32m+[m[32m        <meta name="viewport" content="width=device-width, initial-scale=1">[m
[32m+[m
[32m+[m[32m        <title>Laravel</title>[m
[32m+[m
[32m+[m[32m        <!-- Fonts -->[m
[32m+[m[32m        <link href="https://fonts.googleapis.com/css?family=Nunito:200,600" rel="stylesheet">[m
[32m+[m
[32m+[m[32m        <!-- Styles -->[m
[32m+[m[32m        <style>[m
[32m+[m[32m            html, body {[m
[32m+[m[32m                background-color: #fff;[m
[32m+[m[32m                color: #636b6f;[m
[32m+[m[32m                font-family: 'Nunito', sans-serif;[m
[32m+[m[32m                font-weight: 200;[m
[32m+[m[32m                height: 100vh;[m
[32m+[m[32m                margin: 0;[m
[32m+[m[32m            }[m
[32m+[m
[32m+[m[32m            .full-height {[m
[32m+[m[32m                height: 100vh;[m
[32m+[m[32m            }[m
[32m+[m
[32m+[m[32m            .flex-center {[m
[32m+[m[32m                align-items: center;[m
[32m+[m[32m                display: flex;[m
[32m+[m[32m                justify-content: center;[m
[32m+[m[32m            }[m
[32m+[m
[32m+[m[32m            .position-ref {[m
[32m+[m[32m                position: relative;[m
[32m+[m[32m            }[m
[32m+[m
[32m+[m[32m            .top-right {[m
[32m+[m[32m                position: absolute;[m
[32m+[m[32m                right: 10px;[m
[32m+[m[32m                top: 18px;[m
[32m+[m[32m            }[m
[32m+[m
[32m+[m[32m            .content {[m
[32m+[m[32m                text-align: center;[m
[32m+[m[32m            }[m
[32m+[m
[32m+[m[32m            .title {[m
[32m+[m[32m                font-size: 84px;[m
[32m+[m[32m            }[m
[32m+[m
[32m+[m[32m            .links > a {[m
[32m+[m[32m                color: #636b6f;[m
[32m+[m[32m                padding: 0 25px;[m
[32m+[m[32m                font-size: 13px;[m
[32m+[m[32m                font-weight: 600;[m
[32m+[m[32m                letter-spacing: .1rem;[m
[32m+[m[32m                text-decoration: none;[m
[32m+[m[32m                text-transform: uppercase;[m
[32m+[m[32m            }[m
[32m+[m
[32m+[m[32m            .m-b-md {[m
[32m+[m[32m                margin-bottom: 30px;[m
[32m+[m[32m            }[m
[32m+[m[32m        </style>[m
[32m+[m[32m    </head>[m
[32m+[m[32m    <body>[m
[32m+[m[32m        <div class="flex-center position-ref full-height">[m
[32m+[m[32m            @if (Route::has('login'))[m
[32m+[m[32m                <div class="top-right links">[m
[32m+[m[32m                    @auth[m
[32m+[m[32m                        <a href="{{ url('/home') }}">Home</a>[m
[32m+[m[32m                    @else[m
[32m+[m[32m                        <a href="{{ route('login') }}">Login</a>[m
[32m+[m
[32m+[m[32m                        @if (Route::has('register'))[m
[32m+[m[32m                            <a href="{{ route('register') }}">Register</a>[m
[32m+[m[32m                        @endif[m
[32m+[m[32m                    @endauth[m
[32m+[m[32m                </div>[m
[32m+[m[32m            @endif[m
[32m+[m
[32m+[m[32m            <div class="content">[m
[32m+[m[32m                <div class="title m-b-md">[m
[32m+[m[32m                    Laravel[m
[32m+[m[32m                </div>[m
[32m+[m
[32m+[m[32m                <div class="links">[m
[32m+[m[32m                    <a href="https://laravel.com/docs">Docs</a>[m
[32m+[m[32m                    <a href="https://laracasts.com">Laracasts</a>[m
[32m+[m[32m                    <a href="https://laravel-news.com">News</a>[m
[32m+[m[32m                    <a href="https://blog.laravel.com">Blog</a>[m
[32m+[m[32m                    <a href="https://nova.laravel.com">Nova</a>[m
[32m+[m[32m                    <a href="https://forge.laravel.com">Forge</a>[m
[32m+[m[32m                    <a href="https://github.com/laravel/laravel">GitHub</a>[m
[32m+[m[32m                </div>[m
[32m+[m[32m            </div>[m
[32m+[m[32m        </div>[m
[32m+[m[32m    </body>[m
[32m+[m[32m</html>[m
[1mdiff --git a/routes/api.php b/routes/api.php[m
[1mnew file mode 100755[m
[1mindex 0000000..71c53c1[m
[1m--- /dev/null[m
[1m+++ b/routes/api.php[m
[36m@@ -0,0 +1,28 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32muse Illuminate\Http\Request;[m
[32m+[m
[32m+[m[32m/*[m
[32m+[m[32m|--------------------------------------------------------------------------[m
[32m+[m[32m| API Routes[m
[32m+[m[32m|--------------------------------------------------------------------------[m
[32m+[m[32m|[m
[32m+[m[32m| Here is where you can register API routes for your application. These[m
[32m+[m[32m| routes are loaded by the RouteServiceProvider within a group which[m
[32m+[m[32m| is assigned the "api" middleware group. Enjoy building your API![m
[32m+[m[32m|[m
[32m+[m[32m*/[m
[32m+[m
[32m+[m[32mRoute::post('login', 'Api\AuthController');[m
[32m+[m
[32m+[m[32mRoute::middleware(['auth:api'])->group(function () {[m
[32m+[m
[32m+[m[32m    Route::apiResource('users','Api\UserController');[m
[32m+[m[32m    Route::apiResource('roles','Api\RoleController');[m
[32m+[m[32m    Route::apiResource('permissions', 'Api\PermissionController');[m
[32m+[m[32m    Route::apiResource('categories','Api\CategoryController');[m
[32m+[m[32m    Route::apiResource('articles','Api\ArticleController');[m
[32m+[m
[32m+[m[32m});[m
[32m+[m
[32m+[m
[1mdiff --git a/routes/channels.php b/routes/channels.php[m
[1mnew file mode 100755[m
[1mindex 0000000..f16a20b[m
[1m--- /dev/null[m
[1m+++ b/routes/channels.php[m
[36m@@ -0,0 +1,16 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32m/*[m
[32m+[m[32m|--------------------------------------------------------------------------[m
[32m+[m[32m| Broadcast Channels[m
[32m+[m[32m|--------------------------------------------------------------------------[m
[32m+[m[32m|[m
[32m+[m[32m| Here you may register all of the event broadcasting channels that your[m
[32m+[m[32m| application supports. The given channel authorization callbacks are[m
[32m+[m[32m| used to check if an authenticated user can listen to the channel.[m
[32m+[m[32m|[m
[32m+[m[32m*/[m
[32m+[m
[32m+[m[32mBroadcast::channel('App.User.{id}', function ($user, $id) {[m
[32m+[m[32m    return (int) $user->id === (int) $id;[m
[32m+[m[32m});[m
[1mdiff --git a/routes/console.php b/routes/console.php[m
[1mnew file mode 100755[m
[1mindex 0000000..75dd0cd[m
[1m--- /dev/null[m
[1m+++ b/routes/console.php[m
[36m@@ -0,0 +1,18 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32muse Illuminate\Foundation\Inspiring;[m
[32m+[m
[32m+[m[32m/*[m
[32m+[m[32m|--------------------------------------------------------------------------[m
[32m+[m[32m| Console Routes[m
[32m+[m[32m|--------------------------------------------------------------------------[m
[32m+[m[32m|[m
[32m+[m[32m| This file is where you may define all of your Closure based console[m
[32m+[m[32m| commands. Each Closure is bound to a command instance allowing a[m
[32m+[m[32m| simple approach to interacting with each command's IO methods.[m
[32m+[m[32m|[m
[32m+[m[32m*/[m
[32m+[m
[32m+[m[32mArtisan::command('inspire', function () {[m
[32m+[m[32m    $this->comment(Inspiring::quote());[m
[32m+[m[32m})->describe('Display an inspiring quote');[m
[1mdiff --git a/routes/web.php b/routes/web.php[m
[1mnew file mode 100755[m
[1mindex 0000000..808e2c5[m
[1m--- /dev/null[m
[1m+++ b/routes/web.php[m
[36m@@ -0,0 +1,30 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32m/*[m
[32m+[m[32m|--------------------------------------------------------------------------[m
[32m+[m[32m| Web Routes[m
[32m+[m[32m|--------------------------------------------------------------------------[m
[32m+[m[32m|[m
[32m+[m[32m| Here is where you can register web routes for your application. These[m
[32m+[m[32m| routes are loaded by the RouteServiceProvider within a group which[m
[32m+[m[32m| contains the "web" middleware group. Now create something great![m
[32m+[m[32m|[m
[32m+[m[32m*/[m
[32m+[m
[32m+[m[32mRoute::get('/', function () {[m
[32m+[m[32m    return view('welcome');[m
[32m+[m[32m});[m
[32m+[m
[32m+[m[32mAuth::routes();[m
[32m+[m
[32m+[m[32mRoute::get('/home', 'HomeController@index')->name('home');[m
[32m+[m
[32m+[m[32m/*Route::group(['middleware' => 'acl:super-admin'], function() {[m
[32m+[m
[32m+[m[32m    Route::get('/admin', function() {[m
[32m+[m
[32m+[m[32m        return 'Welcome Admin';[m
[32m+[m
[32m+[m[32m    });[m
[32m+[m
[32m+[m[32m});*/[m
[1mdiff --git a/server.php b/server.php[m
[1mnew file mode 100755[m
[1mindex 0000000..5fb6379[m
[1m--- /dev/null[m
[1m+++ b/server.php[m
[36m@@ -0,0 +1,21 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32m/**[m
[32m+[m[32m * Laravel - A PHP Framework For Web Artisans[m
[32m+[m[32m *[m
[32m+[m[32m * @package  Laravel[m
[32m+[m[32m * @author   Taylor Otwell <taylor@laravel.com>[m
[32m+[m[32m */[m
[32m+[m
[32m+[m[32m$uri = urldecode([m
[32m+[m[32m    parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH)[m
[32m+[m[32m);[m
[32m+[m
[32m+[m[32m// This file allows us to emulate Apache's "mod_rewrite" functionality from the[m
[32m+[m[32m// built-in PHP web server. This provides a convenient way to test a Laravel[m
[32m+[m[32m// application without having installed a "real" web server software here.[m
[32m+[m[32mif ($uri !== '/' && file_exists(__DIR__.'/public'.$uri)) {[m
[32m+[m[32m    return false;[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mrequire_once __DIR__.'/public/index.php';[m
[1mdiff --git a/storage/app/.gitignore b/storage/app/.gitignore[m
[1mnew file mode 100755[m
[1mindex 0000000..8f4803c[m
[1m--- /dev/null[m
[1m+++ b/storage/app/.gitignore[m
[36m@@ -0,0 +1,3 @@[m
[32m+[m[32m*[m
[32m+[m[32m!public/[m
[32m+[m[32m!.gitignore[m
[1mdiff --git a/storage/app/public/.gitignore b/storage/app/public/.gitignore[m
[1mnew file mode 100755[m
[1mindex 0000000..d6b7ef3[m
[1m--- /dev/null[m
[1m+++ b/storage/app/public/.gitignore[m
[36m@@ -0,0 +1,2 @@[m
[32m+[m[32m*[m
[32m+[m[32m!.gitignore[m
[1mdiff --git a/storage/framework/.gitignore b/storage/framework/.gitignore[m
[1mnew file mode 100755[m
[1mindex 0000000..b02b700[m
[1m--- /dev/null[m
[1m+++ b/storage/framework/.gitignore[m
[36m@@ -0,0 +1,8 @@[m
[32m+[m[32mconfig.php[m
[32m+[m[32mroutes.php[m
[32m+[m[32mschedule-*[m
[32m+[m[32mcompiled.php[m
[32m+[m[32mservices.json[m
[32m+[m[32mevents.scanned.php[m
[32m+[m[32mroutes.scanned.php[m
[32m+[m[32mdown[m
[1mdiff --git a/storage/framework/cache/.gitignore b/storage/framework/cache/.gitignore[m
[1mnew file mode 100755[m
[1mindex 0000000..01e4a6c[m
[1m--- /dev/null[m
[1m+++ b/storage/framework/cache/.gitignore[m
[36m@@ -0,0 +1,3 @@[m
[32m+[m[32m*[m
[32m+[m[32m!data/[m
[32m+[m[32m!.gitignore[m
[1mdiff --git a/storage/framework/cache/data/.gitignore b/storage/framework/cache/data/.gitignore[m
[1mnew file mode 100755[m
[1mindex 0000000..d6b7ef3[m
[1m--- /dev/null[m
[1m+++ b/storage/framework/cache/data/.gitignore[m
[36m@@ -0,0 +1,2 @@[m
[32m+[m[32m*[m
[32m+[m[32m!.gitignore[m
[1mdiff --git a/storage/framework/sessions/.gitignore b/storage/framework/sessions/.gitignore[m
[1mnew file mode 100755[m
[1mindex 0000000..d6b7ef3[m
[1m--- /dev/null[m
[1m+++ b/storage/framework/sessions/.gitignore[m
[36m@@ -0,0 +1,2 @@[m
[32m+[m[32m*[m
[32m+[m[32m!.gitignore[m
[1mdiff --git a/storage/framework/testing/.gitignore b/storage/framework/testing/.gitignore[m
[1mnew file mode 100755[m
[1mindex 0000000..d6b7ef3[m
[1m--- /dev/null[m
[1m+++ b/storage/framework/testing/.gitignore[m
[36m@@ -0,0 +1,2 @@[m
[32m+[m[32m*[m
[32m+[m[32m!.gitignore[m
[1mdiff --git a/storage/framework/views/.gitignore b/storage/framework/views/.gitignore[m
[1mnew file mode 100755[m
[1mindex 0000000..d6b7ef3[m
[1m--- /dev/null[m
[1m+++ b/storage/framework/views/.gitignore[m
[36m@@ -0,0 +1,2 @@[m
[32m+[m[32m*[m
[32m+[m[32m!.gitignore[m
[1mdiff --git a/storage/logs/.gitignore b/storage/logs/.gitignore[m
[1mnew file mode 100755[m
[1mindex 0000000..d6b7ef3[m
[1m--- /dev/null[m
[1m+++ b/storage/logs/.gitignore[m
[36m@@ -0,0 +1,2 @@[m
[32m+[m[32m*[m
[32m+[m[32m!.gitignore[m
[1mdiff --git a/tests/CreatesApplication.php b/tests/CreatesApplication.php[m
[1mnew file mode 100755[m
[1mindex 0000000..547152f[m
[1m--- /dev/null[m
[1m+++ b/tests/CreatesApplication.php[m
[36m@@ -0,0 +1,22 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace Tests;[m
[32m+[m
[32m+[m[32muse Illuminate\Contracts\Console\Kernel;[m
[32m+[m
[32m+[m[32mtrait CreatesApplication[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * Creates the application.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return \Illuminate\Foundation\Application[m
[32m+[m[32m     */[m
[32m+[m[32m    public function createApplication()[m
[32m+[m[32m    {[m
[32m+[m[32m        $app = require __DIR__.'/../bootstrap/app.php';[m
[32m+[m
[32m+[m[32m        $app->make(Kernel::class)->bootstrap();[m
[32m+[m
[32m+[m[32m        return $app;[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/tests/Feature/ExampleTest.php b/tests/Feature/ExampleTest.php[m
[1mnew file mode 100755[m
[1mindex 0000000..f31e495[m
[1m--- /dev/null[m
[1m+++ b/tests/Feature/ExampleTest.php[m
[36m@@ -0,0 +1,21 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace Tests\Feature;[m
[32m+[m
[32m+[m[32muse Tests\TestCase;[m
[32m+[m[32muse Illuminate\Foundation\Testing\RefreshDatabase;[m
[32m+[m
[32m+[m[32mclass ExampleTest extends TestCase[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * A basic test example.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function testBasicTest()[m
[32m+[m[32m    {[m
[32m+[m[32m        $response = $this->get('/');[m
[32m+[m
[32m+[m[32m        $response->assertStatus(200);[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/tests/TestCase.php b/tests/TestCase.php[m
[1mnew file mode 100755[m
[1mindex 0000000..2932d4a[m
[1m--- /dev/null[m
[1m+++ b/tests/TestCase.php[m
[36m@@ -0,0 +1,10 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace Tests;[m
[32m+[m
[32m+[m[32muse Illuminate\Foundation\Testing\TestCase as BaseTestCase;[m
[32m+[m
[32m+[m[32mabstract class TestCase extends BaseTestCase[m
[32m+[m[32m{[m
[32m+[m[32m    use CreatesApplication;[m
[32m+[m[32m}[m
[1mdiff --git a/tests/Unit/ExampleTest.php b/tests/Unit/ExampleTest.php[m
[1mnew file mode 100755[m
[1mindex 0000000..e9fe19c[m
[1m--- /dev/null[m
[1m+++ b/tests/Unit/ExampleTest.php[m
[36m@@ -0,0 +1,19 @@[m
[32m+[m[32m<?php[m
[32m+[m
[32m+[m[32mnamespace Tests\Unit;[m
[32m+[m
[32m+[m[32muse Tests\TestCase;[m
[32m+[m[32muse Illuminate\Foundation\Testing\RefreshDatabase;[m
[32m+[m
[32m+[m[32mclass ExampleTest extends TestCase[m
[32m+[m[32m{[m
[32m+[m[32m    /**[m
[32m+[m[32m     * A basic test example.[m
[32m+[m[32m     *[m
[32m+[m[32m     * @return void[m
[32m+[m[32m     */[m
[32m+[m[32m    public function testBasicTest()[m
[32m+[m[32m    {[m
[32m+[m[32m        $this->assertTrue(true);[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[1mdiff --git a/webpack.mix.js b/webpack.mix.js[m
[1mnew file mode 100755[m
[1mindex 0000000..8a923cb[m
[1m--- /dev/null[m
[1m+++ b/webpack.mix.js[m
[36m@@ -0,0 +1,15 @@[m
[32m+[m[32mconst mix = require('laravel-mix');[m
[32m+[m
[32m+[m[32m/*[m
[32m+[m[32m |--------------------------------------------------------------------------[m
[32m+[m[32m | Mix Asset Management[m
[32m+[m[32m |--------------------------------------------------------------------------[m
[32m+[m[32m |[m
[32m+[m[32m | Mix provides a clean, fluent API for defining some Webpack build steps[m
[32m+[m[32m | for your Laravel application. By default, we are compiling the Sass[m
[32m+[m[32m | file for the application as well as bundling up all the JS files.[m
[32m+[m[32m |[m
[32m+[m[32m */[m
[32m+[m
[32m+[m[32mmix.js('resources/js/app.js', 'public/js')[m
[32m+[m[32m    .sass('resources/sass/app.scss', 'public/css');[m