<?php


namespace App\Services;


use App\Helpers\Helper;
use App\Models\Banner;
use App\Models\Media;
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

//        return $request->banner_file;

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

        DB::beginTransaction();

        try {

            $result_array = explode(",",$input['role_id']);

            if (in_array('1',$result_array)){
                $this->bannerRepository->create($input);
            }else{
                array_push($result_array,'1');
                $input['role_id'] = implode(',',$result_array);
                $this->bannerRepository->create($input);
            }

//            $this->bannerRepository->create($input);

            $banner = $this->bannerRepository->get($input['id']);

            if($request->hasFile('banner_file')) {

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


    public function getById($id){

        if ($this->bannerRepository->get($id)){
            return response()->json([
                'status_code'  => 200,
                'messages'     => config('status.status_code.200'),
                'banner_info' => $this->bannerRepository->get($id)
            ]);
        }else{
            return response()->json([
                'status_code'  => 200,
                'messages'     => config('status.status_code.200'),
                'banner_info' => "Data not found"
            ]);
        }
    }

    public function updateItem($request){

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

        DB::beginTransaction();

        try {

            $result_array = explode(",",$input['role_id']);

            if (in_array('1',$result_array)){
                $this->bannerRepository->update($input);
            }else{
                array_push($result_array,'1');
                $input['role_id'] = implode(',',$result_array);
                $this->bannerRepository->update($input);
            }

            if($request->hasFile('banner_file')) {

                $media= Media::where('mediable_id', $request->id)->first();

                if ($media){
                    $mediaName =  substr($media->url, strpos($media->url, "media") );
                    unlink(public_path().'/'.$mediaName );
                    $media->url = Helper::base64PageLogoUpload("banner/files", $request->banner_file);
                    $media->save();
                }
            }

        } catch (Exception $e) {

            DB::rollBack();
            Log::error('Found Exception: ' . $e->getMessage() . ' [Script: ' . __CLASS__ . '@' . __FUNCTION__ . '] [Origin: ' . $e->getFile() . '-' . $e->getLine() . ']');

            return response()->json([
                'status_code' => 424,
                'messages'=>config('status.status_code.424'),
                'error' => $e->getMessage()
            ]);
        }

        DB::commit();

        return response()->json([
            'status_code' => 200,
            'messages'=>config('status.status_code.200'),
        ]);
    }

    public function deleteItem($id){

        DB::beginTransaction();


        try {

            $this->bannerRepository->delete($id);

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

        return response()->json([

            'status_code' => 200,
            'messages'    => "Banner Deleted Successfully"

        ]);
    }


    public function roleBanners($request){

        return response()->json([

                'status_code'   => 200,
                'messages'      => config('status.status_code.200'),
                'banner_list' => $this->bannerRepository->getRoleBanners($request)

        ]);
    }

}