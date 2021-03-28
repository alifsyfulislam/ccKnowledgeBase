<?php


namespace App\Services;


use App\Helpers\Helper;
use App\Repositories\BannerRepository;
use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;

class BannerService
{

    /**
     * @var CategoryRepository
     */
    protected $bannerRepository;


    /**
     * CategoryService constructor.
     * @param CategoryRepository $categoryRepository
     */
    public function __construct(BannerRepository $bannerRepository)
    {
        $this->bannerRepository = $bannerRepository;
    }

    public function paginateData()
    {
        return response()->json([
            'status_code'   => 200,
            'messages'      => config('status.status_code.200'),
            'banner_list' => $this->bannerRepository->getWithPagination()]);

    }

    public function createItem($request)
    {

        $validator = Validator::make($request->all(),[

            'title' => 'required|min:3|max:200',
            'role_id' => 'required'

        ]);

        if($validator->fails()) {
            return response()->json([
                'status_code' => 400,
                'messages'    => config('status.status_code.400'),
                'errors'      => $validator->errors()->all()
            ]);

        }

        $input = $request->all();
        $input['id'] = time().rand(1000,9000);
//        dd($request);

//        dd($input);

        DB::beginTransaction();

        try {

            $this->bannerRepository->create($input);

            $banner = $this->bannerRepository->get($input['id']);

            if($request->hasFile('banner_file')) {

//                dd($request->banner_file);

                $banner_url  = Helper::base64PageLogoUpload("banner/files", $request->banner_file);

                $banner->media()->create([

                    'url' => $banner_url

                ]);
            }

        } catch (Exception $e) {

            DB::rollBack();

            Log::error('Found Exception: ' . $e->getMessage() . ' [Script: ' . __CLASS__ . '@' . __FUNCTION__ . '] [Origin: ' . $e->getFile() . '-' . $e->getLine() . ']');

            return response()->json([
                'status_code' => 424,
                'messages'    => config('status.status_code.424'),
                'error'       => $e->getMessage()
            ]);
        }

        DB::commit();

        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200')]);

    }

}