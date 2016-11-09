<div class="col-md-12" style="border: 1px solid black; padding-top: 20px; margin-bottom: 15px">

    <div class="col-md-9">
        <form class="form-horizontal">
            <g:each in="${campaign.comments}" var="comment">
                <div class="form-group">
                    <label class="col-sm-2 control-label">Comment</label>
                    <div class="col-sm-10">
                        <p class="form-control-static">${comment.comment}</p>

                    </div>
                    <label class="col-sm-2 control-label">Author</label>
                    <div class="col-sm-10">
                        <p class="form-control-static">${comment.author.username}</p>

                    </div>
                </div>
            </g:each>
        </form>
    </div>
</div>